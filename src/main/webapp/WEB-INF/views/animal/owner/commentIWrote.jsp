<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>

<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        #header {
            width: 100%;
            background-color: #f8f9fa;
            padding: 10px 0;
            text-align: center;
        }
        #header .menu {
            margin-top: 10px;
        }
        #header .menu button {
            margin: 0 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        #header .menu button a {
            color: #fff;
            text-decoration: none;
        }
        .basic.animal {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .table-cell {
            width: 80%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .table-cell th, .table-cell td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .pageInfo {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }
        .pageInfo_btn {
            margin: 0 5px;
        }
        .pageInfo_btn a {
            text-decoration: none;
            color: #333;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .pageInfo_btn a:hover {
            background-color: #f0f0f0;
        }
        .active a {
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
        }
    </style>
<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center" style="margin-top: 90px;">COMMENT I WROTE</h1>
            <table class="table-cell">
                <thead>
                <tr>
                    <th>댓글 등록된 게시글</th>
                    <th>내용</th>
                    <th>작성일</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach var="comment" items="${list}">
                    <tr>
                        <td><a href="/pet/inquiry/get?inquiry_Num=${comment.inquiryNum}"><c:out value="${comment.title}"/></a></td>
                        <td><c:out value="${comment.commentContent}"></c:out></td>
                        <td><fmt:formatDate value="${comment.commentCreateTime}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
