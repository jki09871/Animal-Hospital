<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="updateForm" action="/animal/correction" method="post" enctype="multipart/form-data">
    <input type="hidden" name="writer" id="writer" value="<c:out value="${animal.writer}"/>">
    <table>
        <tr>
            <th>title</th>
            <td><input type="text" name="title" value="<c:out value="${animal.title}"/>"></td>
        </tr>
        <tr>
            <th>content</th>
            <td style="width: 600px;">
                <!-- 에디터를 표시할 textarea -->
                <textarea id="summernote" rows="5" name="content" style="width:100%; height:250px;">${animal.content}</textarea>
            </td>
            <td><input type="submit" value="수정"></td>
        </tr>
    </table>
    <input type="hidden" name="reviewNum" id="reviewNum" value="<c:out value="${animal.reviewNum}"/>">
</form>
</body>

<script>

</script>
</html>
