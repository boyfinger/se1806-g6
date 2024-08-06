package mail;

import java.security.SecureRandom;

public class GenerateVerifyCode {
    public static String GenerateCode() {
        SecureRandom random = new SecureRandom();
        int code = random.nextInt(1000000); // Generates a random number between 0 and 999999
        return String.format("%06d", code); // Formats the code to ensure it has 6 digits
    }

}
