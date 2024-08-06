package common;

import dal.MaterialDAO;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import model.Material;

public class MaterialHandler {

    static MaterialDAO materialDAO = new MaterialDAO();

    private static void removeMaterialFile(String workingDir, String uri) {
        File file = new File(workingDir + "\\" + uri.replace("/", "\\"));
        if (file.exists()) {
            file.delete();
        }
    }

    public static void addMaterial(int lessonId, String workingFolder,
            String workingDir, Part filePart)
            throws IOException, SQLException {
        FileHandler fileHandler = new FileHandler(workingFolder);
        String uri = fileHandler.fileUpload(workingDir, filePart);
        uri = ("" + uri).replace("\\", "/");

        if (!materialDAO.isMaterialExist(lessonId, uri)) {
            materialDAO.insertMaterial(lessonId, uri);
        }
    }

    public static void removeMaterial(int lessonId, int materialId, String workingDir) throws SQLException {
        materialDAO.removeFromMaterial_Lesson(lessonId, materialId);
        if (!materialDAO.isMaterialUsed(materialId)) {
            Material m = materialDAO.getMaterialMatchId(materialId);
            if (m != null) {
                materialDAO.removeMaterial(m);
                removeMaterialFile(workingDir, m.getUri());
            }
        }
    }

}
