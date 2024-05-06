<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%><html><html><html>
<head>
  <title>Title</title>
</head>
<body>
<form action="/animal/login" method="post">
  <input type="text" name="ownerId" placeholder="아이디" autocomplete="off">
  <input type="password" name="password" placeholder="비밀번호" autocomplete="off">
  <input type="submit" value="로그인"><br>

</form>
  <div> <a href="/animal/signup">회원가입</a></div>
  <div> <a href="/animal/reviewList">게시판</a></div>
</body>
</html>
