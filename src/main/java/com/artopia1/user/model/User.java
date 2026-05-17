package com.artopia1.user.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public User(int id, String name, String email, String password, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public User(String name, String email, String password, String role ){
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }
    // this code acts as the helper for jsp
    public String getInitial() {
        return (name != null && !name.isEmpty())
                ? String.valueOf(name.charAt(0)).toUpperCase()
                : "?";
    }

    public String getRoleCssClass() {
        if (role == null) return "buyer-role";
        return switch (role.toLowerCase()) {
            case "admin"  -> "admin-role";
            case "artist" -> "artist-role";
            default       -> "buyer-role";
        };
    }
}
}