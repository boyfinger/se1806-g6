package common;

import dal.UserDAO;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import model.User;

public class AvatarHandler {

    UserDAO userDAO = new UserDAO();

    private void removeOldAvatar(String oldUri, String workingDir) {
        String uri = workingDir + "\\" + oldUri.replace("/", "\\");
        File file = new File(uri);
        System.out.println(uri);
        if (file.exists()) {
            file.delete();
        }
    }

    private void deleteOldAvatar(String oldUri, String workingDir) {
        if (!userDAO.isAvtExist(oldUri) && !oldUri.equals("assets/img/default_avt.jpg")
                && oldUri != null && !oldUri.isEmpty()) {
            removeOldAvatar(oldUri, workingDir);
        }
    }

    public void changeAvatar(int userId, String workingFolder, String workingDir,
            Part filePart) throws IOException, SQLException {

        FileHandler fileHandler = new FileHandler(workingFolder);
        String uri = fileHandler.fileUpload(workingDir, filePart);
        uri = ("" + uri).replace("\\", "/");

        User u = userDAO.getUserById(userId);
        String oldUri = u.getAvatar();
        System.out.println(oldUri);
        deleteOldAvatar(oldUri, workingDir);

        u.setAvatar(uri);
        userDAO.updateAvatar(u);
    }

    public String uploadAvatar(String workingFolder, String workingDir, Part filePart, String oldUri)
            throws IOException {
        FileHandler fileHandler = new FileHandler(workingFolder);
        String uri = fileHandler.fileUpload(workingDir, filePart);
        uri = ("" + uri).replace("\\", "/");
        deleteOldAvatar(oldUri, workingDir);
        return uri;
    }

}
