package com.review.util;

import com.review.dto.animal.*;
import com.review.repository.animal.AnimalMedicalReviewRepository;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Log4j
@Component
@PropertySource("classpath:globals.properties")
public class FileUtils2 {

    private static final Logger logger = LoggerFactory.getLogger(FileUtils.class);

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalReviewRepository repository;

    @Value("${file.upload.path}")
    private String filePath;

    public List<Map<String, Object>> parseInsertFileInfo(Object object, List<MultipartFile> mpFiles, String folderNm) throws IOException {

        String finalFolderNm = (folderNm == null || "".equals(folderNm)) ? "file" : folderNm;
        System.out.println("folderNm = " + finalFolderNm);

        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;

        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> listMap = null;

        int all_number;

        if (object instanceof AnimalReviewDTO) {
            AnimalReviewDTO reviewDTO = (AnimalReviewDTO) object;
            all_number = reviewDTO.getReviewNum();
        } else if (object instanceof AnimalPopUpDTO) {
            AnimalPopUpDTO animalPopUpDTO = (AnimalPopUpDTO) object;
            all_number = animalPopUpDTO.getId();
        } else if (object instanceof AnimalAdoptionDTO) {
            AnimalAdoptionDTO adoptionDTO = (AnimalAdoptionDTO) object;
            all_number = adoptionDTO.getAdoption_id();
            System.out.println("all_number = " + all_number);
        } else if (object instanceof AnimalBannerDTO) {
            AnimalBannerDTO bannerDTO = (AnimalBannerDTO) object;
            all_number = bannerDTO.getBanner_id();
        } else {
            throw new IllegalArgumentException("Unsupported DTO type");
        }

        File file = new File(filePath + "\\" + finalFolderNm);

        if (!file.exists()) {
            file.mkdirs();
        }

        for (MultipartFile multipartFile : mpFiles) {
            if (!multipartFile.isEmpty()) {
                originalFileName = multipartFile.getOriginalFilename();
                System.out.println("## 1파일이 가지고 있는 실제 이름 = " + multipartFile.getOriginalFilename());

                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                System.out.println("## 2실제 이름 .뒤에 확장자 추출 = " + originalFileExtension);

                storedFileName = getRandomString() + originalFileExtension;
                System.out.println("## 3랜덤으로 아이디 부여(고유 해야됨) = " + storedFileName);

                file = new File(filePath + "\\" + finalFolderNm + "\\" + storedFileName);
                System.out.println("## 4저장 경로에 고유에 이름으로 저장 = " + file);

                String fullUrl = filePath + "\\" + finalFolderNm + "\\" + storedFileName;

                multipartFile.transferTo(file);
                listMap = new HashMap<>();
                listMap.put("ALL_NUMBER", all_number);
                listMap.put("FOLDER_NM", finalFolderNm);
                listMap.put("FULL_URL", fullUrl);
                listMap.put("ORG_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
                list.add(listMap);
            }
        }
        return list;
    }

    public static String getRandomString() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

}
