<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/styles.css">
</head>
<body>
<form method="post" action="/animal/editInfo" id="editForm" class="edit-form">
    <table class="custom-table">
        <tr>
            <th>아이디</th>
            <td><input type="text" name="owner_Id" id="ownerId" value="${animal.owner_Id}" readonly>변경불가</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="text" id="em" name="email" placeholder="이메일" class="input-email" value="${animal.email}" autocomplete="off" required>
                <button type="button" id="emailCheck" name="emailCheck" onclick="fn_emailCheck()">이메일 확인</button>
                <div id="emailCheckResult" class="email-check-result"></div>
            </td>
        </tr>
        <tr>
            <th>핸드폰 번호</th>
            <td><input type="text" name="phoneNumber" id="pn" placeholder="'-' 빼고 입력해주세요" value="${animal.phoneNumber}" class="phone-number">
                <div id="phoneNumberCheckResult" class="phone-number-check-result"></div>
            </td>
        </tr>
    </table>
    <button type="button" onclick="editInfo();" class="btn-custom btn-edit-info">정보수정</button>
    <button type="button" onClick="history.back();" class="btn-custom btn-go-back" >이전</button>
</form>
</body>
<script>
    let form = $('#editForm');

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
            form.submit();

        } else {
            //  사용자가 취소를 선택했을 경우 false
            alert("수정 취소되었습니다.");
            form.attr('method', 'get');
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
            $('#emailCheckResult').text("이메일을 입력 해주세요");
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


    /************************************** 전화번호 정규식 끝 ********************************************/

    function isPhoneNumber(phone) {
        var regExp = /^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{5}$/;
        return regExp.test(phone);
    }

    $('#pn').on('keyup', function () {
        var phone = $('#pn').val();
        var phoneCheck = isPhoneNumber(phone);

        if (phoneCheck) {
            $('#phoneNumberCheckResult').html("");
        } else {
            $('#phoneNumberCheckResult').html("전화번호를 확인 해주세요");
            return;
        }
    });
</script>
</html>
