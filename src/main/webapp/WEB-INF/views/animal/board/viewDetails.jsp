<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <table>
        <tr>
            <th>reviewNum</th>
            <td>${animal.reviewNum}</td>
        </tr>
        <tr>
            <th>writer</th>
            <td>${animal.writer}</td>
        </tr>
        <tr>
            <th>title</th>
            <td>${animal.title}</td>
        </tr>
        <tr>
            <th>content</th>
            <td>${animal.content}</td>
        </tr>
        <tr>
            <th>time</th>
            <td>
                <fmf:formatDate value="${animal.regdate}" pattern="yyyy-MM-dd"/>
            </td>
        </tr>
    </table>
    </div>
    <button onclick="fnDynamic('L')">목록</button>
    <button onclick="fnDynamic('U')">수정</button>
    <button onclick="fnDynamic('D')">삭제</button>
    <form method="get" action="/animal/correction/" id="readForm">
        <input type="hidden" name="reviewNum" value="<c:out value="${animal.reviewNum}"/>">
    </form>
</body>

<script>
    let form = $('#readForm');
    let url = '';
    function fnDynamic(se){
        switch (se){
            case 'L' :
                url = '/animal/reviewList';
                break;
            case 'U' :
                url = '/animal/correction';
                break;
            default :
                // 사용자에게 확인 대화 상자 표시
                const isConfirmed = confirm("게시물을 삭제 하시겠습니까?");

                // 사용자가 확인을 선택했을 경우 true
                if (isConfirmed) {

                    // 확인을 선택한 경우
                    alert("삭제 되었습니다..");

                } else {
                    //  사용자가 취소를 선택했을 경우 false
                    alert("삭제가 취소되었습니다.");
                    return false;

                }


                // // 예제로 사용할 비밀번호
                // const correctPassword = "123";
                //
                // // prompt를 통해 사용자로부터 비밀번호를 입력 받음
                // const enteredPassword = prompt("비밀번호를 입력하세요:");
                //
                // // 입력된 비밀번호가 정확한지 확인하고 결과 반환
                // const isCorrectPassword = enteredPassword == correctPassword;
                //
                // // 비밀번호가 일치하지 않으면 경고 메시지를 표시하고 동작을 멈춤
                // if (!isCorrectPassword) {
                //     alert("비밀번호가 올바르지 않습니다.");
                //     throw new Error("비밀번호가 올바르지 않습니다."); // 에러를 발생시켜 동작을 중단함
                // }
                //
                // // 이후에 실행되는 코드
                // alert("비밀번호가 확인되었습니다");


                url = '/animal/deletePost';
                break;
        }

        form.attr('action', url);
        form.submit();
    }

</script>
</html>
