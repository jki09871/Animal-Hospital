<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
<script src="/resources/bootstrap/bootstrap.bundle.min.js"></script>

<html>
<head>
    <title>Title</title>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid bg-success p-2 text-white bg-opacity-75">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/board/save">글작성</a><br>
                </li>
            <c:choose>
                <c:when test="${sessionScope.loginEmail != null || sessionScope.kakaosessionId != null || sessionScope.naversessionId != null}">
                    <li class="nav-item">
                        <c:choose>
                            <c:when test="${sessionScope.loginEmail != null}">
                                <a class="nav-link">${sessionScope.loginEmail}님 환영합니다.</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/logout">로그아웃</a>
                                </li>
                            </c:when>

                            <c:when test="${sessionScope.kakaosessionId != null}">
                                <li class="nav-item">
                                <a class="nav-link">${sessionScope.kakaosessionId}님 환영합니다.</a>
                                </li>
                                <li class="nav-item">
                                <a class="nav-link" href="/member/kakao/logout">로그아웃</a>
                                </li>
                            </c:when>

                            <c:when test="${sessionScope.naversessionId != null}">
                                <li class="nav-item">
                                    <a class="nav-link">${sessionScope.naversessionId}님 환영합니다.</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/naver/logout">로그아웃</a>
                                </li>
                            </c:when>
                        </c:choose>

                        </c:when>
                        <c:when test="${sessionScope.loginEmail == null}">
                <li class="nav-item">
                                <a class="nav-link" href="/member/login">로그인</a><br>
                </li>
                <li class="nav-item">
                                <a class="nav-link" href="/member/joinmembership">회원가입</a><br>
                        </c:when>
                    </c:choose>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Dropdown
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Action</a></li>
                        <li><a class="dropdown-item" href="#">Another action</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>

    <table class="table table-hover table-striped text-center">
        <tr>
            <th>bno</th>
            <th>title</th>
            <th>writer</th>
            <th>time</th>
            <th>hits</th>
        </tr>
        <c:forEach items="${boardList}" var="board">
            <tr>
                <td>${board.bno}</td>
                <th>
                    <a href="/board/read?bno=${board.bno}">${board.title}</a>
                </th>
                <td>${board.writer}</td>
                <td><fmf:formatDate value="${board.time}" pattern="yyyy-MM-dd"/></td>
                <td>${board.hits}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
