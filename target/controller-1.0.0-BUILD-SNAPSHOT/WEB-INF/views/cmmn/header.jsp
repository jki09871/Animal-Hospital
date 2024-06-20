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

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">


  <title> Animal Adoption - Bootstrap Theme</title>

  <!-- CSS includes -->

  <link href="/resources/animal-adoption/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Karla" rel="stylesheet" type="text/css">
  <link href="/resources/animal-adoption/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="/resources/animal-adoption/css/theme.css" rel="stylesheet">
 <%-- <link rel="stylesheet" type="text/css" href="/resources/animal-adoption/css/all.min.css" />

  <link id="themecss" rel="stylesheet" type="text/css" href="/resources/animal-adoption/css/light-bootstrap-all.min" />--%>


  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <script src="/resources/jquery-3.7.1.js"></script>
  <%-- 썸원 --%>
  <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
</head>
<body>


<!-- Navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container" style=" width: 1230px;">
    <!-- Brand and toggle get grouped for better mobile display -->
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
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#home" class="smooth-scroll">ABOUT</a></li>
        <li><a href="#pets" class="smooth-scroll">OUR PETS</a></li>
        <li><a href="#stories" class="smooth-scroll">STORIES</a></li>
        <li><a href="#gallery" class="smooth-scroll">ADOPT A PET</a></li>
        <li><a href="/animal/reviewList" class="smooth-scroll">REVIEW</a></li>
        <li><a href="/pet/inquiry/list" class="smooth-scroll">INQUIRY</a></li>
        <c:if test="${sessionScope.loginId == null}">
          <li><a href="/animal/login" class="smooth-scroll">LOGIN</a></li>
        </c:if>
        <c:if test="${sessionScope.loginId != null}">
          <li><a href="/animal/myInfo">MY INFO</a></li>
          <li><a href="/animal/logout" class="smooth-scroll">LOGOUT</a></li>
        </c:if>
        <c:if test="${sessionScope.loginId.grade == 99}">
          <form class="navbar-form navbar-right">
              <select class="form-control" onchange='location.href = this.value;'>
                <option value=''>------</option>
                <option value='/pet/prescription/list'>처방전</option>
                <option value='/subscribers/member'>회원가입자 목록</option>
                <option value='/registered/animal'>등록된 동물</option>
              </select>
          </form>
        </c:if>
        <c:if test="${sessionScope.loginId.owner_Id != null}">
          <li>
            <a class="smooth-scroll">${sessionScope.loginId.owner_Id}님 안녕하세요</a>
          </li>
        </c:if>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

