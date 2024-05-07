<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<html>
<head>
    <title>Title</title>
    <style>
        #significant {
            width: 300px; /* 원하는 가로 크기 */
            height: 200px; /* 원하는 세로 크기 */
            resize: none; /* 크기 조정 금지 */
        }
    </style>
</head>
<body>
    <form name="petForm" id="petForm" action="/pet/info/write" method="post">
        <input type="hidden" name="ownerId" value="<c:out value="${sessionScope.loginId}"/>">

        <table>
            <tr>
                <th>강아지 이름</th>
                <td><input type="text" name="name" id="name" autocomplete="off"></td>
            </tr>
            <tr>
                <th>강아지 나이</th>
                <td><input type="text" name="age" id="age" autocomplete="off"></td>
            </tr>
            <tr>
                <th>마이크로칩 번호</th>
                <td><input type="text" name="pet_Id" id="petid" autocomplete="off"></td>
            </tr>
            <tr>
                <th>특이사항</th>
                <td><textarea type="text" name="significant" id="significant" autocomplete="off"></textarea></td>
            </tr>
        </table>
        <button type="submit" id="btnPetInfo" name="btn">작성</button>
    </form>
</body>
<script>
    $('#btnPetInfo').on('click', function (){
        alert("작성이 완료 되었습니다.")
    });
</script>
</html>
