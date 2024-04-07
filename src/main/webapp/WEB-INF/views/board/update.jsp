<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>
<!-- 스마트 에디터 스크립트 추가 -->
<script type="text/javascript" src="/resources/smarteditor2-2.8.2.3/js/HuskyEZCreator.js" charset="UTF-8"></script>

<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="updateForm" action="/board/update" method="post">
    <table>
        <tr>
            <th>title</th>
            <td><input type="text" name="title" value="<c:out value="${board.title}"/>"></td>
        </tr>
        <tr>
            <th>content</th>
            <td style="width: 600px;">
                <!-- 에디터를 표시할 textarea -->
                <textarea rows="10" cols="30" name="content" id="editor"><c:out value="${board.content}"/></textarea>
            </td>
            <td><input type="submit" value="수정"></td>
        </tr>
    </table>
    <input type="hidden" name="bno" id="bno" value="<c:out value="${board.bno}"/>">
</form>
</body>

<script>
    // 스마트 에디터 생성
    let oEditors = [];
    smartEditor = function() {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editor",
            sSkinURI : "/resources/smarteditor2-2.8.2.3/SmartEditor2Skin.html",
            fCreator: "createSEditor2"
        });
    }

    $(document).ready(function() {
        // 폼이 로드될 때 스마트 에디터 생성
        smartEditor();
    });

    // 수정 폼 전송 전에 스마트 에디터의 내용을 업데이트
    $('#updateForm').submit(function() {
        oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);

    });
</script>
</html>
