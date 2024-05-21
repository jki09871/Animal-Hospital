<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 60%;
            position: fixed; /* 고정 위치 설정 */
            top: 50%; /* 화면 상단에서 절반 위치로 설정 */
            left: 50%; /* 화면 좌측에서 절반 위치로 설정 */
            transform: translate(-50%, -50%); /* 화면 중앙으로 이동 */
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .detail-item {
            margin-bottom: 10px;
        }

        .detail-label {
            font-weight: bold;
        }

        .edit-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            float: right;
        }

        .edit-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="detail-item">
        <span class="detail-label">마이크로칩 번호 : </span>
        <span>${read.pet_Id}</span>
    </div>
    <div class="detail-item">
        <span class="detail-label">이름 : </span>
        <span>${read.pet_Name}</span>
    </div>
    <div class="detail-item">
        <span class="detail-label">나이 : </span>
        <span>${read.pet_Age}(${read.calculated_age}살)</span>
    </div>
    <div class="detail-item">
        <span class="detail-label">증상 : </span>
        <span>${read.symptoms}</span>
    </div>
    <div class="detail-item">
        <span class="detail-label">진단 : </span>
        <span>${read.diagnosis}</span>
    </div>
    <div class="detail-item">
        <span class="detail-label">치료 : </span>
        <span>${read.treatment}</span>
    </div>
    <div class="detail-item">
        <span class="detail-label">처방 : </span>
        <span>${read.prescription}</span>
    </div>
    <a href="${read.record_Id}"  class="edit-button" id="edit">수정</a>
    <a href="${read.pet_Id}" class="edit-button" id="back" >이전</a>
    <form id="DynamicForm" action="/pet/prescription/edit" method="get">
        <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
        <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
        <input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
    </form>
</div>
</body>
<script>

    let pageMove = $('#DynamicForm');
    let url = '';
    $('#edit').on('click', function (e) {
        e.preventDefault();

        pageMove.find('#newinput').remove();

        pageMove.append("<input type='hidden' id='newinput' name='record_Id' value='" + $(this).attr("href") + "'>");
        pageMove.attr('action', '/pet/prescription/edit');
        pageMove.submit();
    });
    $('#back').on('click', function (e) {
        e.preventDefault();

        pageMove.find('#newinput').remove();

        pageMove.append("<input type='hidden' id='newinput' name='pet_Id' value='" + $(this).attr("href") + "'>");
        pageMove.attr('action', '/pet/prescription/details');
        pageMove.submit();
    });
</script>
</html>
