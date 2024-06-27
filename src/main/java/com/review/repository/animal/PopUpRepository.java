package com.review.repository.animal;


import com.review.dto.animal.PopUpDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class PopUpRepository {

    @Setter(onMethod_ = @Autowired)
    private SqlSessionTemplate sql;

    public List<PopUpDTO> popUpList(){
        return sql.selectList("popUp.popUpList");
    }

    public void popUpRegister(PopUpDTO popUpDTO) {
        sql.insert("popUp.popUpRegister", popUpDTO);
    }

    public PopUpDTO popUpRead(PopUpDTO popUpDTO) {
        return sql.selectOne("popUp.read", popUpDTO);
    }

    public int idMaxCount(){
        return sql.selectOne("popUp.maxNumber");
    }

    public void insertFile(Map<String, Object> map) {
        sql.insert("file.insertFile", map);
    }

    public void popUpModify(PopUpDTO popUpDto) {

        sql.update("popUp.modify", popUpDto);
    }
}


