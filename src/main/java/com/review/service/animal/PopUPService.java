package com.review.service.animal;


import com.review.dto.animal.AnimalReviewDTO;
import com.review.dto.animal.PopUpDTO;
import com.review.repository.animal.MedicalReviewRepository;
import com.review.repository.animal.PopUpRepository;
import com.review.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PopUPService {

    @Setter(onMethod_ = @Autowired)
    private PopUpRepository popUp;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;

    @Setter(onMethod_ = @Autowired)
    private MedicalReviewRepository repository;

    public List<PopUpDTO> popUpList(){
        return popUp.popUpList();
    }

    public void popUpRegister(PopUpDTO popUpDTO, MultipartHttpServletRequest fileRequest) throws IOException {

        handleFileUpload(popUpDTO, fileRequest);
        popUp.popUpRegister(popUpDTO);



    }

    public PopUpDTO popUpRead(PopUpDTO popUpDTO) {
       return popUp.popUpRead(popUpDTO);
    }

    public void popUpModify(PopUpDTO popUpDTO, MultipartHttpServletRequest fileRequest) throws IOException {

        handleFileUpload(popUpDTO, fileRequest);
        popUp.popUpModify(popUpDTO);
    }

    private void handleFileUpload(PopUpDTO popUpDTO, MultipartHttpServletRequest fileRequest) throws IOException {
        AnimalReviewDTO reviewDTO = new AnimalReviewDTO();
        if (popUpDTO.getId() > 0) {

            reviewDTO.setReviewNum(popUpDTO.getId());

        } else if (popUpDTO.getId() == 0){

            int i = popUp.idMaxCount();
            popUpDTO.setId(i);
            reviewDTO.setReviewNum(popUpDTO.getId());
        }
        if (fileRequest != null && !fileRequest.equals("")) {
            List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(reviewDTO, fileRequest);
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
