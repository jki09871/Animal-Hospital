package com.review.controller;

import com.review.dto.BoardDTO;
import com.review.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

    @Setter(onMethod_ = @Autowired)
    private BoardService service;

    @RequestMapping("/board/msg")
    public void msgForward(HttpServletRequest request){

        request.setAttribute("msg", request.getAttribute("msg"));
        request.setAttribute("returnUrl", request.getAttribute("returnUrl"));


    }

    @GetMapping("/save")
    public String BoardSave(Model model, HttpSession session, HttpServletRequest request){

        String K_login = (String) session.getAttribute("kakaosessionId");
        String N_login = (String) session.getAttribute("naversessionId");
        String E_login = (String) session.getAttribute("loginEmail");

        if (K_login != null || N_login != null || E_login != null){
            return "/board/save";
        } else {
            String msg = "로그인 후 이용해 주세요.";
            request.setAttribute("msg", msg);
            request.setAttribute("returnUrl", "/board/list");
            return "forward:/board/msg";
        }

    }


    @PostMapping("/save")
    public String BoarSavePost(BoardDTO boardDTO, MultipartHttpServletRequest mpRequest) throws IOException {
        service.save(boardDTO, mpRequest);
        System.out.println("boardDTO = " + boardDTO);

        return "redirect:/board/list";
    }

    @RequestMapping("/list")
    public String BoardList(BoardDTO boardDTO, HttpSession session, Model model){

        /** 로그인 확인 **/
       model.addAttribute("loginEmail", session.getAttribute("loginEmail"));
       model.addAttribute("kakaosessionId", session.getAttribute("kakaosessionId"));
       model.addAttribute("naversessionId", session.getAttribute("naversessionId"));




        List<BoardDTO> boarsList = service.list(boardDTO);
        model.addAttribute("boardList", boarsList);
        return "/board/list";
    }

    @GetMapping("/read")
    public String BoardRead(@RequestParam("bno") int bno, Model model, HttpServletRequest request){


        System.out.println("request.getParameter(\"writer\") = " + request.getParameter("writer"));

        service.hits(bno);
        model.addAttribute("board", service.read(bno));
        model.addAttribute("file", service.SelectFileList(bno));
        return "/board/read";
    }

    @GetMapping("/delete")
    public String BoardDelete(@RequestParam("bno") int bno, HttpSession session, HttpServletRequest request) {

        String K_login = (String) session.getAttribute("kakaosessionId");
        String N_login = (String) session.getAttribute("naversessionId");
        String E_login = (String) session.getAttribute("loginEmail");
        String writer = request.getParameter("writer");

        if (writer.equals(K_login) || writer.equals(N_login) || writer.equals(E_login)){
            service.delete(bno);
            return "redirect:/board/list";
        } else {
            String msg = "권한이 없습니다.";
            request.setAttribute("msg", msg);
            request.setAttribute("returnUrl", "/board/list");
            return "forward:/board/msg";
        }

    }

    @GetMapping("/update")
    public String BoardUpdateGet(BoardDTO boardDTO, Model model, HttpServletRequest request){

        HttpSession session = request.getSession();

        /** 로그인 확인 **/
        String K_login = (String) session.getAttribute("kakaosessionId");
        String N_login = (String) session.getAttribute("naversessionId");
        String E_login = (String) session.getAttribute("loginEmail");
        String writer = request.getParameter("writer");


        if (writer.equals(K_login) || writer.equals(N_login) || writer.equals(E_login)){
            model.addAttribute("file", service.SelectFileList(boardDTO.getBno()));
            model.addAttribute("board", service.read(boardDTO.getBno()));

            return "/board/update";
        } else {

            String msg = "권한이 없습니다.";
            request.setAttribute("msg", msg);
            request.setAttribute("returnUrl", "/board/list");
            return "forward:/board/msg";
        }
    }

    @PostMapping("/update")
    public String BoardUpdatePost(@ModelAttribute BoardDTO boardDTO, Model model, MultipartHttpServletRequest mpRequest){
        service.update(boardDTO, mpRequest);
        model.addAttribute("board",service.read(boardDTO.getBno()));
        model.addAttribute("file", service.SelectFileList(boardDTO.getBno()));
        return "/board/read";
    }

    @RequestMapping(value="/fileDown")
    public void BoardFileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
        Map<String, Object> resultMap = service.SelectFileInfo(map);
        String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
        String originalFileName = (String) resultMap.get("ORG_FILE_NAME");

        // 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
        byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\mp\\file\\"+storedFileName));

        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition",  "attachment; fileName=\""+ URLEncoder.encode(originalFileName, "UTF-8")+"\";");
        response.getOutputStream().write(fileByte);
        response.getOutputStream().flush();
        response.getOutputStream().close();

    }

    @RequestMapping("/fileRemove")
    @ResponseBody
    public void removeFile(@RequestParam("fileNo") int fileNo, @RequestParam("bno") int bno) {
        // fileNo를 이용하여 파일을 삭제하는 로직을 구현
        System.out.println("삭제한 FILE_NO은 " + fileNo + "번 입니다.");
        service.RemoveFile(fileNo, bno);

        // 파일 삭제 성공 여부에 따라 적절한 응답을 반환
    }

}
