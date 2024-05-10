<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Medical Record Details</title>
    <style>
        /* 컨테이너 스타일링 */
        .container {
            width: 60%;
            margin: 20px auto;
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

        /* 각 항목 스타일링 */
        .detail-item {
            margin-bottom: 20px;
        }

        .detail-label {
            font-weight: bold;
        }

        /* 작성 버튼 스타일링 */
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
    <h2>Medical Record Details</h2>
    <c:forEach var="readList" items="${read}">
        <div class="container">
            <div class="detail-item">
                <span class="detail-label">Pet ID:</span>
                <span>${readList.pet_Id}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Pet Name:</span>
                <span>${readList.pet_Name}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Pet Age:</span>
                <span>${readList.pet_Age}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Symptoms:</span>
                <span>${readList.symptoms}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Diagnosis:</span>
                <span>${readList.diagnosis}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Treatment:</span>
                <span>${readList.treatment}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Prescription:</span>
                <span>${readList.prescription}</span>
            </div>
            <a href="/pet/prescription/edit?record_Id=${record_Id}" class="edit-button">Edit</a>
        </div>
    </c:forEach>
</body>
</html>
