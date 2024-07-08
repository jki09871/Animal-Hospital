package com.review.service.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.repository.animal.AnimalAdoptionRepository;
import com.review.util.FileUtils;
import com.review.util.FileUtils2;
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
public class AnimalAdoptionService {

    @Setter(onMethod_ = @Autowired)
    private AnimalAdoptionRepository adoptionRepository;

    @Setter(onMethod_ = @Autowired)
    private FileUtils2 fileUtils;


    public void adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO, List<MultipartFile> thumbnails, List<MultipartFile> files) throws IOException {
        handleFileUpload(adoptionDTO, thumbnails, "thumbnails");
        handleFileUpload(adoptionDTO, files, "adoption");


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


    private void handleFileUpload(AnimalAdoptionDTO adoptionDTO, List<MultipartFile> mpFiles, String folder_nm) throws IOException {
        int maxValue = adoptionRepository.adoptionIdMaxCount();
        adoptionDTO.setAdoption_id(maxValue);

        if (mpFiles != null && !mpFiles.isEmpty()) {
            List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(adoptionDTO, mpFiles, folder_nm);
            for (Map<String, Object> fileInfo : list) {


                if ("thumbnails".equals(folder_nm)) {
                    adoptionDTO.setFolder_nm(folder_nm);
                    adoptionDTO.setStored_file_name((String) fileInfo.get("STORED_FILE_NAME"));
                    adoptionRepository.thumbnailsFileSave(fileInfo);
                } else {
                    adoptionDTO.setFolder_nm(folder_nm);
                    adoptionRepository.insertFile(fileInfo);
                }
            }
        }
    }
}
