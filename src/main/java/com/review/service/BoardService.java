package com.review.service;

import com.review.dto.BoardDTO;
import com.review.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j
public class BoardService {

    @Setter(onMethod_ = @Autowired)
    private BoardRepository repository;

    public void save(BoardDTO boardDTO) {
        repository.save(boardDTO);
    }

    public List<BoardDTO> list(BoardDTO boardDTO) {

        return repository.list(boardDTO);
    }

    public BoardDTO read(int bno) {
        return repository.read(bno);
    }

    public void hits(int bno) {
        repository.hits(bno);
    }

    public void delete(int bno) {
        repository.delete(bno);
    }

    public void update(BoardDTO bno) {
        repository.update(bno);
    }
}
