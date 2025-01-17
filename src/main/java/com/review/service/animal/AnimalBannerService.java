package com.review.service.animal;

import com.review.dto.animal.AnimalBannerDTO;
import com.review.repository.animal.AnimalBannerRepository;
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
public class AnimalBannerService {

    @Setter(onMethod_ = @Autowired)
    private AnimalBannerRepository bannerRepository;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;

    public void bannerRegister(AnimalBannerDTO bannerDTO,  List<MultipartFile> file, String folderNm) throws IOException {
        System.out.println("bannerDTO = " + bannerDTO);
//
        handleFileUpload(bannerDTO, file, folderNm);
        bannerRepository.bannerRegister(bannerDTO);


    }

    public List<AnimalBannerDTO> bannerList() {
        return bannerRepository.bannerList();
    }

    public AnimalBannerDTO bannerRead(AnimalBannerDTO bannerDTO){
        return bannerRepository.bannerRead(bannerDTO);
    }

    public void bannerModify(AnimalBannerDTO bannerDTO, List<MultipartFile> file, String folderNm) throws IOException {


            if (!file.isEmpty()){
                handleFileUpload(bannerDTO, file, folderNm);
            }
        bannerRepository.bannerModify(bannerDTO);

    }

    private void handleFileUpload(AnimalBannerDTO bannerDTO, List<MultipartFile> mpRequest, String folderNm) throws IOException {

        int maxValue = bannerRepository.bannerIdMaxCount();
        if (bannerDTO.getBanner_id() == 0) {
            bannerDTO.setBanner_id(maxValue);
            System.out.println("bannerDTO = " + bannerDTO);

        }
        for (MultipartFile multipartFile : mpRequest) {
            if (!multipartFile.isEmpty()) {
                List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(bannerDTO, mpRequest, folderNm);
                int size = list.size();
                for (int i = 0; i < size; i++) {
//                list.get(i).get("FOLDER_NM");

                    Object stored_file_name = list.get(i).get("STORED_FILE_NAME");
                    Object full_url = list.get(i).get("FULL_URL");

                    bannerDTO.setImage_full_url((String) full_url);
                    bannerDTO.setStored_file_name((String) stored_file_name);

                    bannerRepository.insertFile(list.get(i));
                }
            }
        }
    }
}
