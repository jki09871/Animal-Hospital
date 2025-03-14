<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<link rel="stylesheet" href="/resources/inquiry.css">


<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-center" style="margin-top: 100px;">글 수정</h1>

            <div class="panel-body">
                <form role="form" id="modifyForm" action="/pet/inquiry/modify" method="post">
                    <input type="hidden" name="inquiry_Num" value="<c:out value="${board.INQUIRY_NUM}"/>">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" class="form-control" id="title" name="title" value="<c:out value='${board.TITLE}'/>">
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <textarea rows="3" class="form-control" id="content" name="content"><c:out value='${board.CONTENT}'/></textarea>
                    </div>
                    <div class="form-group">
                        <label for="writer">작성자</label>
                        <input type="text" class="form-control" id="writer" name="writer" value="<c:out value='${board.HIDDENWRITER}'/>" readonly>
                    </div>
                    <div class="btn-toolbar">
                        <button type="button" data-oper="modify" onclick="fnInquiry('M');" class="btn btn-success mr-2">등록</button>
                        <button type="button" data-oper="remove" onclick="fnInquiry('R');" class="btn btn-danger mr-2">삭제</button>
                        <button type="button" data-oper="list" onclick="fnInquiry('L');" class="btn btn-secondary">목록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>

    function fnInquiry(se) {
        let from = $('#modifyForm');
        let url = '';
        switch (se) {
            case 'M':
                url = "/pet/inquiry/modify";
                break;
            case 'R':
                if (confirm("삭제하시겠습니까?")){
                    alert("삭제되었습니다.")
                    url = "/pet/inquiry/remove";
                } else {
                    return false;
                }
                break;
            default:
                url = "/pet/inquiry/list";
        }
        from.attr('action', url);
        from.submit();
    }
</script>

<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
