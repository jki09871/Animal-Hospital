package com.review.repository.animal;

import com.review.dto.animal.AnimalReviewDTO;
import com.review.paging.PagingCriteria;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Log4j
@RequiredArgsConstructor
public class AnimalMedicalReviewRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;


    public void reviewWrite(AnimalReviewDTO reviewDTO) {
        sql.insert("review.reviewScreen", reviewDTO);
    }

    public List<AnimalReviewDTO> reviewList() {
        return sql.selectList("review.findAll");
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

    public List<AnimalReviewDTO> getListPaging(PagingCriteria pagingCriteria){
        return sql.selectList("review.paging", pagingCriteria);
    }

    public int postTotal(){
        return sql.selectOne("review.postTotal");
    }

    public void insertFile(Map<String, Object> map) {
        sql.insert("file.insertFile", map);
    }

    public List<Map<String, Object>> selectFileList(int reviewNum){
        return sql.selectList("file.selectFileList", reviewNum);
    }

    public Map<String, Object> selectFileInfo(Map<String, Object> map){
        return sql.selectOne("file.selectFileInfo", map);
    }


    public void removeFile(int fileNo) {
        sql.delete("file.fileRemove", fileNo);
    }

    public List<AnimalReviewDTO> myWriting(String ownerId){

        return sql.selectList("review.myWriting", ownerId);
    }

}
