<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Medical Record Details</title>
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
    <h2>Medical Record Details</h2>
    <div class="btn-container">
    <button class="btn">목록</button>
    </div>
    <table>
        <tr>
            <th>PET_NAME</th>
<%--            <th>PET_ID</th>--%>
            <th>DATE_OF_VISIT</th>
            <th>SYMPTOMS</th>
            <th>VETERINARIAN</th>
        </tr>

    <c:forEach var="readList" items="${read}">
        <tr class="pet_info">
            <td>${readList.pet_Name}(${readList.calculated_age}살)</td>
<%--            <td>${readList.pet_Id}</td>--%>
            <td><a class="move" href="${readList.record_Id}">
                <fmt:formatDate value="${readList.date_Of_Visit}" pattern="yyyy-MM-dd"/></a></td>
            <td>${readList.symptoms}</td>
            <td>${readList.doctor}</td>
        </tr>
    </c:forEach>
    </table>


    <form method="get" action="/pet/prescription/list" id="readForm">
        <input type="hidden" name="pageNum" value="<c:out value="${pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${amount}"/>">
        <input type="hidden" name="keyword" value="<c:out value="${keyword}"/>">
    </form>

</body>

<script>
    let readForm = $('#readForm');

    $('.btn').on('click', function (){
        readForm.submit();
    })

    $('.move').on('click', function (e) {
        e.preventDefault();

        readForm.find('#newinput').remove();

        readForm.append("<input type='hidden' id='newinput' name='record_Id' value='" + $(this).attr("href") + "'>");
        readForm.attr('action', '/pet/prescription/details/unravel');
        readForm.submit();
    })
</script>
</html>
