<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<style>
    .findId-container {
        max-width: 400px;
        margin: auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .findId-container h1 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #333;
    }

    .findId-container input[type="text"],
    .findId-container input[type="password"] {
        width: calc(100% - 22px); /* Adjusting width to account for padding and border */
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .findId-container input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 10px;
    }

    .findId-container input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .findId-container label {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
    }

    .findId-container input[type="checkbox"] {
        margin-right: 5px;
    }

    .findId-container .links {
        margin-top: 20px;
    }

    .findId-container .links a {
        color: #007bff;
        text-decoration: none;
    }

    .findId-container .links a:hover {
        text-decoration: underline;
    }
    .btn-outline-primary {
        background-color:#44c767;
        border-radius:28px;
        border:1px solid #18ab29;
        display:inline-block;
        cursor:pointer;
        color:#ffffff;
        font-family:Arial;
        font-size:17px;
        padding:16px 31px;
        text-decoration:none;
        text-shadow:0px 1px 0px #2f6627;
    }

    .btn-outline-primary:hover {
        background-color:#5cbf2a;
    }
    .btn-outline-primary:active {
        position:relative;
        top:1px;
    }


</style>

<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <div class="container-about">
                <div class="findId-container">
                    <h2>비밀번호 변경</h2>
                    <form id="pwChangeForm" action="/animal/pwChange" method="post">
                        <div class="form-group">
                            <label for="password">현제 비밀번호</label>
                            <input type="password" id="password" name="password" placeholder="현재 비밀번호" autocomplete="off"  required >
                        </div>
                        <div class="form-group">
                            <label for="pwChange">변경할 비밀번호</label>
                            <input type="text" id="pwChange" name="pwChange" placeholder="변경할 비밀번호" autocomplete="off" required  >
                            <div id="pwCheckResult"></div>
                        </div>
                        <div class="form-group">
                            <label for="pwChange">비밀번호 확인</label>
                            <input type="text" id="pwChange2" name="pwChange2" placeholder="변경할 비밀번호" autocomplete="off"  required >
                            <div id="pwCheckResult2"></div>
                        </div>
                        <button type="button" onclick="fnSubmit()" class="btn btn-outline-primary">비밀번호 변경</button>
                        <input type="hidden" name="owner_Id" value="<c:out value="${sessionScope.loginId.owner_Id}"/>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>

<script>
    let form = $('#pwChangeForm');
    let pwResult = false;
    $(document).ready(function () {
        <c:if test="${not empty error}">
            alert("${error}");
        </c:if>
    });



    function isPassword(asValue) {
        var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
        return regExp.test(asValue);
    }


    $('#pwChange').on('keyup', function () {
        let pwChange = $('#pwChange').val();

        var passwordValid = isPassword(pwChange);
        if (passwordValid) {
            pwResult = true
            $('#pwCheckResult').text("");
        } else {
            pwResult = false;
            $('#pwCheckResult').text("8 ~ 16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
            return;
        }
    });
    $('#pwChange2').on('keyup', function () {
        let pwChange = $('#pwChange').val();
        let pwCheck = $('#pwChange2').val();
        if (pwChange == pwCheck) {
            pwResult = true;
            $('#pwCheckResult2').text("");
        } else {
            pwResult = false;
            $('#pwCheckResult2').text("비밀번호를 확인 해주세요");
        }
    });

    function fnSubmit() {
        let password = $('#password').val();
        let pwChange = $('#pwChange').val();

            if (password == pwChange){
                alert("같은 비밀번호로 변경 할 수 없습니다.");
                pwResult = false;
            }else if (pwResult) {
                form.submit();
            } else {
                alert("비밀번호를 확인 해주세요");
            }
        };

</script>