package com.review.service;

import com.review.dto.AnimalReviewDTO;
import com.review.paging.PagingCriteria;
import com.review.repository.MedicalReviewRepository;
import com.review.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.w3c.dom.ls.LSInput;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Log4j
public class MedicalReviewService {

    @Setter(onMethod_ = @Autowired)
    private MedicalReviewRepository repository;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;

    public void reviewWrite(AnimalReviewDTO reviewDTO, MultipartHttpServletRequest mpRequest) throws IOException {
        repository.reviewWrite(reviewDTO);
        List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(reviewDTO, mpRequest);
        int size = list.size();
        for (int i = 0; i < size; i++){
            repository.insertFile(list.get(i));
        }

    }

    public List<AnimalReviewDTO> reviewList() {
        return repository.reviewList();
    }

    public AnimalReviewDTO information(int reviewNum) {
        return  repository.information(reviewNum);
    }

    public void correction(AnimalReviewDTO reviewDTO, MultipartHttpServletRequest mpRequest) {
        fileUtils.processFileInformation(reviewDTO,mpRequest);
        repository.correction(reviewDTO);
    }

    public void deleteUsingNum(int reviewNum) {
        List<Map<String, Object>> list = repository.selectFileList(reviewNum);

        if (list.size() > 0){
            for (int i = 0; i < list.size(); i++){
                File file = new File("c:\\mp\\file\\" + list.get(i).get("STORED_FILE_NAME"));

                if (file.delete()){
                    repository.removeFile((Integer) list.get(i).get("FILE_NO"));
                }
            }
        }
        repository.deleteUsingNum(reviewNum);
    }

    public List<AnimalReviewDTO> getListPaging(PagingCriteria pagingCriteria){
        return repository.getListPaging(pagingCriteria);
    }

    public int postTotal(){
        return repository.postTotal();
    }

    public List<Map<String, Object>> selectFileList(int reviewNum){
        return repository.selectFileList(reviewNum);
    }

    public Map<String, Object> selectFileInfo(Map<String,Object> map){
        return repository.selectFileInfo(map);
    }

    public void deleteFile(int fileNo, int reviewNum){

        Map<String, Object> fileNum = new HashMap<>();
        fileNum.put("FILE_NO", fileNo);
        fileNum.put("BNO", reviewNum);

        Map<String, Object> fileNum2 = repository.selectFileInfo(fileNum);

        if (fileNum2.get("STORED_FILE_NAME") != null){
            File file = new File("c:\\mp\\file\\" + fileNum2.get("STORED_FILE_NAME"));

            if (file.delete()){
                System.out.println(fileNo);
                repository.removeFile(fileNo);
            }else {
                System.out.println("오류");
            }
        }
    }
}
