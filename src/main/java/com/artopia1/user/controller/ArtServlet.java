package com.artopia1.user.controller;

import com.artopia1.user.model.User;
import com.artopia1.user.model.dao.ArtDAO;
import com.artopia1.user.model.dao.UserDAO;
import com.artopia1.utils.CsrfUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet(urlPatterns = {"/art/add", "/art/update", "/art/delete"})
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024,
        fileSizeThreshold = 0
)
public class ArtServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ArtDAO artDAO = new ArtDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        String role = session != null ? (String) session.getAttribute("userRole") : "";

        String ctx = request.getContextPath();
        if (user == null || !"artist".equalsIgnoreCase(role)) {
            response.sendRedirect(ctx + "/views/public/login.jsp");
            return;
        }

        if (!CsrfUtil.validate(session, request.getParameter("csrfToken"))) {
            session.setAttribute("galleryFlashErr", "Security check failed. Please refresh the page and try again.");
            response.sendRedirect(ctx + "/artist/gallery");
            return;
        }

        String path = request.getServletPath();
        try {
            if ("/art/add".equals(path)) {
                handleAdd(request, user);
            } else if ("/art/update".equals(path)) {
                handleUpdate(request, user);
            } else if ("/art/delete".equals(path)) {
                handleDelete(request, user);
            }
        } catch (Exception ex) {
            session.setAttribute("galleryFlashErr", "Could not complete the request.");
            ex.printStackTrace();
        }

        response.sendRedirect(ctx + "/artist/gallery");
    }

    private void handleAdd(HttpServletRequest request, User user) throws Exception {
        HttpSession session = request.getSession();
        User artist = refreshSessionUserIfMissingId(session, user);
        if (artist.getId() <= 0) {
            session.setAttribute("galleryFlashErr",
                    "Your account id is missing. Log out, log in again, then try adding the artwork.");
            return;
        }

        String title = trim(request.getParameter("title"));
        String description = request.getParameter("description");
        String category = trim(request.getParameter("category"));
        String priceRaw = request.getParameter("price");
        Part imagePart = request.getPart("image");

        if (title.isEmpty() || category.isEmpty() || imagePart == null || imagePart.getSize() == 0) {
            session.setAttribute("galleryFlashErr", "Please fill all required fields and choose an image.");
            return;
        }

        double price = parsePrice(priceRaw);
        String fileName = storeUploadedImage(request, imagePart);
        if (fileName == null) {
            session.setAttribute("galleryFlashErr", "Invalid image. Use JPEG, PNG, or WebP (max 5 MB).");
            return;
        }

        int id = artDAO.insert(artist.getId(), title, description, category, price, fileName);
        if (id > 0) {
            session.setAttribute("galleryFlashOk", "Artwork published.");
        } else {
            session.setAttribute("galleryFlashErr", friendlyInsertFailure(ArtDAO.takeLastInsertError()));
        }
    }

    /**
     * Old sessions may hold a User with id=0. Reload from DB by email so artist_id is valid for FK inserts.
     */
    private User refreshSessionUserIfMissingId(HttpSession session, User user) {
        if (user == null) {
            return user;
        }
        if (user.getId() > 0) {
            return user;
        }
        String email = user.getEmail();
        if (email == null || email.isBlank()) {
            return user;
        }
        User row = userDAO.findByEmail(email.trim());
        if (row != null && row.getId() > 0) {
            User refreshed = new User(row.getId(), row.getName(), row.getEmail(), null, row.getRole());
            session.setAttribute("user", refreshed);
            session.setAttribute("userRole", row.getRole() != null ? row.getRole().toLowerCase() : "");
            session.setAttribute("userName", row.getName());
            return refreshed;
        }
        return user;
    }

    private static String friendlyInsertFailure(String raw) {
        if (raw == null || raw.isBlank()) {
            return "Could not save artwork. Check MySQL is running and the `art` table matches schema.sql.";
        }
        String m = raw.toLowerCase();
        if (m.contains("unknown column") || m.contains("doesn't exist")) {
            return "Database table `art` is missing or outdated. Run src/main/resources/schema.sql on your `artopia` database (or add missing columns), then try again.";
        }
        if (m.contains("foreign key") || m.contains("cannot add or update a child row")) {
            return "Could not link artwork to your account. Log out, log in again, then retry.";
        }
        if (m.contains("communications link failure") || m.contains("connection refused") || m.contains("could not create connection")) {
            return "Cannot reach MySQL. Start MySQL and check DB URL, user, and password in DBConnection.java.";
        }
        return "Could not save artwork. Details: " + raw;
    }

    private void handleUpdate(HttpServletRequest request, User user) throws Exception {
        HttpSession session = request.getSession();
        User artist = refreshSessionUserIfMissingId(session, user);
        int artId = parseInt(request.getParameter("artId"), -1);
        if (artId <= 0) {
            session.setAttribute("galleryFlashErr", "Invalid artwork.");
            return;
        }

        String title = trim(request.getParameter("title"));
        String description = request.getParameter("description");
        String category = trim(request.getParameter("category"));
        String priceRaw = request.getParameter("price");
        Part imagePart = request.getPart("image");

        double price = parsePrice(priceRaw);
        String newFile = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            newFile = storeUploadedImage(request, imagePart);
            if (newFile == null) {
                session.setAttribute("galleryFlashErr", "Invalid image format.");
                return;
            }
        }

        boolean ok = artDAO.update(artId, artist.getId(), title, description, category, price, newFile);
        session.setAttribute(ok ? "galleryFlashOk" : "galleryFlashErr",
                ok ? "Artwork updated." : "Could not update artwork (not found or not yours).");
    }

    private void handleDelete(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        User artist = refreshSessionUserIfMissingId(session, user);
        int artId = parseInt(request.getParameter("artId"), -1);
        if (artId <= 0) {
            session.setAttribute("galleryFlashErr", "Invalid artwork.");
            return;
        }
        boolean ok = artDAO.delete(artId, artist.getId());
        session.setAttribute(ok ? "galleryFlashOk" : "galleryFlashErr",
                ok ? "Artwork removed." : "Could not delete artwork.");
    }

    private Path resolveUploadDir(HttpServletRequest request) {
        String real = request.getServletContext().getRealPath("/images/art");
        if (real != null) {
            return Path.of(real);
        }
        return Path.of(System.getProperty("java.io.tmpdir"), "artopia-art");
    }

    private String storeUploadedImage(HttpServletRequest request, Part part) throws Exception {
        String submitted = part.getSubmittedFileName();
        String ext = extensionOf(submitted);
        if (ext == null) {
            return null;
        }
        String ct = part.getContentType();
        if (!acceptsImageContentType(ct, ext)) {
            return null;
        }

        String name = UUID.randomUUID() + "." + ext;
        Path dir = resolveUploadDir(request);
        Files.createDirectories(dir);
        Path target = dir.resolve(name);
        try (InputStream in = part.getInputStream()) {
            Files.copy(in, target, StandardCopyOption.REPLACE_EXISTING);
        }
        return name;
    }

    /** Some browsers send octet-stream or omit Content-Type for uploads; trust extension if it is a known image type. */
    private static boolean acceptsImageContentType(String contentType, String normalizedExt) {
        if (normalizedExt == null) {
            return false;
        }
        if (contentType == null || contentType.isBlank()) {
            return true;
        }
        String c = contentType.toLowerCase();
        if (c.contains("jpeg") || c.contains("jpg") || c.contains("png") || c.contains("webp")) {
            return true;
        }
        return c.contains("octet-stream");
    }

    private static String extensionOf(String submitted) {
        if (submitted == null || !submitted.contains(".")) {
            return null;
        }
        String e = submitted.substring(submitted.lastIndexOf('.') + 1).toLowerCase();
        return switch (e) {
            case "jpg", "jpeg" -> "jpg";
            case "png" -> "png";
            case "webp" -> "webp";
            default -> null;
        };
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }

    private static double parsePrice(String raw) {
        if (raw == null || raw.isBlank()) {
            return 0;
        }
        try {
            return Double.parseDouble(raw.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private static int parseInt(String raw, int dflt) {
        if (raw == null || raw.isBlank()) {
            return dflt;
        }
        try {
            return Integer.parseInt(raw.trim());
        } catch (NumberFormatException e) {
            return dflt;
        }
    }
}
