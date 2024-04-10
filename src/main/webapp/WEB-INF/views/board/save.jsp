<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <script type="text/javascript" src="/resources/smarteditor2-2.8.2.3/js/HuskyEZCreator.js" charset="UTF-8"></script>
    <title>Title</title>
</head>
<body>
<form id="myForm" action="/board/save" method="post">
    <div class="mb-4">
        <input type="text" name="writer" placeholder="writer">
    </div>
    <input type="text" name="title" placeholder="title">
    <div class="post-form">
        <textarea rows="20" name="content" id="editor"></textarea>
    </div>
    <input type="submit" value="작성" onclick="updateContent()">
</form>
</body>
<script>
    let oEditors = [];

    smartEditor = function() {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editor", // 수정된 부분
            sSkinURI : "/resources/smarteditor2-2.8.2.3/SmartEditor2Skin.html",
            fCreator: "createSEditor2"
        });
    }

    $(document).ready(function() {
        // 스마트에디터 적용
        smartEditor();
    });

    // 값 업데이트 함수
    function updateContent() {
        oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);

    }

</script>
</html>
