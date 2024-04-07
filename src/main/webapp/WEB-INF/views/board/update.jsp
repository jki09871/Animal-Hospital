<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form id="updateForm" action="/board/update" method="post">
        <table>
            <tr>
                <th>title</th>
                <td><input type="text" name="title" value="<c:out value="${board.title}"/>"></td>
            </tr>
            <tr>
                <th>content</th>
                <td><textarea rows="10" cols="30" name="content"><c:out value="${board.content}"/></textarea> </td>
                <td><input type="submit" value="수정"></td>
            </tr>
        </table>
        <input type="hidden" name="bno" id="bno" value="<c:out value="${board.bno}"/>">
    </form>
</body>
</html>
