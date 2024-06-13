<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%><html><html><html>
<head>
  <title>Title</title>
</head>
<body>
<form action="/member/login.do" method="post">
  <input type="text" name="memberEmail" placeholder="이메일">
  <input type="text" name="memberPassword" placeholder="비밀번호">
  <input type="submit" value="로그인"><br>
  <a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=62a17ffd40c8b2fcee6a84a3e8d29e93&redirect_uri=http://localhost:8090/member/kakao&response_type=code">
    <img src="/resources/kakao_login_medium_narrow.png" style="height: 60px"/>
  </a>
  <div id="naver_id_login" ><a href="${url}">
    <img width="223" src="/resources/naverLogin.png"/></a>
  </div>
</form>
  <div> <a href="/board/list">게시글 목록</a></div>
  <div> <a href="/member/joinmembership">회원가입</a></div>

</body>
</html>
