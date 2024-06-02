<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="/resources/petWrite.css">
<link rel="stylesheet" href="/resources/styles.css">
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<html>
<head>
    <title>Title</title>

</head>
<body>
<div class="container">
    <form name="petInfoModify" id="petInfoModify" action="/pet/info/modify" method="post">
        <input type="hidden" name="owner_Id" value="<c:out value="${pet.owner_Id}"/>">
        <div class="form-group">
            <label for="pet_name">강아지 이름</label>
            <input type="text" name="pet_name" id="pet_name" class="form-control" autocomplete="off" value="<c:out value="${pet.pet_name}"/>">
        </div>
        <div class="form-group">
            <label for="species">강아지 품종</label>
            <input type="text" name="species" id="species" class="form-control" autocomplete="off" value="<c:out value="${pet.species}"/>">
        </div>
        <div class="form-group">
            <label for="age">강아지 생년월일</label>
            <input type="text" name="age" id="age" class="form-control" autocomplete="off" value="<c:out value="${pet.age}"/>">
            <select id="yearSelect" class="form-control" style="width: 32%; display: inline-block;">
                <option value="">연도</option>
                <c:forEach var="year" begin="2000" end="2024">
                    <option value="${year}">${year}년</option>
                </c:forEach>
            </select>
            <select id="monthSelect" class="form-control" style="width: 32%; display: inline-block;">
                <option value="">월</option>
            </select>
            <select id="daySelect" class="form-control" style="width: 32%; display: inline-block;">
                <option value="">일</option>
            </select>
        </div>
        <div class="form-group">
            <label for="pet_Id">마이크로칩 번호</label>
            <input type="text" name="pet_Id" id="pet_Id" class="form-control" autocomplete="off" value="<c:out value="${pet.pet_Id}"/>">
        </div>
        <div class="form-group">
            <label for="significant">특이사항</label>
            <textarea name="significant" id="significant" class="form-control" autocomplete="off"><c:out value="${pet.significant}"/></textarea>
        </div>
        <div class="btn-group">
            <button type="button" class="btn" id="PetUpdate" onclick="fnMultiple('U');">수정</button>
            <button type="button" class="btn" id="PetDel" onclick="fnMultiple('D');">삭제</button>
            <button type="button" class="btn" onclick="fnMultiple('R');">이전</button>
        </div>
    </form>
</div>
</body>
<script>
    $(document).ready(function() {
        $('#age').on('mousedown', function(event) {
            event.preventDefault();
        });
        $('#pet_Id').on('mousedown', function(event) {
            event.preventDefault();
        });

        $('#daySelect').empty();
        for (var i = 1; i <= 31; i++) {
            var day = String(i).padStart(2, '0');
            $('#daySelect').append('<option value="' + day + '">' + day + '일</option>');
        }

        $('#monthSelect').empty();
        for (var i = 1; i <= 12; i++) {
            var month = String(i).padStart(2, '0');
            $('#monthSelect').append('<option value="' + month + '">' + month + '월</option>');
        }
    });

    let url = '';
    let form = $('#petInfoModify');
    function fnMultiple(es){
        switch (es) {
            case 'U':
                url = "/pet/info/modify";
                let year = $('#yearSelect').val();
                let month = $('#monthSelect').val();
                let day = $('#daySelect').val();

                if (year === "" || month === "" || day === "") {
                    $('#age').val($('#age').val());
                } else {
                    $('#age').val(year + "-" + month + "-" + day);
                }
                break;
            case 'D':
                url = "/pet/info/delete";
                if (confirm("정보를 삭제하시겠습니까?")) {
                    alert("삭제되었습니다.");
                } else {
                    alert("취소되었습니다.");
                    return;
                }
                break;
            default:
                history.back();
                return;
        }
        form.attr('action', url);
        form.submit();
    }
</script>
</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
