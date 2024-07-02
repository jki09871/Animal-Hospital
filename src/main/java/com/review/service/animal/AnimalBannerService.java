package com.review.service.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.dto.animal.AnimalBannerDTO;
import com.review.repository.animal.AnimalBannerRepository;
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
public class AnimalBannerService {

    @Setter(onMethod_ = @Autowired)
    private AnimalBannerRepository bannerRepository;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;

    public void bannerRegister(AnimalBannerDTO bannerDTO, MultipartHttpServletRequest mpRequest) throws IOException {

        handleFileUpload(bannerDTO, mpRequest);
        bannerRepository.bannerRegister(bannerDTO);


    }

    public List<AnimalBannerDTO> bannerList() {
        return bannerRepository.bannerList();
    }

    public AnimalBannerDTO bannerRead(AnimalBannerDTO bannerDTO){
        return bannerRepository.bannerRead(bannerDTO);
    }

    public void bannerModify(AnimalBannerDTO bannerDTO, MultipartHttpServletRequest mpRequest) throws IOException {
        Iterator<String> fileName = mpRequest.getFileNames();

        while (fileName.hasNext()){
            MultipartFile file = mpRequest.getFile(fileName.next());

            if (!file.isEmpty()){
                handleFileUpload(bannerDTO, mpRequest);
            }
        }

        bannerRepository.bannerModify(bannerDTO);

    }

    private void handleFileUpload(AnimalBannerDTO bannerDTO, MultipartHttpServletRequest fileRequest) throws IOException {

        int maxValue = bannerRepository.bannerIdMaxCount();
        if (bannerDTO.getBanner_id() == 0) {
            bannerDTO.setBanner_id(maxValue);
        }
        if (fileRequest != null && !fileRequest.equals("")) {
            List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(bannerDTO, fileRequest);
            int size = list.size();
            for (int i = 0; i < size; i++) {
//                list.get(i).get("FOLDER_NM");
                Object stored_file_name = list.get(i).get("STORED_FILE_NAME");
                System.out.println("######stored_file_name = " + stored_file_name);
                Object full_url = list.get(i).get("FULL_URL");
                System.out.println("#######full_url = " + full_url);
                bannerDTO.setImage_full_url((String) full_url);
                bannerDTO.setStored_file_name((String) stored_file_name);

                bannerRepository.insertFile(list.get(i));
            }
        }
    }
}
