package com.review.service.animal;


import com.review.dto.animal.AnimalPopUpDTO;
import com.review.repository.animal.AnimalPopUpRepository;
import com.review.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
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

    public void popUpRegister(AnimalPopUpDTO popUpDTO,  List<MultipartFile> mpRequest, String folderNm ) throws IOException {

        for (MultipartFile multipartFile : mpRequest) {
            if (!multipartFile.isEmpty()) {
                handleFileUpload(popUpDTO, mpRequest, folderNm);
            }
        }
        popUp.popUpRegister(popUpDTO);

    }

    public AnimalPopUpDTO popUpRead(AnimalPopUpDTO popUpDTO) {
       return popUp.popUpRead(popUpDTO);
    }

    public void popUpModify(AnimalPopUpDTO popUpDTO, List<MultipartFile> mpRequest, String folderNm) throws IOException {

        for (MultipartFile multipartFile : mpRequest) {
            if (!multipartFile.isEmpty()) {
                handleFileUpload(popUpDTO, mpRequest, folderNm);
            }
        }
        popUp.popUpModify(popUpDTO);

    }
    private void handleFileUpload(AnimalPopUpDTO popUpDTO,  List<MultipartFile> file, String folderNm) throws IOException {

        if (popUpDTO.getId() == 0) {
            int maxValue = popUp.idMaxCount();
            popUpDTO.setId(maxValue);
        }

        if (file != null && !file.equals("")) {
            List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(popUpDTO, file, folderNm);
            int size = list.size();
            for (int i = 0; i < size; i++) {
                Object stored_file_name = list.get(i).get("STORED_FILE_NAME");
                Object full_url = list.get(i).get("FULL_URL");
//                list.get(i).get("FOLDER_NM");
                popUpDTO.setImage_full_url((String) full_url);
                popUpDTO.setStored_file_name((String) stored_file_name);

                popUp.insertFile(list.get(i));
            }
        }
    }


}
