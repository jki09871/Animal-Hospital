<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인 페이지</title>
  <link rel="stylesheet" href="/resources/styles.css">
</head>
<body>
<header>
  <nav>
    <a href="/">홈</a>
    <a href="/animal/reviewList">게시판</a>
  </nav>
</header>
<div class="container">
  <div class="login-container">
    <h1>로그인</h1>
    <form action="/animal/login" method="post">
      <input type="text" name="owner_Id" placeholder="아이디" autocomplete="off" required>
      <input type="password" name="password" placeholder="비밀번호" autocomplete="off" required>
      <input type="submit" value="로그인">
    </form>
    <div class="links">
      <a href="/animal/signup">회원가입</a>
    </div>
  </div>
</div>
</body>
</html>
