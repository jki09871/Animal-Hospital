<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<div>
    <input type="text" name="code" id="code" value="${code}">
    <input type="text" name="connected_at" id="connected_at" value="${access_token}">
    <input type="text" name="userInfo" id="userInfo" value="${id}">

</div>

<a href="/member/logout">로그아웃</a>

</body>
</html>
