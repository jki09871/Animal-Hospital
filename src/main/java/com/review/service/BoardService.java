package com.review.service;

import com.review.dto.BoardDTO;
import com.review.repository.BoardRepository;
import com.review.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Log4j
public class BoardService {

    @Setter(onMethod_ = @Autowired)
    private BoardRepository repository;

    @Setter(onMethod_ = @Autowired)
    private FileUtils fileUtils;

    public void save(BoardDTO boardDTO, MultipartHttpServletRequest mpRequest) throws IOException {
        repository.save(boardDTO);

        List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardDTO, mpRequest);
        int size = list.size();
        for (int i = 0; i < size; i++){
            repository.insertFile(list.get(i));
        }
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

        List<Map<String, Object>> list = repository.selectFileList(bno);

        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++){
                File file = new File("c:\\mp\\file\\" + list.get(i).get("STORED_FILE_NAME"));

                if (file.delete()){
                    repository.removeFile((Integer) list.get(i).get("FILE_NO"));
                }
            }
        }
        repository.delete(bno);
    }

    public void update(BoardDTO boardDTO, MultipartHttpServletRequest mpRequest) {
        fileUtils.processFileInformation(boardDTO, mpRequest);

        repository.update(boardDTO);
    }

    public List<Map<String, Object>> SelectFileList(int bno) {

        return repository.selectFileList(bno);
    }

    public Map<String, Object> SelectFileInfo(Map<String, Object> map) {
        return repository.selectFileInfo(map);
    }

    public void RemoveFile(int fileNo, int bno) {
        try {

            Map<String, Object> fileNum = new HashMap<>();
            fileNum.put("FILE_NO", fileNo);
            fileNum.put("bno", bno);

            Map<String, Object> fileNum2 = repository.selectFileInfo(fileNum);

            if (fileNum2.get("STORED_FILE_NAME") != null) {
                File file = new File("c:\\mp\\file\\" + fileNum2.get("STORED_FILE_NAME"));

                if (file.delete()) {
                    System.out.println(fileNo);
                    repository.removeFile(fileNo);
                } else {
                    System.out.println("오류");
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
