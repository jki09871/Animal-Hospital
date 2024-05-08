<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<html>
<head>
    <title>Title</title>
    <style>
        table{ border-collapse : collapse; }  /*이중선 제거*/
        th,td{
            width: 100px;
            height: 50px;
            text-align: center;
            border: 1px solid #000;

            /*vertical-align: top;	!* 위 *!*/
            /*vertical-align: bottom;   !* 아래 *!*/
            vertical-align: middle;   /* 가운데 */
        }
    </style>
</head>
<body>
    <form name="petForm" id="petForm" action="/animal/pet/info" method="get">
        <table class="pet-table">
            <tr>
                <th>강아지 이름</th>
                <th>강아지 나이</th>
                <th>마이크로칩 번호</th>
                <th>특이사항</th>
                <th></th> <!-- 수정 버튼 셀 -->
            </tr>
            <c:forEach var="pet" items="${pet}">
                <tr class="pet_info">
                    <td>${pet.pet_name}</td>
                    <td>${pet.age}</td>
                    <td>${pet.pet_Id}</td>
                    <td>${pet.significant}</td>
                    <td><button type="button" name="btn">
                        <a href="/pet/info/modify?pet_Id=${pet.pet_Id}">수정</a>
                    </button></td>
                </tr>
            </c:forEach>
        </table>
                <div>
                    <button type="button" onclick="fnDynamic('C');" name="btn">확인</button>
                </div>
    </form>

</body>
<script>
    let form = $('#petForm');
    let url = '';
    function fnDynamic(se){
        switch (se) {
            case 'C' :
                url = '/animal/myInfo';
                break;
        }
        form.attr('action', url);
        form.submit();
    }

    $(document).ready(function (){
        // pet_info 클래스를 갖는 요소의 존재 여부 확인
        if ($('.pet_info').length === 0) {
            alert("등록된 동물이 없습니다.");
            // window.history.back();
            form.attr('action', "/animal/myInfo");
            form.submit();
        }
    });

</script>

</html>
