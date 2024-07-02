<%--
  Created by IntelliJ IDEA.
  User: tiaal
  Date: 2024-04-07
  Time: 오후 7:06
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="ko">
<head>
    <script src="/resources/jquery-3.7.1.js" ></script>
<%--    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>--%>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">


  <title> Animal Adoption - Bootstrap Theme</title>

    <%--  CSS includes --%>

   <link href="/resources/animal-adoption/bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Karla" rel="stylesheet" type="text/css">
   <link href="/resources/animal-adoption/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
   <link href="/resources/animal-adoption/css/theme.css" rel="stylesheet">
  <%-- <link rel="stylesheet" type="text/css" href="/resources/animal-adoption/css/all.min.css" />

   <link id="themecss" rel="stylesheet" type="text/css" href="/resources/animal-adoption/css/light-bootstrap-all.min" />--%>


<%-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries
 WARNING: Respond.js doesn't work if you view the page via file://
[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]--%>
  <%-- 썸원 --%>
  <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
    <style>

    </style>
</head>
<body>


<%--Navbar --%>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container" <%--style=" width: 1800px;"--%>>
<%--Brand and toggle get grouped for better mobile display --%>
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a  href="/" title="Animal Adoption Bootstrap Theme">
        <img class="logo" src="/resources/animal-adoption/images/logo.png" alt="Animal Adoption Bootstrap Theme" style="margin-top:5px;" />
      </a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/adoption/animal/list" class="smooth-scroll">입양하기</a></li>
        <li><a href="/animal/reviewList" class="smooth-scroll">리뷰남기기</a></li>
        <li><a href="/pet/inquiry/list" class="smooth-scroll">문의</a></li>
        <c:if test="${sessionScope.loginId == null}">
          <li><a href="/animal/login" class="smooth-scroll">로그인</a></li>
        </c:if>
        <c:if test="${sessionScope.loginId != null}">
          <li><a href="/animal/myInfo">내 활동</a></li>
          <li><a href="/animal/logout" class="smooth-scroll">로그아웃</a></li>
        </c:if>
        <c:if test="${sessionScope.loginId.grade == 99}">
<%--          <li><a href="/pet/prescription/list" class="smooth-scroll">PRESCRIPTION</a></li>--%>
<%--          <li><a href="/subscribers/member" class="smooth-scroll">MEMBER LIST</a></li>--%>
<%--          <li><a href="/registered/animal" class="smooth-scroll">ANIMAL LIST</a></li>--%>

          <li>
            <form class="navbar-form navbar-right">
              <select class="form-control" onchange='location.href = this.value;'>
                <option value=''>------</option>
                <option value='/pet/prescription/list'>처방전</option>
                <option value='/subscribers/member'>회원가입자 목록</option>
                <option value='/registered/animal'>등록된 동물</option>
                <option value='/popUp/list'>팝업 목록</option>
                <option value='/banner/list'>배너 목록</option>
              </select>
            </form>
          </li>
        </c:if>
        <c:if test="${sessionScope.loginId.owner_Id != null}">
          <li>
            <a class="smooth-scroll">${sessionScope.loginId.owner_Id}님 안녕하세요</a>
          </li>
        </c:if>
      </ul>
    </div><%-- /.navbar-collapse --%>
  </div><%-- /.container-fluid --%>
</nav>

