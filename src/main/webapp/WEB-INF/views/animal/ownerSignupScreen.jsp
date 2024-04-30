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
            </div>
            <div id="divEm">
                <input type="email" id="em" name="OwnerEmail" placeholder="이메일" class="input_em" autocomplete="off" required>
                <button type="button" id="EmailCheck" name="EmailCheck" onclick="fn_EmailCheck()">이메일 확인</button>
                <div id="EmailCheckResult"></div>
            </div>
            <div id="divPn">
                <input type="text" id="pn" name="OwnerPhoneNumber" placeholder="전화번호" class="input_pn" autocomplete="off" required>
            </div>
            <div id="divPetId">
                <input type="text" id="pi" name="petId" placeholder="마이크로칩 번호" class="input_pi" autocomplete="off" required>
            </div>
        </div> <%-- <div id="signup"> --%>
        <button type="button" onclick="fnJoin();">가입하기</button>
    </form>
</body>
<script>
    function isId(IdCheck) {
        var regExp = /^[a-z]+[a-z0-9]{5,19}$/g;
        return regExp.test(IdCheck);
    }

    function fn_idCheck(){
        var IdCheck = $('#id').val();
        var IdValid = isId(IdCheck);
        if (!IdValid){
            $('#IdCheckResult').data("result", 1);
            $('#IdCheckResult').text("올바르지 않는 아이디 입니다.")
            return;
        }

        $.ajax({
            url : "/animal/EmailCheck",
            type : "GET",
            data : {IdCheck : IdCheck},
            dataType : "json",
            success: function (data){
                console.log(data);

                if (data == false){
                    let EmailCheck = $('#IdCheckResult').data('result', 1);
                    $('#IdCheckResult').text("중복된 아이디 입니다.")
                    console.log(EmailCheck);
                    return;
                }else {
                    $('#IdCheckResult').data("result", 0);
                    $('#IdCheckResult').text("사용 가능한 아이디 입니다.");
                }
            },
            error:function(request, status, error){

                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

            }
        });
    }

    function validateEmail(email) {
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return emailRegex.test(email);
    }

    function fn_EmailCheck(){
        var email = $('#em').val();
        var Check = validateEmail(email);
        if (!Check){
            $('#EmailCheckResult').data("result", 1);
            $('#EmailCheckResult').text("이메일 형식이 올바르지 않습니다.")
            return;
        }

        $.ajax({
            url : "/animal/EmailCheck",
            type : "GET",
            data : {email: email},
            dataType : "json",
            success: function (data){
                console.log(data);

                if (data == false){
                    let EmailCheck = $('#EmailCheckResult').data('result', 1);
                    $('#EmailCheckResult').text("중복된 이메일 입니다.")
                    console.log(EmailCheck);
                    return;
                }else {
                    $('#EmailCheckResult').data("result", 0);
                    $('#EmailCheckResult').text("사용 가능한 이메일 입니다.");
                }
            },
            error:function(request, status, error){

                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

            }
        })
    }



    function fnJoin(e){
        var valid = true;
        var userid = $('#id');          // 사용자 아이디
        var userPassword = $('#pw');    // 사용자 비밀번호
        var userEmail = $('#em');       // 사용자 이메일
        var userPhoneNum = $('#pn');    // 사용자 핸드폰 번호
        var userPetId = $('#pi');       // 사용자 동물 고유번호


        if (!userid.val()){
            userid.focus();
            e.preventDefault();
            return;}
        else if (!userPassword.val()){
            userPassword.focus();
            e.preventDefault();
            return;}
        else if (!userEmail.val()){
            userEmail.focus();
            e.preventDefault();
            return;}
        else if (!userPhoneNum.val()){
            userPhoneNum.focus();
            e.preventDefault();
            return;}
        else if (!userPetId.val()){
            userPetId.focus();
            e.preventDefault();
            return;}
        else if (valid){
            alert("회원가입이 완료 되었습니다.")
           // $(this).submit();
            // $("#joinFrom").submit();
        }

    }
</script>
</html>
