<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/resources/jquery-3.7.1.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="/animal/signup" method="post" name="joinFrom" id="joinFrom">
        <div id="signup">
            <div id="divId">
                <input type="text" id="id" name="OwnerId" placeholder="아이디" class="input_id"  autocomplete="off" required>
                <button type="button" id="IdCheck" name="IdCheck" onclick="fn_idCheck()">아이디 확인</button>
                <div id="IdCheckResult">영문자로 시작하며 숫자 6~20자를 이용해주세요</div>
            </div>
            <div id="divPw">
                <input type="password" id="pw" name="OwnerPassword" placeholder="비밀번호" class="input_pw"  autocomplete="off" required>
                <div id="PwCheckResult">8 ~ 16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.</div>
                <input type="password" id="pw2" name="OwnerPassword2" placeholder="비밀번호 확인" class="input_pw"  autocomplete="off" required>
                <div id="PwCheckResult2"></div>
            </div>
            <div id="divEm">
                <input type="email" id="em" name="OwnerEmail" placeholder="이메일" class="input_em" autocomplete="off" required>
                <button type="button" id="EmailCheck" name="EmailCheck" onclick="fn_EmailCheck()">이메일 확인</button>
                <div id="EmailCheckResult">이메일을 입력 해주세요</div>
            </div>
            <div id="divPn">
                <input type="text" id="pn" name="OwnerPhoneNumber" placeholder="전화번호'-'없이입려해주세요" class="input_pn" autocomplete="off" required>
            </div>
            <div id="divPetId">
                <input type="text" id="pi" name="petId" placeholder="마이크로칩 번호" class="input_pi" autocomplete="off" required>
            </div>
        </div> <%-- <div id="signup"> --%>
        <button type="button" onclick="fnJoin();">가입하기</button>
    </form>
</body>
<script>

    /*************************************** 아이디 정규식 검사 *********************************************/
    function validateId(IdCheck) {
        var regExp = /^(?:[a-z][a-z0-9]{5,19}|[0-9][a-z0-9]{5,19})$/i;
        return regExp.test(IdCheck);
    }


    $('#id').on('keyup', function () { /** 타자치면서 검사 **/
        var IdCheck = $('#id').val();
        var IdValid = validateId(IdCheck);
        if (IdValid) {
            $('#IdCheckResult').data("result", 1);
            $('#IdCheckResult').data('IdResult', 0);
            $('#IdCheckResult').text("아이디 확인버튼을 눌러주세요.")
        }else {
            $('#IdCheckResult').data("result", 0);
            $('#IdCheckResult').text("영문자로 시작하며 숫자 6~20자를 이용해주세요");
            return;
        }

    });


    function fn_idCheck(){
        var IdCheck = $('#id').val();

        if ($('#IdCheckResult').data("result") === 1) {

            $.ajax({
                url: "/animal/EmailCheck",
                type: "GET",
                data: {IdCheck: IdCheck},
                dataType: "json",
                success: function (data) {
                    console.log(data);

                    if (data == false) {
                        $('#IdCheckResult').data('IdResult', 0);
                        $('#IdCheckResult').text("중복된 아이디 입니다.")
                        return;
                    } else {
                        $('#IdCheckResult').data("IdResult", 1);
                        $('#IdCheckResult').text("사용 가능한 아이디 입니다.");
                    }
                },
                error: function (request, status, error) {

                    console.log("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:" + error);

                }
            });
        }
    }
    /*************************************** 아이디 정규식 끝 ***********************************************/

    /*************************************** 이메일 정규식 검사 *********************************************/
    function validateEmail(EmailCheck) {
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return emailRegex.test(EmailCheck);
    }

    $('#em').on('keyup', function () { /** 타자치면서 검사 **/
        var EmailCheck = $('#em').val();
        var EmailValid = validateEmail(EmailCheck);
        if (EmailValid) {
            $('#EmailCheckResult').data("result", 1);
            $('#EmailCheckResult').data('EmailResult', 0);
            $('#EmailCheckResult').text("이메일 확인버튼을 눌러주세요.")
        }else {
            $('#EmailCheckResult').data("result", 0);
            $('#EmailCheckResult').text("이메일을 입력 해주세요");
            return;
        }

    });

    function fn_EmailCheck(){
        var email = $('#em').val();

        if ($('#EmailCheckResult').data("result") === 1) {
            $.ajax({
                url: "/animal/EmailCheck",
                type: "GET",
                data: {email: email},
                dataType: "json",
                success: function (data) {
                    console.log(data);

                    if (data == false) {
                        $('#EmailCheckResult').data('EmailResult', 0);
                        $('#EmailCheckResult').text("중복된 이메일 입니다.")

                        return;
                    } else {
                        $('#EmailCheckResult').data("EmailResult", 1);
                        $('#EmailCheckResult').text("사용 가능한 이메일 입니다.");
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

    /************************************** 비밀번호 정규식 검사 ********************************************/

    function isPassword(asValue) {
        var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
        return regExp.test(asValue);
    }

    $('#pw').on('keyup', function () {
        /** 타자치면서 검사 **/
        var IdCheck = $('#pw').val();
        var PasswordValid = isPassword(IdCheck);
        if (PasswordValid) {
            $('#PwCheckResult').data("result", 1);
            $('#PwCheckResult').text("");
        } else {
            $('#PwCheckResult').data("result", 0);
            $('#PwCheckResult').text("8 ~ 16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
            return;
        }
    });

    $('#pw2').on('keyup', function () {
       var pw = $('#pw').val();
       var pw2 = $('#pw2').val();
       if (pw == pw2){
           $('#PwCheckResult2').data("result", 1);
           $('#PwCheckResult2').text("");
       } else {
           $('#PwCheckResult2').data("result", 0);
           $('#PwCheckResult2').text("비밀번호를 확인 해주세요");
       }
    });
    /************************************** 비밀번호 정규식 끝 ********************************************/

    /************************************** 전화번호 정규식 끝 ********************************************/

    function isPhoneNumber(phone) {
        var regExp = /^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$/;
        return regExp.test(phone);
    }

    $('#pn').on('keyup', function () {
        var phone = $('#pn').val();
        var phoneCheck = isPhoneNumber(phone);

        if (phoneCheck) {
            console.log("성공")

            $('#pn').data("result", 1);
        } else {
            console.log("실패")
            $('#pn').data("result", 0);
            return;
        }
    });

        function fnJoin(e) {
            var valid = true;
            var userid = $('#id');          // 사용자 아이디
            var userPassword = $('#pw');    // 사용자 비밀번호
            var userEmail = $('#em');       // 사용자 이메일
            var userPhoneNum = $('#pn');    // 사용자 핸드폰 번호
            var userPetId = $('#pi');       // 사용자 동물 고유번호


            // if (!userid.val() || $('#IdCheckResult').data("result") === 0 || $('#IdCheckResult').data("IdResult") === 0) {
            //     alert("아이디를 확인 해주세요.")
            //     userid.focus();
            //     e.preventDefault();
            //     return;
            // } else if (!userPassword.val() || $('#PwCheckResult2').data("result") === 0) {
            //     userPassword.focus();
            //     e.preventDefault();
            //     return;
            // } else if (!userEmail.val() || $('#EmailCheckResult').data("EmailResult") === 0 || $('#EmailCheckResult').data("result") === 0) {
            //     alert("이메일을 확인 해주세요.")
            //     userEmail.focus();
            //     e.preventDefault();
            //     return;
            // } else
                if (!userPhoneNum.val() || $('#pn').data("result") === 0){
                userPhoneNum.focus();
                e.preventDefault();
                return;
            // } else if (!userPetId.val()) {
            //     userPetId.focus();
            //     e.preventDefault();
            //     return;
            } else if (valid) {
                alert("회원가입이 완료 되었습니다.")
                // $(this).submit();
                // $("#joinFrom").submit();
            }
        }
</script>
</html>
