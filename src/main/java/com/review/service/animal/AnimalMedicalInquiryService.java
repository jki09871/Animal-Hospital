package com.review.service.animal;

import com.review.dto.animal.AnimalInquiryBoardDTO;
import com.review.repository.animal.AnimalMedicalInquiryRepository;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Log4j
@AllArgsConstructor // 모든 매개변수에 대한 생성자 생성.(생성자 여러개 아님)
public class AnimalMedicalInquiryService {

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalInquiryRepository mir;

    public void register(AnimalInquiryBoardDTO board) {
        log.info("register...." + board);
        mir.insert(board);
    }

    public Map<String, Object> get(Map<String, Object> num) {

        return mir.read(num);
    }


    public boolean modify(AnimalInquiryBoardDTO board) {
        log.info("modify....." + board);
        return mir.update(board) == 1;
    }

    public boolean remove(Long inquiry_Num) {
        log.info("delete....." + inquiry_Num);
        return mir.delete(inquiry_Num) == 1;
    }

    public List<Map<String,Object>> getList() {
        log.info("getList.....0");
        return mir.getList();
    }

    public Map<String, Object> privateInquiryRead(Map<String, Object> paramMap) {
        return mir.privateInquiryRead(paramMap);
    }

    public List<AnimalInquiryBoardDTO> inquiryIWrote(String ownerId) {
        return mir.inquiryIWrote(ownerId);
    }
}
