<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            /* 수평 중앙 정렬하기 */
            text-align: center;
        }
        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<h2>Medical Records</h2>
<div class="btn-container">
    <a href="/" class="btn">Go back to Home</a>
    <a href="/pet/prescription/record" class="btn">RecordWrite</a>
</div>
<table>
    <tr>
        <th>Record ID</th>
        <th>Pet ID</th>
        <th>Pet Name</th>
        <th>Pet Age</th>
        <th>Date of Visit</th>
<%--        <th>Symptoms</th>--%>
<%--        <th>Diagnosis</th>--%>
<%--        <th>Treatment</th>--%>
<%--        <th>Prescription</th>--%>
    </tr>
    <c:forEach var="list" items="${recordList}">
        <tr class="pet_info">
            <td>${list.record_Id}</td>
            <td>${list.pet_Id}</td>
            <td><a href="/pet/prescription/details?pet_Id=${list.pet_Id}">${list.pet_Name}</a></td>
            <td>${list.pet_Age}</td>
            <td><fmt:formatDate value="${list.date_Of_Visit}" pattern="yyyy-MM-dd"/></td>
<%--            <td>${list.symptoms}</td>--%>
<%--            <td>${list.diagnosis}</td>--%>
<%--            <td>${list.treatment}</td>--%>
<%--            <td>${list.prescription}</td>--%>
        </tr>
    </c:forEach>
</table>

</body>
</html>
