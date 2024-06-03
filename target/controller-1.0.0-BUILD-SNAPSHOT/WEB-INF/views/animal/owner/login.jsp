<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/styles.css">
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<header>
  <nav>
    <a href="/">홈</a>
    <a href="/animal/reviewList">게시판</a>
  </nav>
</header>
<div class="container-stories">
  <div class="container">
    <div class="basic animal">
      <div class="login-container" style="margin-top: 250px;">
        <h1>로그인</h1>
        <form action="/animal/login" method="post">
          <input type="text" name="owner_Id" value="${cookie.owner_Id.value}" placeholder="아이디" autocomplete="off" required>
          <input type="password" name="password" placeholder="비밀번호" autocomplete="off" required>
          <input type="hidden" name="toURL" value="${param.toURL}">
          <label><input type="checkbox" name="rememberId"${empty cookie.owner_Id.value ? "":"checked" }> 아이디 기억</label>
          <input type="submit" value="로그인">
        </form>
        <div class="links">
          <a href="/animal/signup">회원가입</a>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
    let msg = "${param.msg}";
    if (msg != null && msg != ""){
      console.log(msg);
      alert(msg);
    }


</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
