<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="/resources/jquery-3.7.1.js"></script>

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
      <input type="text" name="owner_Id" value="${cookie.owner_Id.value}" placeholder="아이디" autocomplete="off" required>
      <input type="password" name="password" placeholder="비밀번호" autocomplete="off" required>
      <input type="hidden" name="toURL" value="${param.toURL}">
      <label><input type="checkbox" name="rememberId"${empty cookie.id.value ? "":"checked" }> 아이디 기억</label>
      <input type="submit" value="로그인">
    </form>
    <div class="links">
      <a href="/animal/signup">회원가입</a>
    </div>
  </div>
</div>
</body>
</html>
<script>
    let msg = "${param.msg}";
    if (msg != null && msg != ""){
      console.log(msg);
      alert(msg);
    }
    $(document).ready(function(){
      alert("${cookie.owner_Id.value}");
    })

</script>