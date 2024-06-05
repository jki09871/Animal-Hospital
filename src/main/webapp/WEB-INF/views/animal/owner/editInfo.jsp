<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<style>
    .disabled {
        pointer-events: none;
    }
    .edit-form {
        width: 100%;
        max-width: 600px;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 0 auto;
    }
    .custom-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .custom-table th, .custom-table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }
    .custom-table th {
        background-color: #f4f4f4;
        width: 150px;
        font-weight: bold;
    }
    .custom-table td {
        background-color: #fcfcfc;
    }
    .custom-table input[type="text"] {
        width: calc(100% - 22px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .btn-custom {
        width: 48%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 10px;
    }
    .btn-edit-info {
        background-color: #4CAF50;
    }
    .btn-edit-info:hover {
        background-color: #45a049;
    }
    .btn-go-back {
        background-color: #f44336;
    }
    .btn-go-back:hover {
        background-color: #e53935;
    }
    .email-check-result, .phone-number-check-result {
        margin-top: 5px;
        font-size: 0.9em;
        color: #777;
    }
    #emailCheck {
        margin-top: 10px;
        background-color: #008CBA;
    }
    #emailCheck:hover {
        background-color: #007B9E;
    }
</style>




<div class="container-stories">
    <div class="container">
        <form method="post" action="/animal/editInfo" id="editForm" class="edit-form"  style="margin-top: 50px;">
            <table class="custom-table">
                <tr>
                    <th>아이디</th>
                    <td>
                        <input type="text" name="owner_Id" id="ownerId" value="${animal.owner_Id}" disabled><br>변경불가
                    </td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>
                        <form id="emailResetForm">
                        <input type="text" id="em" name="email" placeholder="이메일" class="input-email" value="${animal.email}" onclick="Email();" autocomplete="off" disabled>
                            <div id="emailCheckResult" class="email-check-result"></div>
                            <button type="button" id="emailModify">이메일 변경</button>
                                <div class="changingEmailBtn" style="display: none;">
                                    <button type="button"  id="emailReset" >변경취소</button>
                                    <button type="button" id="emailCheck" name="emailCheck" onclick="fn_emailCheck()">이메일 확인</button>
                                </div>
                        </form>
                    </td>
                </tr>
                <tr>
                    <th>핸드폰 번호</th>
                    <td>
                        <input type="text" name="phoneNumber" id="pn" placeholder="'-' 빼고 입력해주세요" value="${animal.phoneNumber}" class="phone-number" disabled>
                        <div id="phoneNumberCheckResult" class="phone-number-check-result"></div>
                        <button type="button" id="phoneNumberModify" >전화번호 변경</button>
                        <button type="button"  id="phoneReset" style="display: none;" >변경취소</button>
                    </td>
                </tr>
            </table>
            <button type="button" onclick="editInfo();" class="btn-custom btn-edit-info">정보수정</button>
            <button type="button" onClick="history.back();" class="btn-custom btn-go-back">이전</button>
        </form>
    </div>
</div>

<script>
    let form = $('#editForm');


    $(document).ready(function(){
        $('#emailCheckResult').data('EmailResult', 1);
        $('#emailCheckResult').data('result', 1);

        $('#emailModify').on('click', function (){
            $('#em').prop('disabled', false);
            if($('.changingEmailBtn').css("display") == "none"){
                $('.changingEmailBtn').show();

            }
        });

        $('#phoneNumberModify').on('click', function (){
            $('#pn').prop('disabled', false);
            if($('#phoneReset').css("display") == "none"){
                $('#phoneReset').show();

            }
        })
        $('#emailReset').on('click', function(){
            const isConfirmed = confirm("이메일 변경을 취소 하시겠습니까?");
            // 사용자가 확인을 선택했을 경우 true
            if (isConfirmed) {
                alert("취소되었습니다.")
                $('#em').val("${animal.email}");
                $('#em').prop('disabled', true);
                $('#emailCheckResult').data("result", 1);
                $('#emailCheckResult').text("")
                $('.changingEmailBtn').toggle();
            } else {
                return false;
            }
        });
        $('#phoneReset').on('click', function(){
            const isConfirmed = confirm("전화번호 변경을 취소 하시겠습니까?");
            // 사용자가 확인을 선택했을 경우 true
            if (isConfirmed) {
                alert("취소되었습니다.")
                $('#pn').val("${animal.phoneNumber}");
                $('#pn').prop('disabled', true);
                $('#emailCheckResult').data("result", 1);
                $('#phoneNumberCheckResult').text("")
                $('#phoneReset').toggle();
            } else {
                return false;
            }
        })
    });

    /*************************************** 이메일 정규식 검사 *********************************************/
    function validateEmail(emailCheck) {
        var emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com|outlook\.com|naver\.com|hanmail\.net|daum\.net|hotmail\.com|icloud\.com|aol\.com|protonmail\.com)$/;
        return emailRegex.test(emailCheck);
    }

    function Email(){
        $('#em').on('keyup', function () {


            /** 타자치면서 검사 **/
            var emailCheck = $('#em').val();
            var emailValid = validateEmail(emailCheck);
            if (emailValid) {
                $('#emailCheckResult').data("result", 1);
                $('#emailCheckResult').text("이메일 확인버튼을 눌러주세요.")
                return true;
            } else {
                $('#emailCheckResult').data("result", 0);
                $('#emailCheckResult').text("올바르지 않는 이메일 입니다.");
                return false;
            }
        });
        }

    function fn_emailCheck(){
        var email = $('#em').val();

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
        }else {
            alert("이메일을 체크 해주세요");
        }
    }
    /*************************************** 이메일 정규식 끝 ***********************************************/


    /************************************** 전화번호 정규식 끝 ********************************************/

    function isPhoneNumber(phone) {
        var regExp = /^(01[016789])\d{3,4}\d{4}$/;
        return regExp.test(phone);
    }

    $('#pn').on('keyup', function () {
        var phone = $('#pn').val();
        var phoneCheck = isPhoneNumber(phone);

        if (phoneCheck) {
            $('#phoneNumberCheckResult').html("");
            $('#emailCheckResult').data('result', 1);
        } else {
            $('#phoneNumberCheckResult').html("전화번호를 확인 해주세요");
            $('#emailCheckResult').data('result', 0);
            return;
        }
    });

    function editInfo(e) {
        // 사용자에게 확인 대화 상자 표시

        if ($('#emailCheckResult').data('EmailResult') === 1 && $('#emailCheckResult').data('result') === 1){
            const isConfirmed = confirm("정보를 수정 하시겠습니까?");
                // 사용자가 확인을 선택했을 경우 true
                if (isConfirmed) {

                    // 확인을 선택한 경우
                    alert("수정 되었습니다.");
                    form.submit();

                } else {
                    //  사용자가 취소를 선택했을 경우 false
                    alert("수정 취소되었습니다.");
                    e.preventDefault();
                    return;
                }
            } else {
                alert("이메일 또는 번호를 확인 해주세요");
            }
    }
</script>
</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
