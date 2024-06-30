<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<link rel="stylesheet" href="/resources/inquiry.css">

<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <div class="container">
                <h1 class="text-center">글쓰기</h1>
                <div class="panel-body">
                    <form role="form" class="inquiryForm" action="/pet/inquiry/register" method="post">
                        <div class="btn-group">
                            <p>비밀글 <input type="checkbox" class="memberCheck" name="opneOrPrivate"></p>
                        </div>
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" id="title" name="title">
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea class="form-control" id="content" rows="3" name="content"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="writer">작성자</label>
                            <input type="text" class="form-control" id="writer" name="writer" value="${sessionScope.loginId.owner_nm}" readonly>
                        </div>
                        <div class="btn-group">
                            <button type="button" class="btn btn-success submit">등록</button>
                            <button type="button" onclick="history.back()" class="btn btn-secondary">취소</button>
                        </div>
                        <div class="password-input" style="display: none;">
                            <p>암호 : <input type="text" name="password" class="password-field" placeholder="비밀번호를 입력해주세요"></p>
                        </div>
                        <input type="hidden" name="owner_Id" value="<c:out value="${sessionScope.loginId.owner_Id}"/>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        /*
        * 암호 필드의 값을 직접 검사하여 폼 제출 여부를 결정합니다.
        * change 이벤트를 사용하여 체크박스 상태가 변경될 때마다 암호 입력 필드를 표시하거나 숨깁니다.
        * */
        $('.memberCheck').on('change', function () {
            if ($(this).is(':checked')) {
                $('.password-input').css('display', 'flex'); /* 체크되면 암호창 보이기 */
            } else {
                $('.password-input').css('display', 'none'); /* 체크 해제 시 암호창 숨기기 */
            }
        });


        /*
        *  submit 버튼 클릭 시 체크박스가 체크된 경우 암호 필드가 비어있지 않은지 확인한 후 폼을 제출합니다.
        * .trim() 메서드를 사용하는 이유는 입력 값의 양쪽 끝에 있는 공백을 제거하기 위해서입니다.
        * 사용자가 실수로 암호 입력 필드에 공백을 추가했을 경우, 이 공백을 제거하여 실제 입력된 값만을 검사하기 위함입니다.
        */
        $('.submit').on('click', function () {
            let isMemberCheckChecked = $('.memberCheck').is(':checked');
            let passwordField = $('.password-field').val().trim();

            if (isMemberCheckChecked && (passwordField === '' || passwordField === null)) {
                alert("암호를 입력해주세요");
            } else {
                $('.inquiryForm').submit();
            }
        });
    });
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
