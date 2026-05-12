package com.artopia1.utils;

public final class WebUtil {

    private WebUtil() {}

    /** Escape for use inside a JavaScript single-quoted string. */
    public static String escapeJs(String s) {
        if (s == null) {
            return "";
        }
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '\\' -> b.append("\\\\");
                case '\'' -> b.append("\\'");
                case '\n', '\r' -> b.append(' ');
                default -> b.append(c);
            }
        }
        return b.toString();
    }
}
