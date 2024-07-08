<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

    <style>
        /* 상세 항목 스타일 */
        .detail-item {
            margin-bottom: 15px;
        }

        .detail-label {
            font-weight: bold;
            color: #007bff;
        }

        /* 모든 항목을 감싸는 div에 대한 스타일 */
        .all {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;
        }

        .detail-item {
            margin-bottom: 10px;
        }

        .detail-label {
            font-weight: bold;
        }

        .edit-button {
            padding: 10px 20px;
            margin-left: 10px; /* 버튼 사이의 간격을 조절합니다. */
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            float: right;
        }

        .edit-button:hover {
            background-color: #45a049;
        }
    </style>
<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center" style="margin-top: 90px;">REVIEW  DETAIL</h1>
                <div class="detail-item all">
                        <div class="detail-item">
                        <span class="detail-label">마이크로칩 번호 : </span>
                        <span><c:out value="${read.pet_Id}"/></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">이름 : </span>
                        <span><c:out value="${read.pet_Name}"/></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">나이 : </span>
                        <span><c:out value="${read.pet_Age}"/>(<c:out value="${read.calculated_age}"/>살)</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">증상 : </span>
                        <span><c:out value="${read.symptoms}"/></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">진단 : </span>
                        <span><c:out value="${read.diagnosis}"/></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">치료 : </span>
                        <span><c:out value="${read.treatment}"/></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">처방 : </span>
                        <span><c:out value="${read.prescription}"/></span>
                    </div>
                </div>
                <a href="<c:out value="${read.record_Id}"/>"  class="edit-button" id="edit">수정</a>
                <a href="<c:out value="${read.pet_Id}"/>" class="edit-button" id="back" >이전</a>
                <form id="DynamicForm" action="/pet/prescription/edit" method="get">
                    <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
                    <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
                    <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
                    <input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
                </form>
        </div>
    </div>
</div>

<script>

    let pageMove = $('#DynamicForm');
    let url = '';
    $('#edit').on('click', function (e) {
        e.preventDefault();

        pageMove.find('#newinput').remove();

        pageMove.append("<input type='hidden' id='newinput' name='record_Id' value='" + $(this).attr("href") + "'>");
        pageMove.attr('action', '/pet/prescription/edit');
        pageMove.submit();
    });
    $('#back').on('click', function (e) {
        e.preventDefault();

        pageMove.find('#newinput').remove();

        pageMove.append("<input type='hidden' id='newinput' name='pet_Id' value='" + $(this).attr("href") + "'>");
        pageMove.attr('action', '/pet/prescription/details');
        pageMove.submit();
    });
</script>
</html>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
