<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select List</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="/resources/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        #regBtn {
            color: #fff;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center">게시글 리스트</h1>
    <div class="mb-3 text-right">
        <button id="regBtn" class="btn btn-success">글쓰기</button>
    </div>
    <div class="basic board">
        <table class="table table-striped table-bordered" id="dataTable">
            <thead class="thead-dark">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="board" items="${list}">
                <tr>
                    <td><c:out value="${board.inquiryNum}"></c:out></td>
                    <td><a href="/pet/inquiry/get?inquiryNum=${board.inquiryNum}"><c:out value="${board.title}"></c:out></a></td>
                    <td><c:out value="${board.writer}"></c:out></td>
                    <td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function () {
        console.log("목록 페이지");
        $('#regBtn').on('click', function (e){
            self.location = "/pet/inquiry/register";
        });
    });
</script>
</body>
</html>
