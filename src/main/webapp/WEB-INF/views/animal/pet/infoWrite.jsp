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

         #age {
             background-color: #f0f0f0; /* 읽기 전용 배경색 */
             cursor: not-allowed; /* 커서 변경 */
         }

    </style>
</head>
<body>
    <form name="petForm" id="petForm" action="/pet/info/write" method="post">
        <input type="hidden" name="owner_Id" value="<c:out value="${sessionScope.loginId}"/>">

        <table>
            <tr>
                <th>강아지 이름</th>
                <td><input type="text" name="pet_name" id="pet_name" autocomplete="off"></td>
            </tr>
            <tr>
                <th>강아지 품종</th>
                <td><input type="text" name="species" id="species" autocomplete="off"></td>
            </tr>
            <tr>
                <th>강아지 생년월일</th>
                <td>
                    <input type="hidden" name="age" id="age" autocomplete="off">
                    <select id="yearSelect">
                        <option value="">연도</option>
                        <!-- 원하는 연도 범위를 설정하세요 -->
                        <c:forEach var="year" begin="2000" end="2024">
                            <option value="${year}">${year}년</option>
                        </c:forEach>
                    </select>

                    <select id="monthSelect">
                        <option value="">월</option>
                    </select>

                    <select id="daySelect">
                        <option value="">일</option>
                    </select>
                </td>
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
        <button type="button" id="btnPetInfo" name="btn">작성</button>
        <button type="button" onClick="history.back();" >취소</button>
    </form>
</body>
<script>
    $('#btnPetInfo').on('click', function (){
        alert("작성이 완료 되었습니다.")
    });

    $(document).ready(function() {
        // 일 선택 옵션 생성
        $('#daySelect').empty(); // 일 선택 요소 비우기
        for (var i = 1; i <= 31; i++) {
            var day = String(i).padStart(2, '0'); // 한 자리 숫자를 두 자리로 변환
            $('#daySelect').append('<option value="' + day + '">' + day + '일</option>');
        }

        $('#monthSelect').empty(); // 월 선택 요소 비우기
        for (var i = 1; i <= 12; i++) {
            var month = String(i).padStart(2, '0'); // 한 자리 숫자를 두 자리로 변환
            $('#monthSelect').append('<option value="' + month + '">' + month + '월</option>');
        }
    });

    $('#btnPetInfo').on('click', function (){
        let year = $('#yearSelect').val();
        let month = $('#monthSelect').val();
        let day = $('#daySelect').val();

        $('#age').val(year + "-" + month + "-" + day);
        console.log($('#age').val());
        console.log($('#pet_name').val());
        $('#petForm').submit();
    });

</script>
</html>
