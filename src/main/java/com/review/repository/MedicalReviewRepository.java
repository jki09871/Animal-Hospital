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


    public void reviewWrite(AnimalReviewDTO reviewDTO) {
        System.out.println("reviewDTO = " + reviewDTO);
        sql.insert("review.reviewScreen", reviewDTO);
    }

    public List<AnimalReviewDTO> reviewList(AnimalReviewDTO reviewDTO) {
        return sql.selectList("review.findAll", reviewDTO);
    }

    public AnimalReviewDTO information(int reviewNum) {
        return sql.selectOne("review.read", reviewNum);
    }

    public void correction(AnimalReviewDTO reviewDTO) {
        sql.update("review.update", reviewDTO);
    }

    public void deleteUsingNum(int reviewNum) {
        sql.delete("review.delete", reviewNum);
    }
}
