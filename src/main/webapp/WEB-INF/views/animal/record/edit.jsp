<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Title</title>
    <style>
        /* 폼을 가운데로 정렬하고, 스타일링 */
        form {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        textarea {
            height: 100px;
        }
        .submit-button-container {
            text-align: right; /* 버튼을 오른쪽으로 정렬합니다. */
        }
        .DynamicButton {
            margin-left: 10px; /* 버튼 사이의 간격을 조정합니다. */
            width: 100px;
            padding: 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
        }

        .DynamicButton:hover {
            background-color: #45a049;
        }

        input {
            background-color: #f0f0f0; /* 읽기 전용 배경색 */
            cursor: not-allowed; /* 커서 변경 */
        }

    </style>
</head>
<body>
<h2>Add Medical Record</h2>
    <form action="/pet/prescription/edit" method="POST">
        <input type="hidden" name="record_Id" id="record_Id" value="${edit.record_Id}">
        <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
        <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
        <input type="hidden" name="type" value="<c:out value="${cri.type}"/>">

        <label for="pet_Id">마이크로칩 번호:</label><br>
        <input type="text" id="pet_Id" name="pet_Id" required autocomplete="off" value="${edit.pet_Id}"><br><br>

        <label for="pet_Name">이름:</label><br>
        <input type="text" id="pet_Name" name="pet_Name" required autocomplete="off" value="${edit.pet_Name}"><br><br>

        <label for="pet_Age">나이:</label><br>
        <input type="date" id="pet_Age" name="pet_Age" required autocomplete="off" value="${edit.pet_Age}"><br><br>


        <label for="symptoms">증상:</label><br>
        <textarea id="symptoms" name="symptoms" rows="4" cols="50" required autocomplete="off">${edit.symptoms}</textarea><br><br>

        <label for="diagnosis">진단:</label><br>
        <textarea id="diagnosis" name="diagnosis" rows="4" cols="50" required autocomplete="off">${edit.diagnosis}</textarea><br><br>

        <label for="treatment">치료:</label><br>
        <textarea id="treatment" name="treatment" rows="4" cols="50" required autocomplete="off">${edit.treatment}</textarea><br><br>

        <label for="prescription">처방:</label><br>
        <textarea id="prescription" name="prescription" rows="4" cols="50" required autocomplete="off">${edit.prescription}</textarea><br><br>

        <div class="submit-button-container">
            <button type="button" id="reset"  class="DynamicButton">취소</button>
            <button type="button" id="back"  class="DynamicButton">이전</button>
            <button type="submit" class="DynamicButton">수정</button>
        </div>
    </form>
</body>
<script>
    $(document).ready(function (){
        $('#pet_Id, #pet_name, #pet_Age').mousedown(function(event) {
            event.preventDefault();
        });
    });

    $('#back').on('click', function (){
        if (confirm("수정을 취소하고 전 페이지로 가시겠습니까?")){
            history.back();
        }else {
            return false;
        }
    });

    $('#reset').on('click', function (){
        if (confirm("'확인' 클릭시 모든 수정이 원래 상태로 돌아갑니다.")){
            $('#reset').attr("type", "reset");
        } else {
            return false;
        }
    });
</script>
</html>
