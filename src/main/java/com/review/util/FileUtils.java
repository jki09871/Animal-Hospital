package com.review.util;

import com.review.dto.animal.AnimalReviewDTO;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Log4j
@Component
@PropertySource("classpath:globals.properties")
public class FileUtils {

    private static final Logger logger = LoggerFactory.getLogger(FileUtils.class);


    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalReviewRepository repository;


    @Value("${file.upload.path}")
    private String filePath;
    // private static final String filePath = "C:\\mp\\file\\"; //파일이 저장될 위치

    public List<Map<String, Object>> parseInsertFileInfo(AnimalReviewDTO reviewDTO, MultipartHttpServletRequest mpRequest) throws IOException {

        Iterator<String> iterator = mpRequest.getFileNames();

        String folderNm = (mpRequest.getParameter("folder_nm") == null || "".equals(mpRequest.getParameter("folder_nm")))
                ?  "file" : mpRequest.getParameter("folder_nm");
        System.out.println("folderNm = " + folderNm);

        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;

        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> listMap = null;

        int reviewNum = reviewDTO.getReviewNum();

        File file = new File(filePath+"\\"+folderNm );

        if (file.exists() == false){
            file.mkdirs();
        }

        while (iterator.hasNext()){
            multipartFile = mpRequest.getFile(iterator.next());

            if (multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                System.out.println("## 1파일이 가지고 있는 실제 이름 = " + multipartFile.getOriginalFilename());

                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                System.out.println("## 2실제 이름 .뒤에 확장자 추출 = " + originalFileExtension);

                storedFileName = getRandomString() + originalFileExtension;
                System.out.println("## 3랜덤으로 아이디 부여(고유 해야됨) = " + storedFileName);

                file = new File(filePath+"\\"+folderNm +"\\"+ storedFileName);
                System.out.println("## 4저장 경로에 고유에 이름으로 저장 = " + file);

                String fullUrl = filePath +"\\" + folderNm +"\\"+ storedFileName;

                multipartFile.transferTo(file);
                listMap = new HashMap<>();
                listMap.put("reviewNum", reviewNum);
                listMap.put("FOLDER_NM", folderNm);
                listMap.put("FULL_URL", fullUrl); /* 팝업 저장용으로 그냥 만들어 놓음*/
                listMap.put("ORG_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
                list.add(listMap);
            }
        }
        return list;
    }
    
    public static String getRandomString(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    public void processFileInformation(AnimalReviewDTO reviewDTO, MultipartHttpServletRequest mpRequest) {
        try {
            List<Map<String, Object>> list = parseInsertFileInfo(reviewDTO, mpRequest);
            int size = list.size();
            for (int i = 0; i < size; i++) {
                repository.insertFile(list.get(i));
                System.out.println("##list.size() -->" + list.size());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
