<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 읽기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="/resources/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/inquiry.css">
</head>
<body>
<div class="container">
    <h1 class="text-center">글 읽기</h1>
    <div class="panel-body">
        <div class="form-group">
            <label for="inquiry_Num">게시물 번호</label>
            <div class="btn-group">
                <a href="/pet/inquiry/modify?inquiry_Num=${board.inquiry_Num}" class="btn btn-warning">수정</a>
                <a href="/pet/inquiry/list" class="btn btn-info">목록</a>
            </div>
            <input type="text" class="form-control" id="inquiry_Num" name="inquiry_Num" value="<c:out value='${board.inquiry_Num}'/>" readonly>
        </div>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="<c:out value='${board.title}'/>" readonly>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea rows="3" class="form-control" id="content" name="content" readonly><c:out value='${board.content}'/></textarea>
        </div>
        <div class="form-group">
            <label for="writer">작성자</label>
            <input type="text" class="form-control" id="writer" name="writer" value="<c:out value='${board.writer}'/>" readonly>
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
                        <td class="text-right">
                            <button class="btn btn-danger" onclick="deleteComment(${comment.id}, this)">삭제</button>
                            <button class="btn btn-dark" id="comment_Id" onclick="openEditModal(${comment.id}, this)">수정</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="modal fade" id="editCommentModal" tabindex="-1" role="dialog" aria-labelledby="editCommentModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editCommentModalLabel">댓글 수정</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
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
        </div>

        <div id="comment-form">
            <input type="hidden" id="comment_Writer" value="<c:out value='${sessionScope.loginId.owner_Id}'/>">
            <input type="text" id="comment_Content" placeholder="내용">
            <button id="comment-write-btn" class="btn btn-primary" onclick="commentWrite()">답변</button>
        </div>
    </div>
</div>

<script>
    function openEditModal(commentId, buttonElement) {
        // 현재 댓글 내용을 가져와서 모달에 채우기
        var row = $(buttonElement).closest('tr');
        var currentContent = row.find('td:nth-child(2)').text();

        $('#editCommentContent').val(currentContent);
        $('#editCommentId').val(commentId);

        // 모달 열기
        $('#editCommentModal').modal('show');

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
                    $('#editCommentModal').modal('hide');
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
        const inquiry_num = '${board.inquiry_Num}';

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
</body>
</html>
