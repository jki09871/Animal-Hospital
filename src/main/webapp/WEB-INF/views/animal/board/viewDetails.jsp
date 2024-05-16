<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            flex-direction: column;
        }
        table {
            width: 50%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-container {
            text-align: center;
        }
        button {
            margin: 0 5px;
            padding: 8px 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<table>
    <tr>
        <th>Review Number</th>
        <td>${animal.reviewNum}</td>
    </tr>
    <tr>
        <th>Writer</th>
        <td>${animal.writer}</td>
    </tr>
    <tr>
        <th>Title</th>
        <td>${animal.title}</td>
    </tr>
    <tr>
        <th>Content</th>
        <td>${animal.content}</td>
    </tr>
    <tr>
        <th>Time</th>
        <td><fmt:formatDate value="${animal.regdate}" pattern="yyyy-MM-dd"/></td>
    </tr>
</table>
<form method="get" action="/animal/correction/" id="readForm">
    <input type="hidden" name="reviewNum" value="<c:out value='${animal.reviewNum}'/>">
    <input type="hidden" name="pageNum" value="<c:out value='${criteria.pageNum}'/>">
    <input type="hidden" name="amount" value="<c:out value='${criteria.amount}'/>">
    <input type="hidden" id="FILE_NO" name="FILE_NO" value="">
</form>
<div class="form-group">
    <span>File List</span>
    <br>
    <c:forEach var="file" items="${file}">
        <a href="#" class="file-link" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
    </c:forEach>
</div>
<div class="btn-container">
    <button onclick="fnDynamic('L')">Go Back</button>
    <c:if test="${sessionScope.loginId != null }">
        <button onclick="fnDynamic('U')">Edit</button>
        <button onclick="fnDynamic('D')">Delete</button>
    </c:if>
</div>
<script>
    let form = $('#readForm');
    let url = '';
    function fnDynamic(se){
        switch (se){
            case 'L' :
                url = '/animal/reviewList';
                break;
            case 'U' :
                if (${sessionScope.loginId.owner_Id == animal.writer}) {
                    url = '/animal/correction';
                    break;
                }else {
                    alert("You are not the author.");
                    return ;
                }
            default :
                if (${sessionScope.loginId.owner_Id == animal.writer}) {
                    const isConfirmed = confirm("Do you want to delete this post?");
                    if (isConfirmed) {
                        alert("Deleted successfully.");
                    } else {
                        alert("Deletion canceled.");
                        return false;
                    }
                    url = '/animal/deletePost';
                    form.attr('method', 'post');
                    break;
                } else {
                    alert("You are not the author.");
                }
        }
        form.attr('action', url);
        form.submit();
    }

    function fn_fileDown(fileNo){
        var formObj = $("#readForm");
        $("#FILE_NO").attr("value", fileNo);
        formObj.attr("action", "/animal/fileDown");
        formObj.submit();
    }
</script>
</body>
</html>
