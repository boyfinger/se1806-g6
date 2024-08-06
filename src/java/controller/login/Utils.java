package controller.login;

import jakarta.servlet.http.HttpServletRequest;

public class Utils {

    public static String getAttribute(HttpServletRequest request, String attributeName) {
        Object attr = request.getAttribute(attributeName);
        return (attr != null) ? attr.toString() : "N/A";
    }
}
