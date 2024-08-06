package common;

import jakarta.servlet.http.Part;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class FileHandler {

    private final String workingFolder;

    public FileHandler(String workingFolder) {
        this.workingFolder = workingFolder;
    }

    public boolean isSameContent(String uri, Part part) throws IOException {
        File file = new File(uri);

        BufferedInputStream fis1 = new BufferedInputStream(new FileInputStream(file));
        BufferedInputStream fis2 = new BufferedInputStream(part.getInputStream());

        int ch = 0;
        while ((ch = fis1.read()) != -1) {
            if (ch != fis2.read()) {
                fis1.close();
                fis2.close();
                return false;
            }
        }

        int lastBit = fis2.read();

        fis1.close();
        fis2.close();

        return lastBit == -1;

    }

    private String getNewFileNameWhenFileExists(String uploadPath, String fileName, Part part) throws IOException {
        int extra = 0;
        String[] parts = fileName.split("[.]");
        String newFileName, uri, extraPart;

        while (true) {
            extra++;
            newFileName = parts[0];
            for (int i = 1; i < parts.length - 1; i++) {
                newFileName = newFileName + "." + parts[i];
            }
            if (extra == 1) {
                extraPart = "";
            } else {
                extraPart = "(" + extra + ")";
            }
            newFileName = newFileName + extraPart + "." + parts[parts.length - 1];
            uri = uploadPath + File.separator + newFileName;
            if (!isFileExists(uri)) {
                return newFileName;
            } else {
                if (isSameContent(uri, part)) {
                    return newFileName;
                }
            }
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "testfile";
    }

    private boolean isFileExists(String uri) {
        File file = new File(uri);
        return file.exists();
    }

    private void upload(String uploadPath, String fileName, Part part) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String uri = uploadPath + File.separator + fileName;
        part.write(uri);
    }

    public String fileUpload(String workingDir, Part part) throws IOException {
        String fileName = getFileName(part);
        String uploadPath = workingDir.concat(workingFolder);
        String uri = uploadPath + File.separator + fileName;

        if (isFileExists(uri)) {
            fileName = getNewFileNameWhenFileExists(uploadPath, fileName, part);
        }

        uri = uploadPath + File.separator + fileName;
        if (!isFileExists(uri)) {
            upload(uploadPath, fileName, part);
        }

        return workingFolder + File.separator + fileName;
    }

}
