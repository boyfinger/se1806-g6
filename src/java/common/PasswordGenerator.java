package common;

import java.util.Random;

public class PasswordGenerator {

    public static String generateRandomPassword() {
        Random random = new Random();
        int length = random.nextInt(12, 32);
        byte[] byteList = new byte[length];
        for (int i = 0; i < length; i++) {
            byte b = (byte) random.nextInt(33, 127);
            byteList[i] = b;
        }
        String password = new String(byteList);
        return password;
    }

}
