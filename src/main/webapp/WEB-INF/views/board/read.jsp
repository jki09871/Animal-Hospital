<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="../../../resources/jquery-3.7.1.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>

      <table>
          <tr>
              <th>bno</th>
              <td>${board.bno}</td>
              <th>hits</th>
              <td>${board.hits}</td>
          </tr>
          <tr>
              <th>writer</th>
              <td>${board.writer}</td>
          </tr>
          <tr>
              <th>title</th>
              <td>${board.title}</td>
          </tr>
          <tr>
              <th>content</th>
              <td>${board.content}</td>
          </tr>
          <tr>
              <th>time</th>
              <td>
                  <fmf:formatDate value="${board.time}" pattern="yyyy-MM-dd"/>
              </td>
          </tr>
      </table>
      <button onclick="fnDynamic('L')">목록</button>
      <button onclick="fnDynamic('U')">수정</button>
      <button onclick="fnDynamic('D')">삭제</button>
      <form method="get" action="/board/read" id="readForm">
          <input type="hidden" name="bno" value="<c:out value="${board.bno}"/>">
      </form>

</body>
    <script>
        let form = $('#readForm');
        let url = '';
        function fnDynamic(se){
            switch (se){
                case 'L' :
                    url = '/board/list';
                    break;
                case 'U' :
                    url = '/board/update';
                    break;
                default :
                    url = '/board/delete';
                    break;
            }
            form.attr('action', url);
            form.submit();
        }
    </script>
</html>
