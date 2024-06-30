package com.review.service.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.dto.animal.AnimalPopUpDTO;
import com.review.repository.animal.AnimalAdoptionRepository;
import com.review.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AnimalAdoptionService {

    @Setter(onMethod_ = @Autowired)
    private AnimalAdoptionRepository adoptionRepository;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;


    public void adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO,  MultipartHttpServletRequest mpRequest) throws IOException {
        handleFileUpload(adoptionDTO, mpRequest);
        adoptionRepository.adoptionAnimalRegister(adoptionDTO);

    }

    public List<AnimalAdoptionDTO> adoptionAnimalList(){
        return adoptionRepository.adoptionAnimalList();
    }

    public AnimalAdoptionDTO adoptionAnimalRead(AnimalAdoptionDTO adoptionDTO) {
        return adoptionRepository.adoptionAnimalRead(adoptionDTO);
    }

    public void adoptionAnimalInformationModify(AnimalAdoptionDTO adoptionDTO) {
        adoptionRepository.adoptionAnimalInformationModify(adoptionDTO);
    }

    private void handleFileUpload(AnimalAdoptionDTO adoptionDTO, MultipartHttpServletRequest fileRequest) throws IOException {


        int maxValue = adoptionRepository.adoptionIdMaxCount();
        adoptionDTO.setAdoption_id(maxValue);

        if (fileRequest != null && !fileRequest.equals("")) {
            List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(adoptionDTO, fileRequest);
            int size = list.size();
            for (int i = 0; i < size; i++) {
                Object stored_file_name = list.get(i).get("STORED_FILE_NAME");
                list.get(i).get("FOLDER_NM");
                adoptionDTO.setStored_file_name((String) stored_file_name);

                adoptionRepository.insertFile(list.get(i));
            }
        }
    }
}
