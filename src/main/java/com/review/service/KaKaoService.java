package com.review.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Log4j
public class KaKaoService {

    public String getToken(String code) throws IOException {
        // 인가ㅣ코드 토큰받기
        String host = "https://kauth.kakao.com/oauth/token";
        URL url = new URL(host);
        HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection(); //HTTP 연결 설정.
        String token = "";
        try {
            urlConnection.setRequestMethod("GET"); // 데이터 방식
            urlConnection.setDoOutput(true); //테이터 기록 알려주기

            // request header 설정
            HttpHeaders headers = new HttpHeaders();
            // Content-type을 application/x-www-form-urlencoded 로 설정
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
            //이 코드는 HTTP 요청의 본문에 데이터를 작성하기 위해 사용되는 것.

            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=62a17ffd40c8b2fcee6a84a3e8d29e93");
            sb.append("&redirect_uri=http://localhost:8090/member/kakao");
            sb.append("&code=" + code);
            // sb.toString()은 생성된 쿼리 문자열을 반환하며, 이 문자열은 HTTP POST 요청의 본문에 포함되어 서버로 전송됩니다

            bw.write(sb.toString());
            bw.flush();
            // 이 코드는 StringBuilder에 있는 문자열을 HTTP 요청의 본문으로 작성하여 해당 요청을 서버에 전송하는 역할을 합니다.

            int responseCode = urlConnection.getResponseCode();
            System.out.println("responseCode = " + responseCode);
            // 이 코드는 HTTP 요청에 대한 서버의 응답 코드를 가져오는 부분(200. 404 등...)

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            // 한 마디로 getInputStream() 이 메서드로 서버에 있는 데이터를 불러오는데 그게 어려운 문자여서 InputStreamReader() 메서드로 번역을 하고
            //BufferedReader 이 메서드는 번역을 마친 것을 읽기 편하도록 나열 해줌

            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("result = " + result);
            // 위에 코드에를 한줄씩 저장 후 보여줌


            // json parsing
            JSONParser parser = new JSONParser();
            JSONObject elem = (JSONObject) parser.parse(result);

            String access_token = elem.get("access_token").toString();
            String refresh_token = elem.get("refresh_token").toString();
            System.out.println("refresh_token = " + refresh_token);
            System.out.println("access_token = " + access_token);

            token = access_token;

            br.close();
            bw.close();

        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        System.out.println("----------------------------------------------");
        return token;
    }

    public Map<String, Object> getUserInfo(String access_token) throws IOException {
        String host = "https://kapi.kakao.com/v2/user/me";
        Map<String, Object> result = new HashMap<>();
        try {
            URL url = new URL(host);

            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestProperty("Authorization", "Bearer " + access_token);
            urlConnection.setRequestMethod("POST");
            // 인증 방식, 액세스 토큰으로 인증 요청

            int responseCode = urlConnection.getResponseCode();
            System.out.println("responseCode = " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));

            String line = "";
            String res = "";
            while ((line = br.readLine()) != null) {
                res += line;
            }
            System.out.println("res = " + res);

            JSONParser parser = new JSONParser();
            JSONObject obj = (JSONObject) parser.parse(res);

            System.out.println("obj = " + obj);


            JSONObject properties = (JSONObject) obj.get("properties");


            String id = obj.get("id").toString();


            String nickname = properties.get("nickname").toString();


            result.put("id", id);
            result.put("nickname", nickname);

            br.close();

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getAgreementInfo(String access_token) {
        String result = "";
        String host = "https://kapi.kakao.com/v2/user/scopes";

        try {
            URL url = new URL(host);
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");
            urlConnection.setRequestProperty("Authorization", "Bearer" + access_token);

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            String line = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }

            int responseCode = urlConnection.getResponseCode();
            System.out.println("responseCode = " + responseCode);

            // result is json format
            br.close();


        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    public void logout(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String result = "";
            String line = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println(result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}