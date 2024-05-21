<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Subscriber Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                    <th>마이크로칩</th>
                    <td><c:out value="${data.pet_Id}"/></td>
                </tr>
                <tr>
                    <th>주인(ID)</th>
                    <td><c:out value="${data.owner_Id}"/></td>
                </tr>
                <tr>
                    <th>동물 이름</th>
                    <td><c:out value="${data.pet_name}"/></td>
                </tr>
                <tr>
                    <th>동물 종</th>
                    <td><c:out value="${data.species}"/></td>
                </tr>
                <tr>
                    <th>동물 나이</th>
                    <td><c:out value="${data.age}"/>(살)</td>
                </tr>
                <tr>
                    <th>특이사항</th>
                    <td><c:out value="${data.significant}"/></td>
                </tr>
            </table>
            <div class="text-center">
                <a href="/registered/animal" class="btn btn-primary btn-back">돌아가기</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
