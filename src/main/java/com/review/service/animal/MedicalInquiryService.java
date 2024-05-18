package com.review.service.animal;

import com.review.dto.animal.InquiryBoardDTO;
import com.review.repository.animal.MedicalInquiryRepository;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor // 모든 매개변수에 대한 생성자 생성.(생성자 여러개 아님)
public class MedicalInquiryService {

    @Setter(onMethod_ = @Autowired)
    private MedicalInquiryRepository mir;

    public void register(InquiryBoardDTO board) {
        log.info("register...." + board);
        mir.insert(board);
    }

    public InquiryBoardDTO get(Long inquiryNum) {
        log.info("get....." + inquiryNum);
        return mir.read(inquiryNum);
    }


    public boolean modify(InquiryBoardDTO board) {
        log.info("modify....." + board);
        return mir.update(board) == 1;
    }

    public boolean remove(Long inquiryNum) {
        log.info("delete....." + inquiryNum);
        return mir.delete(inquiryNum) == 1;
    }

    public List<InquiryBoardDTO> getList() {
        log.info("getList.....0");
        return mir.getList();
    }
}
