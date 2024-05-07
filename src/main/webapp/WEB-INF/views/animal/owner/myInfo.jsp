<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <td name="petId">${animal.petId}</td>
            </tr>
        </table>
        <button type="button" onclick="fnDynamic('E');">정보수정</button>
        <button type="button" onclick="fnDynamic('L');">이전</button>
        <button type="button" onclick="fnDynamic('W');">애견등록</button>
        <button type="button" onclick="fnDynamic('I');">애견등록확인</button>
<form id="petForm" action="/animal/myInfo" method="get">
    <input type="hidden" name="ownerId" id="ownerId" value="<c:out value="${sessionScope.loginId}"/>">
</form>

</body>
<script>
    let form = $('#petForm');
    let url = '';

    function fnDynamic(es) {
        switch (es) {
            case 'E' :
                url = '/animal/editInfo';
                break;
            case 'L' :
                url = '/animal/reviewList';
                break;
            case 'W' :
                url = '/pet/info/write';
                break;
            default :
                url = '/pet/info';
                break;
        }
        form.attr('action', url);
        form.submit();
    }
</script>
</html>
