package com.review.controller;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

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
	 * @param
	 * @param
	 * @return String
	 * @throws Exception
	 */
/*	// TODO: MICHAEL 2022-06-21 공통 썸네일
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

	}*/

	@RequestMapping(value="/SmartEditorMultiImageUpload")
	public void SmartEditorMultiImageUpload(HttpServletRequest request, HttpServletResponse response){
		try {
			//파일정보
			String sFileInfo = "";
			//파일명을 받는다 - 일반 원본파일명
			String sFilename = request.getHeader("file-name");
			//파일 확장자
			String sFilenameExt = sFilename.substring(sFilename.lastIndexOf(".")+1);
			//확장자를소문자로 변경
			sFilenameExt = sFilenameExt.toLowerCase();

			//이미지 검증 배열변수
			String[] allowFileArr = {"jpg","png","bmp","gif"};

			//확장자 체크
			int nCnt = 0;
			for(int i=0; i<allowFileArr.length; i++) {
				if(sFilenameExt.equals(allowFileArr[i])){
					nCnt++;
				}
			}

			//이미지가 아니라면
			if(nCnt == 0) {
				PrintWriter print = response.getWriter();
				print.print("NOTALLOW_"+sFilename);
				print.flush();
				print.close();
			} else {
				//디렉토리 설정 및 업로드

				//파일경로
				String filePath = "C:/Temp";
				File file = new File(filePath);

				if(!file.exists()) {
					file.mkdirs();
				}

				String sRealFileNm = "";
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
				String today= formatter.format(new java.util.Date());
				sRealFileNm = today+UUID.randomUUID().toString() + sFilename.substring(sFilename.lastIndexOf("."));
				String rlFileNm = filePath + sRealFileNm;

				///////////////// 서버에 파일쓰기 /////////////////
				InputStream inputStream = request.getInputStream();
				OutputStream outputStream=new FileOutputStream(rlFileNm);
				int numRead;
				byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
				while((numRead = inputStream.read(bytes,0,bytes.length)) != -1){
					outputStream.write(bytes,0,numRead);
				}
				if(inputStream != null) {
					inputStream.close();
				}
				outputStream.flush();
				outputStream.close();

				///////////////// 이미지 /////////////////
				// 정보 출력
				sFileInfo += "&bNewLine=true";
				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
				sFileInfo += "&sFileName="+ sFilename;
				sFileInfo += "&sFileURL="+"C:/Temp"+sRealFileNm;
				PrintWriter printWriter = response.getWriter();
				printWriter.print(sFileInfo);
				printWriter.flush();
				printWriter.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
