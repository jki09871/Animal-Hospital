package com.review.controller;

import java.io.*;
import java.util.*;


import com.review.dto.animal.AnimalPopUpDTO;
import com.review.service.animal.AnimalPopUpService;
import lombok.Setter;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Handddddddddddddles requests for the application home page.
 */
@Controller
public class HomeController {

	@Setter(onMethod_ = @Autowired)
	private AnimalPopUpService popUPService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/")
	public String home(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {

		List<AnimalPopUpDTO> list = popUPService.popUpList();
		System.out.println("list = " + list);
		model.addAttribute("list", list);


		model.addAttribute("success", request.getParameter("success"));




		List<String> bannerList = new ArrayList<>();
		bannerList.add("gallery1.jpg");
		bannerList.add("gallery2.jpg");
		bannerList.add("gallery3.jpg");
		bannerList.add("gallery4.jpg");
		bannerList.add("gallery5.jpg");
		bannerList.add("gallery6.jpg");
		bannerList.add("gallery7.jpg");
		bannerList.add("gallery8.jpg");
		bannerList.add("gallery9.jpg");

		model.addAttribute("bannerList", bannerList);


		return "home";
	}


	@Value("${file.upload.path}")
	private String fileRoot;

	//final private String fileRoot = "C:\\img\\hong\\";
	@PostMapping("/ajaxUpload")
		public @ResponseBody Map<String, Object> SummerNoteImageFile(@RequestParam("file") MultipartFile file){

		Map<String, Object> jsonObject = new HashMap<>();


		String originalFileName = file.getOriginalFilename();
		System.out.println("originalFileName(파일에 진짜이름) = " + originalFileName);

		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		System.out.println("extension(확장자 추출) = " + extension);

		String saveFileName = UUID.randomUUID()+extension;
		System.out.println("saveFileName(랜덤 이름을 부여 하고 확장자 붙힘) = " + saveFileName);

		String folder = "bbs";
		File targetFile = new File(fileRoot+"\\"+folder+"\\"+saveFileName);
		System.out.println("targetFile(경로 + 랜덤이름) = " + targetFile);

		try {
			InputStream fileStream = file.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			//jsonObject.put("url", "/hong/"+saveFileName);
			jsonObject.put("url", "/common/img?fName="+saveFileName+"&folder="+folder);
			jsonObject.put("responseCode", "success");


		}catch (IOException e){
			FileUtils.deleteQuietly(targetFile);
			jsonObject.put("responseCode", "error");
			e.printStackTrace();
		}
		return jsonObject;
	}


	/**
	 * MICHAEL 2022-06-21 공통 썸네일
	 * @param
	 * @param
	 * @return String
	 * @throws Exception
	 */
	// TODO: MICHAEL 2022-06-21 공통 썸네일
	@GetMapping("/common/img")
	public String thumNail(HttpServletRequest req, HttpServletResponse res) throws Exception {


		FileInputStream in = null;
		// http://localhost:8090/common/img/thumNail.do?fName=bac4fa26-ccf7-4834-a498-a7dcaf4ab16b.png

		String fName = req.getParameter("fName");
		String folder = req.getParameter("folder");

		System.out.println("fName = " + fName);
		System.out.println("folder = " + folder);


		try {


			String pullFath = fileRoot +"\\"+ folder + "\\" + fName;
			System.out.println("pullFath = " + pullFath);

			int idx = pullFath.lastIndexOf("/");
			System.out.println("idx = " + idx);

			String fileName = pullFath.substring(idx+1 , pullFath.length());
			System.out.println("fileName = " + fileName);

			File imgFile = new File(pullFath);
			if(imgFile.isFile()) { // 파일이 실제 경로에 있는 파일인지 확인 있으면 true
				in = new FileInputStream(imgFile);
				System.out.println("in = " + in);

				int length = (int)imgFile.length();
				System.out.println("length = " + length);


				int bufferSize = 1024;
				byte[] buffer = new byte[bufferSize];

				MimetypesFileTypeMap fileTypeMap = new MimetypesFileTypeMap();
				String mimeType = fileTypeMap.getContentType(imgFile.getName());
				System.out.println("### mimeType :: " + mimeType);

				ServletOutputStream stream = res.getOutputStream();
				res.setContentType(mimeType);
				res.setHeader("Content-Disposition","");

				while ((length = in.read(buffer)) != -1) {
					stream.write(buffer, 0, length);
				}
				stream.flush();
				stream.close();
			} else {
				logger.error("IMG FILE NOT FOUND");
				logger.error(pullFath+" 파일이 없습니다.");
			}


		}catch (Exception e){
			e.getStackTrace();
			logger.error("Exception", e);
		} finally {
			try {
				if(in != null)
					in.close();
			} catch (Exception e){ logger.error("Exception", e); }
		}
		return "file";

	}



}
