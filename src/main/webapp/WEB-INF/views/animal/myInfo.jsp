<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/resources/jquery-3.7.1.js"></script>
<html>
<head>
    <title>Title</title> 
</head>
<body>
        <table>
            <tr>
                <th>아이디</th>
                <td>${sessionScope.loginId}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${animal.email}</td>
            </tr>
            <tr>
                <th>핸드폰 번호</th>
                <td>${animal.phoneNumber}</td>
            </tr>
            <tr>
                <th>동물 아이디</th>
                <td>${animal.petId}</td>
            </tr>
        </table>
        <button><a href="/animal/editInfo">정보수정</a></button>
        <button><a href="/animal/reviewList">이전</a></button>

</body>
<script>


</script>
</html>
