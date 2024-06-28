package com.review.repository.animal;


import com.review.dto.animal.AnimalPopUpDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class AnimalPopUpRepository {

    @Setter(onMethod_ = @Autowired)
    private SqlSessionTemplate sql;

    public List<AnimalPopUpDTO> popUpList(){
        return sql.selectList("popUp.popUpList");
    }

    public void popUpRegister(AnimalPopUpDTO popUpDTO) {
        sql.insert("popUp.popUpRegister", popUpDTO);
    }

    public AnimalPopUpDTO popUpRead(AnimalPopUpDTO popUpDTO) {
        return sql.selectOne("popUp.read", popUpDTO);
    }

    public int idMaxCount(){
        return sql.selectOne("popUp.maxNumber");
    }

    public void insertFile(Map<String, Object> map) {
        sql.insert("file.insertFile", map);
    }

    public void popUpModify(AnimalPopUpDTO popUpDto) {

        sql.update("popUp.modify", popUpDto);
    }
}


