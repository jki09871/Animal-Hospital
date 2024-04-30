package com.review.repository;

import com.review.dto.BoardDTO;
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
public class BoardRepository {

    private final SqlSessionTemplate sql;

    public void save(BoardDTO boardDTO) {
        sql.insert("board.save", boardDTO);
    }

    public List<BoardDTO> list(BoardDTO boardDTO) {
        return sql.selectList("board.list", boardDTO);
    }

    public BoardDTO read(int bno) {
        return sql.selectOne("board.read", bno);
    }

    public void hits(int bno) {
        sql.update("board.hits", bno);
    }

    public void delete(int bno) {
        sql.delete("board.delete", bno);
    }

    public void update(BoardDTO boardDTO) {
        sql.update("board.update", boardDTO);
    }

    public void insertFile(Map<String, Object> map) {
        sql.insert("board.insertFile", map);
    }

    public List<Map<String, Object>> selectFileList(int bno){
       return sql.selectList("board.selectFileList", bno);
    }

    public Map<String, Object> selectFileInfo(Map<String, Object> map) {
        return sql.selectOne("board.selectFileInfo", map);
    }


    public void updateFile(Map<String, Object> map){
        sql.update("board.updateFile", map);
    }

    public void removeFile(int fileNo) {
        sql.delete("board.fileRemove", fileNo);
    }
}
