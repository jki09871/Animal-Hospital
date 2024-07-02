<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<style>
    .form-container {
        width: 100%;
        max-width: 400px;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 0 auto;
    }
    .form-container h1 {
        text-align: center;
        color: #007B9E;
        margin-bottom: 20px;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .form-group input {
        width: calc(100% - 22px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .form-group button {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .form-group button:hover {
        background-color: #45a049;
    }
    .form-group div {
        margin-top: 5px;
        font-size: 0.9em;
        color: #777;
    }
    #idCheck, #emailCheck {
        margin-top: 10px;
        background-color: #008CBA;
    }
    #idCheck:hover, #emailCheck:hover {
        background-color: #007B9E;
    }
    #pwCheckResult2 {
        color: red;
    }
</style>

<div class="container-stories">
    <div class="form-container">
        <h1 class="text-primary">OWNER SIGNUP</h1>
        <form action="/animal/signup" method="post" name="joinFrom" id="joinFrom">
            <div id="signup">
                <div class="form-group" id="divId">
                    <label for="id">아이디</label>
                    <input type="text" id="id" name="owner_Id" placeholder="아이디" class="input_id" autocomplete="off" required>
                    <button type="button" id="idCheck" name="idCheck" onclick="fn_idCheck()">아이디 확인</button>
                    <div id="idCheckResult">영문자로 시작하며 숫자 6~20자를 이용해주세요</div>
                </div>
                <div class="form-group" id="divNm">
                    <label for="owner_nm">이름</label>
                    <input type="text" id="owner_nm" name="owner_nm" placeholder="이름" class="owner_nm" autocomplete="off" required>
                </div>
                <div class="form-group" id="divPw">
                    <label for="pw">비밀번호</label>
                    <input type="password" id="pw" name="password" placeholder="비밀번호" class="input_pw" autocomplete="off" required>
                    <div id="pwCheckResult">8 ~ 16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.</div>
                    <label for="pw2">비밀번호 확인</label>
                    <input type="password" id="pw2" name="ownerPassword2" placeholder="비밀번호 확인" class="input_pw" autocomplete="off" required>
                    <div id="pwCheckResult2"></div>
                </div>
                <div class="form-group" id="divEm">
                    <label for="em">이메일</label>
                    <input type="email" id="em" name="email" placeholder="이메일" class="input_em" autocomplete="off" required>
                    <button type="button" id="emailCheck" name="emailCheck" onclick="fn_emailCheck()">이메일 확인</button>
                    <div id="emailCheckResult">이메일을 입력 해주세요</div>
                </div>
                <div class="form-group" id="divPn">
                    <label for="pn">전화번호</label>
                    <input type="text" id="pn" name="phoneNumber" placeholder="전화번호'-'없이입력해주세요" class="input_pn" autocomplete="off" required>
                </div>
                <button type="button" onclick="fnJoin();">가입하기</button>
            </div>
        </form>
    </div>
</div>
<script>

    /*************************************** 아이디 정규식 검사 *********************************************/
    function validateId(idCheck) {
        var regExp = /^(?:[a-z][a-z0-9]{5,19}|[0-9][a-z0-9]{5,19})$/i;
        return regExp.test(idCheck);
    }


    $('#id').on('keyup', function () { /** 타자치면서 검사 **/
        var idCheck = $('.input_id').val();
        var idValid = validateId(idCheck);
        if (idValid) {
            $('#idCheckResult').data("result", 1);
            $('#idCheckResult').data('IdResult', 0);
            $('#idCheckResult').text("아이디 확인버튼을 눌러주세요.")
        }else {
            $('#idCheckResult').data("result", 0);
            $('#idCheckResult').text("영문자로 시작하며 숫자 6~20자를 이용해주세요");
            return;
        }

    });


    function fn_idCheck(){
        var ownerId = $('.input_id').val();
        console.log(ownerId);

        if ($('#idCheckResult').data("result") === 1) {

            $.ajax({
                url: "/animal/emailCheck",
                type: "GET",
                data: {ownerId: ownerId},
                dataType: "json",
                success: function (data) {
                    console.log(data);

                    if (data == false) {
                        $('#idCheckResult').data('IdResult', 0);
                        $('#idCheckResult').text("중복된 아이디 입니다.")
                        return;
                    } else {
                        $('#idCheckResult').data("IdResult", 1);
                        $('#idCheckResult').text("사용 가능한 아이디 입니다.");
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
    function validateEmail(emailCheck) {
        var emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com|outlook\.com|naver\.com|hanmail\.net|daum\.net|hotmail\.com|icloud\.com|aol\.com|protonmail\.com)$/;
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

    /************************************** 비밀번호 정규식 검사 ********************************************/

    function isPassword(asValue) {
        var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
        return regExp.test(asValue);
    }

    $('#pw').on('keyup', function () {
        /** 타자치면서 검사 **/
        var idCheck = $('#pw').val();
        var passwordValid = isPassword(idCheck);
        if (passwordValid) {
            $('#pwCheckResult').data("result", 1);
            $('#pwCheckResult').text("");
        } else {
            $('#pwCheckResult').data("result", 0);
            $('#pwCheckResult').text("8 ~ 16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
            return;
        }
    });

    $('#pw2').on('keyup', function () {
       var pw = $('#pw').val();
       var pw2 = $('#pw2').val();
       if (pw == pw2){
           $('#pwCheckResult2').data("result", 1);
           $('#pwCheckResult2').text("");
       } else {
           $('#pwCheckResult2').data("result", 0);
           $('#pwCheckResult2').text("비밀번호를 확인 해주세요");
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


            if (!userid.val() || $('#idCheckResult').data("result") === 0 || $('#idCheckResult').data("IdResult") === 0) {
                alert("아이디를 확인 해주세요.")
                userid.focus();
                e.preventDefault();
                return;
            } else if (!userPassword.val() || $('#pwCheckResult2').data("result") === 0) {
                userPassword.focus();
                e.preventDefault();
                return;
            } else if (!userEmail.val() || $('#emailCheckResult').data("EmailResult") === 0 || $('#emailCheckResult').data("result") === 0) {
                alert("이메일을 확인 해주세요.")
                userEmail.focus();
                e.preventDefault();
                return;
            } else
                if (!userPhoneNum.val() || $('#pn').data("result") === 0){
                userPhoneNum.focus();
                e.preventDefault();
                return;
            }  else if (valid) {
                alert("회원가입이 완료 되었습니다.")
                $("#joinFrom").submit();
            }
        }
</script>
</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
