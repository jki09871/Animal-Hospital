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

    public void ReviewWrite(AnimalReviewDTO reviewDTO) {
        repository.reviewScreen(reviewDTO);
    }

    public List<AnimalReviewDTO> ReviewList(AnimalReviewDTO reviewDTO) {
        return repository.findAll(reviewDTO);
    }

    public AnimalReviewDTO information(int reviewNum) {
        return  repository.ReviewRead(reviewNum);
    }

    public void Correction(AnimalReviewDTO reviewDTO) {
        repository.Correction(reviewDTO);
    }

    public void DeleteUsingNum(int reviewNum) {
        repository.RemovePost(reviewNum);
    }
}
