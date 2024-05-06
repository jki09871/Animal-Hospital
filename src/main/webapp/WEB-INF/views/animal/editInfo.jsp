<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/resources/jquery-3.7.1.js"></script>
<html>
<head>
    <title>Title</title>
    <style>
        #ownerId {
            background-color: #f0f0f0; /* 읽기 전용 배경색 */
            cursor: not-allowed; /* 커서 변경 */
        }
    </style>
</head>
<body>
    <form method="post" action="/animal/editInfo" id="editForm">
        <table>
            <tr>
                <th>아이디</th>
                <td><input type="text" name="ownerId" id="ownerId" value="${sessionScope.loginId}" readonly>변경불가</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" id="em" name="email" placeholder="이메일" class="input_em" value="${animal.email}" autocomplete="off" required>
                    <button type="button" id="emailCheck" name="emailCheck" onclick="fn_emailCheck()">이메일 확인</button>
                    <div id="emailCheckResult"></div>
                </td>
            </tr>
            <tr>
                <th>핸드폰 번호</th>
                <td><input type="text" name="phoneNumber" id="phoneNumber" value="${animal.phoneNumber}"></td>
            </tr>
            <tr>
                <th>동물 아이디</th>
                <td><input type="text" name="petId" id="petId" value="${animal.petId}"></td>
            </tr>
        </table>
        <button type="submit" onclick="editInfo();">정보수정</button>
        <button type="button" onClick="history.back();" >이전</button>
    </form>
</body>
<script>

    $('#ownerId').on('mousedown', function(event) {
        event.preventDefault();
    });

    function editInfo(e) {
        // 사용자에게 확인 대화 상자 표시
        const isConfirmed = confirm("정보를 수정 하시겠습니까?");

        // 사용자가 확인을 선택했을 경우 true
        if (isConfirmed) {

            // 확인을 선택한 경우
            alert("수정 되었습니다.");

        } else {
            //  사용자가 취소를 선택했을 경우 false
            alert("수정 취소되었습니다.");
            $('#editForm').attr('method', 'get');
            e.preventDefault();
            return ;
        }

    }
    /*************************************** 이메일 정규식 검사 *********************************************/
    function validateEmail(emailCheck) {
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return emailRegex.test(emailCheck);
    }

    $('#em').on('keyup', function () { /** 타자치면서 검사 **/
    var emailCheck = $('#em').val();
        var emailValid = validateEmail(emailCheck);
        if (emailValid) {
            $('#emailCheckResult').data("result", 1);
            $('#emailCheckResult').data('EmailResult', 0);
            $('#emailCheckResult').text("이메일 확인버튼을 눌러주세요.")
        }else {
            $('#emailCheckResult').data("result", 0);
            return;
        }

    });

    function fn_emailCheck(){
        var email = $('#em').val();
        console.log(email);

        if ($('#emailCheckResult').data("result") === 1) {
            $.ajax({
                url: "/animal/emailCheck",
                type: "GET",
                data: {email: email},
                dataType: "json",
                success: function (data) {
                    console.log(data);

                    if (data == false) {
                        $('#emailCheckResult').data('EmailResult', 0);
                        $('#emailCheckResult').text("중복된 이메일 입니다.")

                        return;
                    } else {
                        $('#emailCheckResult').data("EmailResult", 1);
                        $('#emailCheckResult').text("사용 가능한 이메일 입니다.");
                    }
                },
                error: function (request, status, error) {

                    console.log("code:" + request.status + "\n"
                        + "message:" + request.responseText + "\n" + "error:" + error);

                }
            });
        }
    }
    /*************************************** 이메일 정규식 끝 ***********************************************/

</script>
</html>
