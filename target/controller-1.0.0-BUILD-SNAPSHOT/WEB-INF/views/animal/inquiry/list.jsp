<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<link rel="stylesheet" href="/resources/inquiry.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    .btn {
        margin-left: 5px;
    }

    .locked:before {
        content: "\f023"; /* Font Awesome 자물쇠 아이콘 코드 */
        font-family: "Font Awesome 5 Free"; /* Font Awesome 폰트 패밀리 */
        font-weight: 900; /* Font Awesome 폰트 굵기 */
        margin-right: 8px; /* 아이콘과 텍스트 사이 간격 */
    }
</style>

    <div class="container" >
        <div class="basic animal">
            <h1 class="text-center">문의 게시판</h1>
            <div class="mb-3 text-right">
                <button id="regBtn" onclick="multiple_btn('R');" class="btn btn-success">글쓰기</button>
                <button id="homBtn" onclick="multiple_btn('H');" class="btn btn-success">홈</button>
            </div>
            <div class="basic board">
                <table class="table table-striped table-bordered" id="dataTable">
                    <thead class="thead-dark">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="board" items="${list}">
                        <tr>
                            <td><c:out value="${board.INQUIRY_NUM}"/></td>
                            <td class="${board.PASSWORD_CH}" id="${board.OWNER_ID}">
                                <a id="${board.INQUIRY_NUM}" class="privateInquiry <c:if test="${board.PASSWORD_CH eq 'Y'}">locked</c:if>"
                                   href="/pet/inquiry/get?inquiry_Num=${board.INQUIRY_NUM}">
                                    <c:out value="${board.TITLE}"/>
                                    <c:if test="${board.CNT > 0}">(<c:out value="답변완료" />)</c:if>
                                </a>
                                <div style="display: none">
                                    <input type="text" class="text-input" name="password" placeholder="비밀번호 입력해주세여">
                                    <input type="button" class="btn password_relay" value="확인">
                                    <input type="button" class="btn password_cansel" value="취소">
                                </div>
                            </td>
                            <td><c:out value="${board.HIDDENWRITER}"/></td>
                            <td><fmt:formatDate value="${board.REGDATE}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


<script>
    $(document).ready(function () {
        $('.privateInquiry').on('click', function (event) {
            let owner_id = $(this).parent().attr('id');
            let session_id = "${sessionScope.loginId.owner_Id}";
            if (owner_id != session_id || owner_id == '' || session_id == '') {
                let privateInquiry_ch = $(this).parent('td').attr('class'); // 클릭한 요소중 가장 가까운 부모태그(td)의 class 값을 가져옴
                if (privateInquiry_ch === 'Y') {
                    $(this).siblings('div').css('display', 'flex');
                    return false;
                }
                return true;
            }
        });

        $('.password_relay').on('click', function () {
            var pw = $(this).siblings('input[type=text]').val(); // 클릭한 요소에 형제 중에 type=text인 것에 value 값을 가져옴
            let inquiry_num = $(this).parent().siblings('a').attr('id'); // 클릭한 요소에 부모에 형제중 a태그의 id 값을 가져옴


            if (pw != '' && pw != null) {
                $.ajax({
                    url: '/inquiry/password/send',
                    type: 'GET',
                    data: {pw: pw, inquiry_num: inquiry_num},
                    success: function (data) {
                        console.log(data);
                        if (data === '성공') {
                            self.location = "/pet/inquiry/get?inquiry_Num=" + inquiry_num;
                        } else {
                            alert(data);
                        }
                    }
                });
            } else {
                alert("비밀번호를 입력해주세요");
            }
        });

        $('.password_cansel').on('click', function () {
            $(this).parent('div').css('display', 'none');
        });
    });

    function multiple_btn(es) {
        switch (es) {
            case 'R':
                self.location = "/pet/inquiry/register";
                break;
            default:
                self.location = "/";
        }
    };
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
