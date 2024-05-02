package com.review.service;

import com.review.dto.AnimalReviewDTO;
import com.review.repository.MedicalReviewRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j
public class MedicalReviewService {

    @Setter(onMethod_ = @Autowired)
    private MedicalReviewRepository repository;

    public void reviewWrite(AnimalReviewDTO reviewDTO) {
        System.out.println("reviewDTO = " + reviewDTO);
        repository.reviewWrite(reviewDTO);
    }

    public List<AnimalReviewDTO> reviewList(AnimalReviewDTO reviewDTO) {
        return repository.reviewList(reviewDTO);
    }

    public AnimalReviewDTO information(int reviewNum) {
        return  repository.information(reviewNum);
    }

    public void correction(AnimalReviewDTO reviewDTO) {
        repository.correction(reviewDTO);
    }

    public void deleteUsingNum(int reviewNum) {
        repository.deleteUsingNum(reviewNum);
    }
}
