package com.review.service.animal;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;


@Service
public class FileUploadService {

    @Value("${file.upload.path}")
    private String filePath;

    public void saveFiles(List<MultipartFile> files, String directory) {
        String finalDir = filePath + directory;
        createDirectoryIfNotExist(finalDir);

        for (MultipartFile file : files) {
            saveFile(file, finalDir);
            // 추가적인 파일 처리 로직을 수행할 수 있음
        }
    }

    private void saveFile(MultipartFile file, String dir) {
        try {
            String filePath = dir + "\\" + file.getOriginalFilename();
            byte[] bytes = file.getBytes();
            Path path = Paths.get(filePath);
            Files.write(path, bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void createDirectoryIfNotExist(String dirPath) {
        File directory = new File(dirPath);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
}
