<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

    <style>
        .form-group {
            text-align: center;
        }
        table {
            width: 50%;
            border-collapse: collapse;
            margin:auto;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-container {
            text-align: center;
        }
        button {
            margin: 0 5px;
            padding: 8px 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>

<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center" style="margin-top: 90px;">REVIEW  DETAIL</h1>
                <table>
                    <tr>
                        <th>Review Number</th>
                        <td>${animal.reviewNum}</td>
                    </tr>
                    <tr>
                        <th>Writer</th>
                        <td>${animal.writer}</td>
                    </tr>
                    <tr>
                        <th>Title</th>
                        <td>${animal.title}</td>
                    </tr>
                    <tr>
                        <th>Content</th>
                        <td>${animal.content}</td>
                    </tr>
                    <tr>
                        <th>Time</th>
                        <td><fmt:formatDate value="${animal.regdate}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </table>
                <form method="get" action="/animal/correction/" id="readForm">
                    <input type="hidden" name="reviewNum" value="<c:out value='${animal.reviewNum}'/>">
                    <input type="hidden" name="pageNum" value="<c:out value='${criteria.pageNum}'/>">
                    <input type="hidden" name="amount" value="<c:out value='${criteria.amount}'/>">
                    <input type="hidden" id="FILE_NO" name="FILE_NO" value="">
                </form>
                <div class="form-group">
                    <c:forEach var="file" items="${file}">
                        <a href="#" class="file-link" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
                    </c:forEach>
                </div>
                <div class="btn-container">
                    <button onclick="fnDynamic('L')">목록</button>
                    <c:if test="${sessionScope.loginId != null }">
                        <button onclick="fnDynamic('U')">수정</button>
                        <button onclick="fnDynamic('D')">삭제</button>
                    </c:if>
                    <button onclick="history.back()">이전</button>
                </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>

<script>
    let form = $('#readForm');
    let url = '';
    function fnDynamic(se){
        switch (se){
            case 'L' :
                url = '/animal/reviewList';
                break;
            case 'U' :
                if (${sessionScope.loginId.owner_Id == animal.writer}) {
                    url = '/animal/correction';
                    break;
                }else {
                    alert("작성자가 아닙니다.");
                    return ;
                }
            default :
                if (${sessionScope.loginId.owner_Id == animal.writer}) {
                    const isConfirmed = confirm("게시물을 삭제하시겠습니까?");
                    if (isConfirmed) {
                        alert("삭제되었습니다.");
                    } else {
                        alert("삭제가 취소되었습니다.");
                        return false;
                    }
                    url = '/animal/deletePost';
                    break;
                } else {
                    alert("작성자가 아닙니다.");
                }
        }
        form.attr('action', url);
        form.submit();
    }

    function fn_fileDown(fileNo){
        var formObj = $("#readForm");
        $("#FILE_NO").attr("value", fileNo);
        formObj.attr("action", "/animal/fileDown");
        formObj.submit();
    }
</script>
