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
            <div class="findId-container">
                <h2>비밀번호 찾기</h2>
                <form id="findIdForm">
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" placeholder="가입한 이메일을 입력해주세요" required>
                    </div>
                    <div class="form-group">
                        <label for="owner_Id">아이디</label>
                        <input type="tel" id="owner_Id" name="owner_Id" placeholder="아이디를 입력 해주세요" required>
                    </div>
                    <button type="button" class="btn-outline-primary" onclick="findId()">아이디 찾기</button>
                </form>
                <div id="result" style="margin-top: 20px;"></div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>

<script>
    function findId(){
        let form = $('#findIdForm');
        let email = $('#email').val();
        let owner_Id = $('#owner_Id').val();

            $.ajax({
                type: 'POST',
                url: '/animal/findPw',
                data: {email: email, owner_Id: owner_Id},
                success: function (hidePw) {
                    console.log(hidePw);
                    if (hidePw == '') {
                        alert("이메일 또는 아이디를 확인 해주세요");
                    } else {
                        alert("임시 비밀번호가 전송 되었습니다." + email +"를 확인해주세요");
                        form.attr('action', '/animal/login');
                        form.attr('method', 'get');
                        form.submit();

                    }
                }, error: function (request, status, error) {

                    console.log("code:" + request.status + "\n"
                        + "message:" + request.responseText + "\n" + "error:" + error);

                }
            });
    }
</script>