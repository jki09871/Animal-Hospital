<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<style>
  .login-container {
    max-width: 400px;
    margin: auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
  }

  .login-container h1 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
  }

  .login-container input[type="text"],
  .login-container input[type="password"] {
    width: calc(100% - 22px); /* Adjusting width to account for padding and border */
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
  }

  .login-container input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #5cbf2a;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 10px;
  }

  .login-container input[type="submit"]:hover {
    background-color: #5cbf2a;
  }

  .login-container label {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 10px;
  }

  .login-container input[type="checkbox"] {
    margin-right: 5px;
  }

  .login-container .links {
    margin-top: 20px;
  }

  .login-container .links a {
    color: white;
    text-decoration: none;
  }

  .login-container .links a:hover {
    text-decoration: underline;
  }
  .btn-outline-primary {
    background-color: #5cbf2a;
  }


</style>

<div class="container-stories">
  <div class="container">
    <div class="basic animal">
      <div class="login-container">
        <h1>로그인</h1>
        <form action="/animal/login" method="post">
          <input type="text" name="owner_Id" value="${cookie.owner_Id.value}" placeholder="아이디" autocomplete="off" required>
          <input type="password" name="password" placeholder="비밀번호" autocomplete="off" required>
          <c:choose>
            <c:when test="${pwFailCnt.pwFailCount < 5}">
              <div>비밀번호 ${pwFailCnt.pwFailCount}/5 실패 하셨습니다.</div>
            </c:when>
            <c:when test="${pwFailCnt.pwFailCount >= 5}">
              <div>비밀번호 5회 틀려서 아이디가 잠겼습니다. 관리자에게 문의 해주세요</div>
            </c:when>
          </c:choose>
          <input type="hidden" name="toURL" value="${param.toURL}">
          <label><input type="checkbox" name="rememberId"${empty cookie.owner_Id.value ? "":"checked" }> 아이디 기억</label>
          <label><input type="checkbox" name="useCookie"> 로그인유지</label>
          <input type="submit" value="로그인">
        </form>
        <div class="links">
          <button class="btn btn-outline-primary"><a href="/animal/signup">회원가입</a></button>
          <button class="btn btn-outline-primary" ><a href="/animal/findId">아이디 찾기</a></button>
          <button class="btn btn-outline-primary" ><a href="/animal/findPw">비밀번호 찾기</a></button>
        </div>
      </div>
    </div>
  </div>
</div>


<script>
  let idFail = "${fail}";
  if (idFail != ""){
    alert(idFail);
  }
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
