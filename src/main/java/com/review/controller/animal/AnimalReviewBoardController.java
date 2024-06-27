package com.review.controller.animal;

import com.review.dto.animal.AnimalReviewDTO;
import com.review.paging.PageMakerDTO;
import com.review.paging.PagingCriteria;
import com.review.service.animal.MedicalReviewService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import java.util.List;
import java.util.Map;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalReviewBoardController {

    @Setter(onMethod_ = @Autowired)
    private MedicalReviewService service;

    @Value("${file.upload.path}")
    private String filePath;

    /************************************************  게시물 리스트  ************************************************/
    @RequestMapping("/animal/reviewList")
    public String animalReviewList(Model model, PagingCriteria pagingCriteria, HttpServletRequest request){
        HttpSession session = request.getSession();
//        if (session.getAttribute("loginId") == null)
//            return "redirect:/animal/login?toURL="+request.getRequestURL();
        log.info("리뷰 게시판");

        model.addAttribute("list", service.getListPaging(pagingCriteria));
        int total = service.postTotal();
        PageMakerDTO pageMaker = new PageMakerDTO(pagingCriteria, total);
        model.addAttribute("pageMaker", pageMaker);
        return "/animal/board/rvfindAll";
    }
    /************************************************************************************************************/

    /************************************************  게시물 작성  ************************************************/
    @GetMapping("/animal/review")
    public String medicalReview(){
        return "/animal/board/evaluation";
    }

    @PostMapping("/animal/review")
    public String medicalReview(AnimalReviewDTO reviewDTO, MultipartHttpServletRequest mpRequest, Model model,
                                HttpServletRequest request) throws IOException {
        System.out.println("mpRequest = " + mpRequest);
        HttpSession session = request.getSession();
        model.addAttribute("animal", session.getAttribute("loginId"));
        service.reviewWrite(reviewDTO, mpRequest);
        System.out.println("reviewDTO = " + reviewDTO);

        return "redirect:/animal/reviewList";
    }
    /************************************************************************************************************/

    /***********************************************  게시물 상세보기 **********************************************/
    @GetMapping("/animal/viewDetails")
    public String viewDetails(AnimalReviewDTO reviewDTO, Model model, PagingCriteria criteria, HttpServletRequest request){

        HttpSession session = request.getSession();
        AnimalReviewDTO information = service.information(reviewDTO.getReviewNum());
        List<Map<String,Object>> fileList = service.selectFileList(reviewDTO.getReviewNum());

        model.addAttribute("file", fileList);
        model.addAttribute("animal", information);
        model.addAttribute("criteria", criteria);

        return "/animal/board/viewDetails";
    }
    /************************************************************************************************************/

    /************************************************  게시물 수정 ************************************************/
    @GetMapping("/animal/correction")
    public String correctionBefore(AnimalReviewDTO reviewDTO, Model model, PagingCriteria criteria, HttpServletRequest request){

        model.addAttribute("animal", service.information(reviewDTO.getReviewNum()));
        model.addAttribute("cri", criteria);
        model.addAttribute("file", service.selectFileList(reviewDTO.getReviewNum()));

        System.out.println("pageNum = " + request.getParameter("pageNum"));
        System.out.println("amount = " + request.getParameter("amount"));
        return "/animal/board/correction";
    }

    @PostMapping("/animal/correction")
    public String correctionAfter(AnimalReviewDTO reviewDTO, Model model, MultipartHttpServletRequest mpRequest, HttpServletRequest request,
                                  RedirectAttributes rttr){


        service.correction(reviewDTO, mpRequest);

        /** 수정 후 리다이렉트 할 때 데이터를 넘겨서 수정한 게시물을 보기 **/
        rttr.addAttribute("amount", request.getParameter("amount"));
        rttr.addAttribute("pageNum", request.getParameter("pageNum"));
        rttr.addAttribute("reviewNum", request.getParameter("reviewNum"));

        model.addAttribute("animal",service.information(reviewDTO.getReviewNum()));
        model.addAttribute("file", service.selectFileList(reviewDTO.getReviewNum()));


        return "redirect:/animal/viewDetails";

    }
    /************************************************************************************************************/

    /************************************************  게시물 삭제  ************************************************/
    @GetMapping("/animal/deletePost")
    public String deletePost(@RequestParam("reviewNum") int reviewNum, Model model, HttpServletRequest request, RedirectAttributes rttr){
        service.deleteUsingNum(reviewNum);

        rttr.addAttribute("amount", request.getParameter("amount"));
        rttr.addAttribute("pageNum", request.getParameter("pageNum"));

        return "redirect:/animal/reviewList";

    }
    /************************************************************************************************************/

    /************************************************  파일 다운  ************************************************/
    @RequestMapping("/animal/fileDown")
    @ResponseBody
    public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws IOException {
        Map<String, Object> resultMap = service.selectFileInfo(map);
        String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
        String originalFileName = (String) resultMap.get("ORG_FILE_NAME");

        String folderNm =  resultMap.get("folder_nm") == null || "".equals(resultMap.get("folder_nm")) ? (String) map.get("folder_nm")
                : (String) resultMap.get("folder_nm");

        // 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
        byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File(filePath+"\\"+folderNm+"\\"+storedFileName));

        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition",  "attachment; fileName=\""+ URLEncoder.encode(originalFileName, "UTF-8")+"\";");
        response.getOutputStream().write(fileByte);
        response.getOutputStream().flush();
        response.getOutputStream().close();

    }
    /************************************************************************************************************/

    /************************************************  파일 삭제  ************************************************/
    @RequestMapping("/animal/fileRemove")
    @ResponseBody
    public void deleteFile(@RequestParam("fileNo") int fileNo,
                           @RequestParam("reviewNum") int reviewNum,
                           HttpServletRequest request){

        String folder_nm = (request.getParameter("folder_nm") == null || "".equals(request.getParameter("folder_nm")))
                ?  "file" : request.getParameter("folder_nm");

        System.out.println("######### folder_nm = " + folder_nm);

        System.out.println("삭제한 FILE_NO은 " + reviewNum + "번 입니다.");
        service.deleteFile(fileNo, reviewNum, folder_nm);
    }
    /**********************************************************************************************************/
}
