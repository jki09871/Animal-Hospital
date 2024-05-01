package com.review.repository;

import com.review.dto.AnimalReviewDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Log4j
@RequiredArgsConstructor
public class MedicalReviewRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;


    public void reviewScreen(AnimalReviewDTO reviewDTO) {
        sql.insert("Review.reviewScreen", reviewDTO);
    }

    public List<AnimalReviewDTO> findAll(AnimalReviewDTO reviewDTO) {
        return sql.selectList("Review.findAll", reviewDTO);
    }

    public AnimalReviewDTO ReviewRead(int reviewNum) {
        return sql.selectOne("Review.read", reviewNum);
    }

    public void Correction(AnimalReviewDTO reviewDTO) {
        sql.update("Review.update", reviewDTO);
    }

    public void RemovePost(int reviewNum) {
        sql.delete("Review.delete", reviewNum);
    }
}
