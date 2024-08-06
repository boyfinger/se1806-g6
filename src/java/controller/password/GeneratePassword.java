package controller.password;
import java.security.SecureRandom;


public class GeneratePassword {

    public static class PasswordGenerator {
        // Define the characters to be used in the password
        private static final String UPPERCASE_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        private static final String LOWERCASE_LETTERS = "abcdefghijklmnopqrstuvwxyz";
        private static final String NUMBERS = "0123456789";
        private static final String ALL_CHARACTERS = UPPERCASE_LETTERS + LOWERCASE_LETTERS + NUMBERS;
        private static final int PASSWORD_LENGTH = 8;

        public static void main(String[] args) {
            System.out.println("Generated Password: " + generatePassword());
        }

        /**
         * Generates a random password of length 8 including uppercase letters, lowercase letters, and numbers.
         *
         * @return the generated password
         */
        public static String generatePassword() {
            SecureRandom random = new SecureRandom();
            StringBuilder password = new StringBuilder(PASSWORD_LENGTH);

            // Ensure the password contains at least one uppercase letter, one lowercase letter, and one number
            password.append(UPPERCASE_LETTERS.charAt(random.nextInt(UPPERCASE_LETTERS.length())));
            password.append(LOWERCASE_LETTERS.charAt(random.nextInt(LOWERCASE_LETTERS.length())));
            password.append(NUMBERS.charAt(random.nextInt(NUMBERS.length())));

            // Fill the rest of the password length with random characters from all sets
            for (int i = 3; i < PASSWORD_LENGTH; i++) {
                password.append(ALL_CHARACTERS.charAt(random.nextInt(ALL_CHARACTERS.length())));
            }

            // Shuffle the characters in the password to ensure randomness
            return shuffleString(password.toString());
        }

        /**
         * Shuffles the characters of a string randomly.
         *
         * @param input the input string
         * @return the shuffled string
         */
        private static String shuffleString(String input) {
            SecureRandom random = new SecureRandom();
            char[] a = input.toCharArray();

            for (int i = 0; i < a.length; i++) {
                int j = random.nextInt(a.length);
                // Swap a[i] and a[j]
                char temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }

            return new String(a);
        }
    }
}

