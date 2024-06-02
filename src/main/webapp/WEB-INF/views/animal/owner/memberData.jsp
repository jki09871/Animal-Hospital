<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <title>Subscriber Details</title>
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
        .btn-back {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h3 class="text-center">Subscriber Details</h3>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>OWNER_ID</th>
                    <td><c:out value="${data.owner_Id}"></c:out></td>
                </tr>
                <tr>
                    <th>EMAIL</th>
                    <td><a class="move" href="/subscribers/look?owner_Id=${data.owner_Id}"><c:out value="${data.email}"></c:out></a></td>
                </tr>
                <tr>
                    <th>PHONENUMBER</th>
                    <td><c:out value="${data.phoneNumber}"></c:out></td>
                </tr>
                <tr>
                    <th>REGDATE</th>
                    <td><fmt:formatDate value="${data.regDate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </table>
            <div class="text-center">
                <a href="/subscribers/member" class="btn btn-primary btn-back">돌아가기</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
