<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="/resources/jquery-3.7.1.js"></script>
<head>
    <title>Title</title>
</head>
<body>
<form action="/member/joinmembership" method="post" name="form" id="form">
    <table>
        <tr>
            <th>이름</th>
            <td>
                <input type="text" name="memberName" autocomplete="true">
            </td>
        </tr>

        <tr>
            <th>비밀번호</th>
            <td>
                <input type="text" name="memberPassword" autocomplete="true">
            </td>
        </tr>

        <tr>
            <th>나이</th>
            <td>
                <input type="text" name="memberAge" autocomplete="true">
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <input type="text" name="memberEmail" id="memberEmail" value="" autocomplete="true">
                <input type="button" name="memberCheckButton" id="memberCheckButton"value="이메일 확인">
                <div id="result" ></div>
            </td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>
                <input type="text" name="memberMobile" autocomplete="true">
            </td>
        </tr>
        <colgroup>
            <col style="width:20%"><col>
        </colgroup>
        <tbody>
        <tr>
            <th>우편번호</th>
            <td>
                <input type="hidden" id="confmKey" name="confmKey" value=""  >
                <input type="text" id="zipNo" name="zipNo" readonly style="width:100px">
                <input type="button"  value="주소검색" onclick="goPopup()">
            </td>
        </tr>
        <tr>
            <th>도로명주소</th>
            <td><input type="text" id="roadAddrPart1" style="width:85%" readonly></td>
        </tr>
        <tr>
            <th>상세주소</th>
            <td>
                <input type="text" id="addrDetail" style="width:40%" value="">
                <input type="text" id="roadAddrPart2"  readonly style="width:40%" value="">
            </td>
        </tr>
        </tbody>
    </table>
    <button type="button" onclick="fnSave();" >회원가입</button>
    <button> <a href="/">돌아가기</a> </button>
</form>
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer"
         style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

</body>

<script language="JavaScript">
    function validateEmail(email) {
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return emailRegex.test(email);
    }

    $("#memberCheckButton").on('click', function (){
            var email = $("#memberEmail").val();
            var isValid = validateEmail(email);

            if (!isValid) {
                $('#result').data('value', "1");
                $('#result').text("이메일 형식이 올바르지 않습니다.");
                return false;
            }

        $.ajax({
            url: "/member/email",
            type: "GET",
            data: {email: email},
            dataType : "json",
            success: function (EmailCheck) {
                console.log(EmailCheck)

                if (EmailCheck == false) {
                    let EmailCheck1 = $('#result').data('value', "1");
                    $('#result').text("다른 이메일을 입력해주세요.");
                    console.log(EmailCheck1);
                    return;
                } else {
                    $('#result').data('value', 0);
                    $('#result').text("사용 가능한 이메일 입니다.");

                }

            },
            error: function (error) {
                console.log(error);
            }
        });
    });
        // function validateEmail(email) {
        //     var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        //     return emailRegex.test(email);
        // }
        //
        // // 이메일 입력란 변화 감지하여 유효성 검사
        // $('#memberEmail').on('input', function() {
        //     var email = $(this).val();
        //     var isValid = validateEmail(email);
        //
        //     if (!isValid) {
        //         $('#emailValidation').data('value', "1");
        //         $('#emailValidation').text("이메일 형식이 올바르지 않습니다.");
        //         return false;
        //     }
        //
        //     $.ajax({
        //         url: "/member/email.do",
        //         type: "GET",
        //         data: {email: email},
        //         success: function (data) {
        //             console.log(data)
        //
        //
        //             if (data == false) {
        //                 $('#emailValidation').data('value', "1");
        //                 console.log($('#emailValidation').data('value'));
        //                 $('#emailValidation').text("이미 사용중인 이메일 입니다");
        //                 return ;
        //             } else {
        //                 $('#emailValidation').data('value', 0);
        //                 console.log($('#emailValidation').data('value'));
        //                 $('#emailValidation').text("이메일 사용가능");
        //
        //             }
        //
        //         }
        //     });
        //
        // });
        //
        // 회원가입 버튼 클릭 시
        function fnSave(e) {
            var valid = true;
            var memberName = $("input[name='memberName']");              // 이름 필드 체크
            var memberPassword = $("input[name='memberPassword']");      // 비밀번호 필드 체크
            var memberAge = $("input[name='memberAge']");                // 나이 필드 체크
            let EmailCheck = $('#emailValidation').data('value');        // 이메일 필드 체크
            var memberMobile = $("input[name='memberMobile']").val();    // 전화번도 필드 체크
            var zipNo = $("input[name='zipNo']").val();                  // 주소 필드 체크

            if (!memberName.val()) {
                alert('이름을 입력하세요.');
                memberName.focus();
                e.preventDefault();
                return;
            } else if (!memberPassword.val()) {
                alert('비밀번호를 입력하세요.');
                memberPassword.focus();
                e.preventDefault();
                return;
            } else if (!memberAge.val()) {
                alert('나이를 입력하세요.');
                memberAge.focus();
                e.preventDefault();
                return;
            } else if (EmailCheck == 1 || EmailCheck == undefined) {
                alert("이메일 확인 해주세요")
                $('#memberEmail').focus();
                return false;
            } else if (!memberMobile) {
                alert('전화번호를 입력하세요.');
                e.preventDefault(); // 서브밋 막기
                return;
            } else if (!zipNo) {
                alert('주소를 입력해주세요.');
                e.preventDefault(); // 서브밋 막기
                return;
            } else

                // 유효성 통과 시 서브밋
            if (valid) {
                alert("회원가입이 완료되었습니다.");
                //$('#form').submit();
            }
        }

    //document.domain = "abc.go.kr";
    function goPopup() {
        // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        var pop = window.open("/member/jusoPopup", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");

        // 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
        //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes");
    }

    /** API 서비스 제공항목 확대 (2017.02) **/
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
        , detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
        // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
        document.form.roadAddrPart1.value = roadAddrPart1;
        document.form.roadAddrPart2.value = roadAddrPart2;
        document.form.addrDetail.value = addrDetail;
        document.form.zipNo.value = zipNo;
    }

</script>
</html>
