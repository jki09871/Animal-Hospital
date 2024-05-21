<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
    <link rel="stylesheet" href="/resources/styles.css">
    <script src="/resources/jquery-3.7.1.js"></script>
</head>
<body>
<header>
    <nav>
        <a href="/">홈</a>
    </nav>
</header>
<div class="container">
    <div class="panel-body">
        <table>
            <tr>
                <th>아이디</th>
                <td>${animal.owner_Id}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${animal.email}</td>
            </tr>
            <tr>
                <th>핸드폰 번호</th>
                <td>${animal.phoneNumber}</td>
            </tr>
        </table>
        <div class="btn-group">
            <button type="button" class="btn" onclick="fnDynamic('E');">정보수정</button>
            <button type="button" class="btn" onclick="fnDynamic('L');">이전</button>
            <button type="button" class="btn" onclick="fnDynamic('W');">애견등록</button>
            <button type="button" class="btn" onclick="fnDynamic('I');">애견등록확인</button>
        </div>
        <form id="petForm" action="/animal/myInfo" method="get">
            <input type="hidden" name="ownerId" id="ownerId" value="<c:out value='${animal.owner_Id}'/>">
        </form>
    </div>
</div>
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
</body>
</html>
