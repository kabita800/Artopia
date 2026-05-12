package com.artopia1.utils;

import jakarta.servlet.http.HttpSession;

import java.util.UUID;

public final class CsrfUtil {

    public static final String SESSION_ATTR = "csrfToken";

    private CsrfUtil() {}

    public static String ensureToken(HttpSession session) {
        Object existing = session.getAttribute(SESSION_ATTR);
        if (existing instanceof String s && !s.isEmpty()) {
            return s;
        }
        String token = UUID.randomUUID().toString();
        session.setAttribute(SESSION_ATTR, token);
        return token;
    }

    public static boolean validate(HttpSession session, String submitted) {
        if (submitted == null || submitted.isEmpty()) {
            return false;
        }
        Object expected = session.getAttribute(SESSION_ATTR);
        return expected instanceof String s && s.equals(submitted);
    }
}
