<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<!-- 스마트 에디터 스크립트 추가 -->

<html>
<head>
    <script type="text/javascript" src="/resources/summernote" charset="UTF-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
    <title>Title</title>
</head>
<body>
<form id="updateForm" action="/board/update" method="post" enctype="multipart/form-data">
    <input type="hidden" name="writer" id="writer" value="<c:out value="${board.writer}"/>">
    <table>
        <tr>
            <th>title</th>
            <td><input type="text" name="title" value="<c:out value="${board.title}"/>"></td>
        </tr>
        <tr>
            <th>content</th>
            <td style="width: 600px;">
                <!-- 에디터를 표시할 textarea -->
                <textarea id="summernote" rows="5" name="content" style="width:100%; height:250px;">${board.content}</textarea>
            </td>
            <td><input type="submit" value="수정"></td>
        </tr>
        <tr>
            <td id="fileIndex">
                <c:forEach var="file" items="${file}" varStatus="var">
                <div>
                    <a href="#" id="fileName" class="${file.FILE_NO}" >${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
                    <button type="button" class="fileRemove" onclick="fnDel('${file.BNO}','${file.FILE_NO}')" id="fileDel">Remove</button>
                </div>
                </c:forEach>
        </tr>
    </table>
    <input type="hidden" name="bno" id="bno" value="<c:out value="${board.bno}"/>">
    <button type="button" id="fileAdd_btn" class="btn btn-primary">파일추가</button>
</form>
</body>
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>

<script>
    $('#summernote').summernote({
        height: 300,
        width: 1000,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: "ko-KR",
        callbacks: {
            onImageUpload : function(files) {
                for (var i = files.length - 1; i >= 0; i--) {
                    sendFile(files[i], this);
                }
            }
        }
    });

    function sendFile(file, editor){
        let formData = new FormData();
        formData.append("file", file);
        console.log(file);
        $.ajax({
            data : formData,
            type : "POST",
            url : "/ajaxUpload",
            contentType : false,
            processData : false,

            success : function (data){
                console.log(data);
                $(editor).summernote("insertImage", data.url);
            }
        });
    }

    var fileIndex = 1;
    $('#fileAdd_btn').on('click', function () {
        $("#fileIndex").append("<div><input type='file' style='float:left;' name='file_" + fileIndex++ + "'>"
            + "<button type='button' class='fileRemove' onclick='fnDel(this)' id='fileDel'>삭제</button></div>");

    });

    function fnDel(bno, fileNo) {
        console.log(bno);
        console.log(fileNo);

        if (confirm("파일을 삭제하시겠습니까?")) {
            alert("삭제되었습니다.");

            // 현재 클릭된 버튼의 부모 요소를 찾아 삭제
            $('#fileDel').closest('div').remove();



            $.ajax({
                url: '/board/fileRemove',
                method: 'POST',
                data: {fileNo: fileNo, bno : bno}, // 키 이름을 fileNo로 수정a
                success: function () {
                    console.log("bno: " + bno);
                    console.log("fileNo: " + fileNo);
                    console.log("파일 삭제 성공");
                },
                error: function (request, status, error) {
                    console.error("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        } else {
            return;
        }
    }

</script>
</html>
