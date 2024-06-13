<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

    <title>Title</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            /* 수평 중앙 정렬하기 */
            text-align: center;
        }
        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #45a049;
        }

        .pageInfo{
            list-style : none;
            display: inline-block;
            margin: 50px 0 0 100px;
        }
        .pageInfo li{
            float: left;
            font-size: 20px;
            margin-left: 18px;
            padding: 7px;
            font-weight: 500;
        }
        a:link {color:black; text-decoration: none;}
        a:visited {color:black; text-decoration: none;}
        a:hover {color:black; text-decoration: underline;}
        .active{
            background-color: #cdd5ec
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center; /* 가운데 정렬 */

        }
    </style>

<div class="container-stories">
    <div class="container">

            <h1 class="text-primary text-center" style="margin-top: 90px;">MEMBER SUBSCRIBER</h1>
            <table>
                <thead>
                    <tr>
                        <th>OWNER_ID</th>
                        <th>PHONENUMBER</th>
                        <th>EMAIL</th>
                        <th>REGDATE</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="list" items="${memberList}">
                    <tr>
                        <td>${list.owner_Id}</td>
                        <td>${list.phoneNumber}</td>
                        <td><a class="move" href="${list.owner_Id}">${list.email}</a></td>
                        <td><fmf:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/>  </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <form id="memberList" method="get">

            </form>

    </div>
</div>

<script>
    let listForm = $('#memberList');

   $('.move').on('click', function (e){
        e.preventDefault();

        listForm.find('#newinput').remove();
        listForm.append("<input type='hidden' id='owner_Id' name='owner_Id' value='" + $(this).attr("href") + "'>");
        listForm.attr('action', '/subscribers/look');
        listForm.submit();
   })
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
