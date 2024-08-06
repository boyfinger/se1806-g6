package model.google;

/**
 * Holds the constants for Google OAuth2 integration.
 * Ensure these values are kept secure and not exposed in public repositories.
 */
public class GoogleConstants {

    public static final String GOOGLE_CLIENT_ID = "171297613501-4mh2hqqpi5keion3735v26ik0pe4b9lk.apps.googleusercontent.com";
    public static final String GOOGLE_CLIENT_SECRET = "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";
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/se1808-g6/login-google";
    public static final String GOOGLE_LOGIN_URL = "https://accounts.google.com/o/oauth2/auth?scope=email&" +
            "redirect_uri=" + GOOGLE_REDIRECT_URI + "&response_type=code" +
            "&client_id=" + GOOGLE_CLIENT_ID + "&approval_prompt=force";
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
}
