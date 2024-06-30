package com.review.service.animal;


import com.review.dto.animal.AnimalReviewDTO;
import com.review.dto.animal.AnimalPopUpDTO;
import com.review.repository.animal.AnimalMedicalReviewRepository;
import com.review.repository.animal.AnimalPopUpRepository;
import com.review.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AnimalPopUpService {

    @Setter(onMethod_ = @Autowired)
    private AnimalPopUpRepository popUp;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;

//    @Setter(onMethod_ = @Autowired)
//    private AnimalMedicalReviewRepository repository;

    public List<AnimalPopUpDTO> popUpList(){
        return popUp.popUpList();
    }

    public void popUpRegister(AnimalPopUpDTO popUpDTO, MultipartHttpServletRequest fileRequest) throws IOException {

        handleFileUpload(popUpDTO, fileRequest);
        popUp.popUpRegister(popUpDTO);



    }

    public AnimalPopUpDTO popUpRead(AnimalPopUpDTO popUpDTO) {
       return popUp.popUpRead(popUpDTO);
    }

    public void popUpModify(AnimalPopUpDTO popUpDTO, MultipartHttpServletRequest mpRequest) throws IOException {
        Iterator<String> fileNames = mpRequest.getFileNames();

        while (fileNames.hasNext()) {
            MultipartFile file = mpRequest.getFile(fileNames.next());

            if (!file.isEmpty()) { // 파일이 있으면 true
                handleFileUpload(popUpDTO, mpRequest);
            }
        }
        popUp.popUpModify(popUpDTO);
    }

    private void handleFileUpload(AnimalPopUpDTO popUpDTO, MultipartHttpServletRequest fileRequest) throws IOException {


        int maxValue = popUp.idMaxCount();
        popUpDTO.setId(maxValue);

        if (fileRequest != null && !fileRequest.equals("")) {
            List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(popUpDTO, fileRequest);
            int size = list.size();
            for (int i = 0; i < size; i++) {
                Object stored_file_name = list.get(i).get("STORED_FILE_NAME");
                Object full_url = list.get(i).get("FULL_URL");
                list.get(i).get("FOLDER_NM");
                popUpDTO.setImage_full_url((String) full_url);
                popUpDTO.setStored_file_name((String) stored_file_name);

                popUp.insertFile(list.get(i));
            }
        }
    }


}
