<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<style>

    .pet-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .pet-table th, .pet-table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }
    .pet-table th {
        background-color: #f4f4f4;
        width: 200px;
        font-weight: bold;
    }
    .pet-table td {
        background-color: #fcfcfc;
    }
    .input-text, .textarea {
        width: calc(100% - 22px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .select-box {
        width: 100px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .btn-group {
        margin-top: 20px;
    }
    .btn-custom {
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 10px;
    }
    .btn-custom:last-child {
        margin-right: 0;
    }
    .btn-custom:hover {
        background-color: #45a049;
    }
</style>
<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center" style="margin-top: 90px;">PET INFO WRITE</h1>
            <form name="petForm" id="petForm" action="/pet/info/write" method="post" class="pet-form" >
                <input type="hidden" name="owner_Id" value="<c:out value="${sessionScope.loginId.owner_Id}"/>">
                <table class="pet-table">
                    <tr>
                        <th>강아지 이름</th>
                        <td><input type="text" name="pet_name" id="pet_name" autocomplete="off" class="input-text"></td>
                    </tr>
                    <tr>
                        <th>강아지 품종</th>
                        <td><input type="text" name="species" id="species" autocomplete="off" class="input-text"></td>
                    </tr>
                    <tr>
                        <th>강아지 생년월일</th>
                        <td>
                            <input type="hidden" name="age" id="age" autocomplete="off" class="read-only">
                            <select id="yearSelect" class="select-box">
                                <option value="">연도</option>
                                <c:forEach var="year" begin="2000" end="2024">
                                    <option value="${year}">${year}년</option>
                                </c:forEach>
                            </select>

                            <select id="monthSelect" class="select-box">
                                <option value="">월</option>
                            </select>

                            <select id="daySelect" class="select-box">
                                <option value="">일</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>마이크로칩 번호</th>
                        <td><input type="text" name="pet_Id" id="petid" autocomplete="off" class="input-text"></td>
                    </tr>
                    <tr>
                        <th>특이사항</th>
                        <td><textarea name="significant" id="significant" autocomplete="off" class="textarea"></textarea></td>
                    </tr>
                </table>
                <div class="btn-group">
                    <button type="button" id="btnPetInfo" name="btn" class="btn-custom">작성</button>
                    <button type="button" onClick="history.back();" class="btn-custom">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        // 일 선택 옵션 생성
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

        $('#btnPetInfo').on('click', function () {
            let year = $('#yearSelect').val();
            let month = $('#monthSelect').val();
            let day = $('#daySelect').val();

            $('#age').val(year + "-" + month + "-" + day);
            $('#petForm').submit();
        });
    });
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
