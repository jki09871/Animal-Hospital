package com.review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );

		// db 에서 메인 배너 조회.
		/*
		 ..
		 model.addAttribute("bannerList", service.selectBannerList());

		* */
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



	/**
	 * MICHAEL 2022-06-21 공통 썸네일
	 * @param req
	 * @param res
	 * @return String
	 * @throws Exception
	 */
	// TODO: MICHAEL 2022-06-21 공통 썸네일
	@GetMapping("/common/img/thumNail.do")
	public String thumNail(HttpServletRequest req, HttpServletResponse res) throws Exception {

		FileInputStream in = null;
		// http://localhost:8090/common/img/thumNail.do?fPath=editor/1.jpg

		String rootPath = "C:/Temp";
		String fPath = req.getParameter("fPath");


		try {


			String pullFath = rootPath + "/" + fPath;
			int idx = pullFath.lastIndexOf("/");
			String fileName = pullFath.substring(idx+1 , pullFath.length());

			File imgFile = new File(pullFath);
			if(imgFile.isFile()) {
				in = new FileInputStream(imgFile);
				int length = (int)imgFile.length();

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
