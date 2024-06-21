<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<link rel="stylesheet" href="/resources/inquiry.css">
<style>
    .modal{
        position:absolute;
        display:none;

        justify-content: center;
        top:0;
        left:0;

        width:100%;
        height:100%;



        /*background-color: rgba(0,0,0,0.4);*/
    }

    .modal_body{
        position:absolute;
        top:80%;




        text-align: center;

        /*background-color: rgb(255,255,255);*/
        /*border-radius:10px;*/
        /*box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);*/

        transform:translateY(-50%);
    }
</style>


<div class="container-stories">
    <div class="container">
     <div class="basic animal">
        <h1 class="text-center">글 읽기</h1>
        <div class="panel-body">
            <div class="form-group">
                <label for="inquiry_Num">게시물 번호</label>
                <div class="btn-group">
                    <a href="/pet/inquiry/modify?inquiry_Num=${board.INQUIRY_NUM}" class="btn btn-warning">수정</a>
                    <a href="/pet/inquiry/list" class="btn btn-info">목록</a>
                </div>
                <input type="text" class="form-control" id="inquiry_Num" name="inquiry_Num" value="<c:out value='${board.INQUIRY_NUM}'/>" readonly>
            </div>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title" value="<c:out value='${board.TITLE}'/>" readonly>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea rows="3" class="form-control" id="content" name="content" readonly><c:out value='${board.CONTENT}'/></textarea>
            </div>
            <div class="form-group">
                <label for="writer">작성자</label>
                <input type="text" class="form-control" id="writer" name="writer" value="<c:out value='${board.HIDDENWRITER}'/>" readonly>
            </div>

            <div id="comment-list">
                <table>
                    <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody id="comment-tbody">
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.comment_Writer}</td>
                            <td>${comment.comment_Content}</td>
                            <td><fmt:formatDate value="${comment.comment_Create_Time}" pattern="yyyy-MM-dd"/></td>
                            <c:if test="${sessionScope.loginId.grade == 99}">
                            <td class="text-right">
                                <button class="btn btn-danger" onclick="deleteComment(${comment.id}, this)">삭제</button>
                                <button class="btn btn-dark" id="comment_Id" onclick="openEditModal(${comment.id}, this)">수정</button>
                            </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
            <c:if test="${sessionScope.loginId.grade == 99}">
            <div id="comment-form">
                <input type="hidden" id="comment_Writer" value="<c:out value='${sessionScope.loginId.owner_Id}'/>">
                <input type="text" id="comment_Content" placeholder="내용">
                <button id="comment-write-btn" class="btn btn-primary" onclick="commentWrite()">답변</button>
            </div>
            </c:if>
        </div>
    </div>
</div>
</div>
</div>
<div class="modal">
    <div class="modal_body">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCommentModalLabel">댓글 수정</h5>
            </div>
            <div class="modal-body">
                <form id="editCommentForm">
                    <div class="form-group">
                        <label for="editCommentContent">댓글 내용</label>
                        <textarea class="form-control" id="editCommentContent" rows="3"></textarea>
                    </div>
                    <input type="hidden" id="editCommentId">
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary">저장</button>
            </div>
        </div>
    </div>
</div>
<script>
    $('.btn-secondary').click(function () {
        $('.modal').css('display', 'none');
    });

    $('.btn-warning').on('click', function (){
        let writer = $('#writer').val();
        let owner = "${sessionScope.loginId.email}";
        console.log(owner);
        console.log(writer);
        if (writer != owner){
            alert("작성자가 아닙니다.")
            return false;
        }
    })
    function openEditModal(commentId, buttonElement) {
        // 현재 댓글 내용을 가져와서 모달에 채우기
        var row = $(buttonElement).closest('tr');
        var currentContent = row.find('td:nth-child(2)').text();

        $('#editCommentContent').val(currentContent);
        $('#editCommentId').val(commentId);

        // 모달 열기
        $('.modal').css('display','flex' );

        // 수정 버튼 클릭 이벤트 핸들러 등록
        $('.btn-primary').off('click').on('click', function (){
            /** $('.btn-primary2').off('click').on('click', function (){...});
            부분에서 off() 함수를 사용하여 이벤트 핸들러를 제거한 후 on() 함수로 새로운 이벤트 핸들러를 등록합니다.
            이렇게 하면 모달이 열릴 때마다 핸들러가 중복 등록되는 것을 방지할 수 있습니다. **/

            let newContent = $('#editCommentContent').val();
            let commentId =  $('#editCommentId').val();

            $.ajax({
                type : "post",
                url : "/inquiry/comment/update",
                data : {
                    comment_Content : newContent,
                    id : commentId
                },
                success : function (success) {
                    console.log(success);
                    row.find('td:nth-child(2)').text(newContent);
                    $('.modal').css('display','none');
                },
                error: function (request, status, error) {
                    console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        });
    }


    function deleteComment(commentId, remove) {
        if (confirm("댓글을 삭제하시겠습니까?")) {
            remove.closest('tr').remove();
            alert("삭제되었습니다.");

            $.ajax({
                type: "post",
                url: "/inquiry/comment/delete",
                data: { id: commentId },
                success: function (success) {
                    console.log(success);
                },
                error: function (request, status, error) {
                    console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }
    }

    function commentWrite() {
        const writer = $('#comment_Writer').val();
        const content = $('#comment_Content').val();
        const inquiry_num = '${board.INQUIRY_NUM}';

        $.ajax({
            type: "post",
            url: "/inquiry/comment/save",
            data: {
                comment_Writer: writer,
                comment_Content: content,
                inquiry_num: inquiry_num
            },
            dataType: "json",
            success: function (commentList) {
                console.log("작성성공");
                console.log(commentList);

                let output = '';
                for (let i in commentList) {
                    let formattedDate = moment(commentList[i].comment_Create_Time).format('YYYY-MM-DD');
                    let secondId = commentList[i].id;

                    output += "<tr data-id='" + secondId + "'>";
                    output += "<td>" + commentList[i].comment_Writer + "</td>";
                    output += "<td>" + commentList[i].comment_Content + "</td>";
                    output += "<td>" + formattedDate + "</td>";
                    output += "<td class='text-right'>";
                    output += "<button class='btn btn-danger' onclick='deleteComment(" + secondId + ", this)'>삭제</button>";
                    output += "<button class='btn btn-dark' onclick='openEditModal(" + secondId + ", this)'>수정</button>";
                    output += "</td>";
                    output += "</tr>";
                }
                $('#comment-tbody').html(output);

                $('#comment_Writer').val('');
                $('#comment_Content').val('');
            },
            error: function (request, status, error) {
                console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
