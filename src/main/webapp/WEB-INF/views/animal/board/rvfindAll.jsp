<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
    <style>
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
            background-color: #cdd5ec;
        }
    </style>
    <title>AnimalReviewList</title>
</head>
    <h1>AnimalReviewList</h1>
    <div>

        <c:if test="${sessionScope.loginId != null}">
        <button id="regBtn" style="color: green;">글쓰기</button>
        <button type="button"><a href="/animal/logout">로그아웃</a></button>

        </c:if>
        <c:if test="${sessionScope.loginId == null}">
        <button type="button"><a href="/animal/login">로그인</a></button>
        </c:if>
    </div>
    <div class="basic animal">
        <table class="table-cell" id="dataTable" >
            <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>수정일</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="animal" items="${list}">
                <tr>
                    <td><c:out value="${animal.reviewNum}"></c:out></td>
                    <td><a class="move" href="${animal.reviewNum}"><c:out value="${animal.title}"></c:out></a> </td>
                    <td><c:out value="${animal.writer}"></c:out></td>
                    <td><fmt:formatDate value="${animal.regdate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${animal.updatetdate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="pageInfo_wrap">
            <div class="pageInfo_area">
                <ul class="pageInfo" id="pageInfo">
                    <%-- 이전 버튼 구현--%>
                    <c:if test="${pageMaker.prev}">
                        <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">prev</a></li>
                    </c:if>

                    <%-- 각 번호 페이지 버튼 --%>
                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <li class="pageInfo_btn ${pageMaker.pagingCriteria.pageNum == num ? "active":""}"><a href="${num}">${num}</a> </li>
                    </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1}">next</a></li>
                        </c:if>
                </ul>
            </div>
        </div>
        <form id="pageMove" method="get">
            <input type="hidden" name="pageNum" value="<c:out value="${pageMaker.pagingCriteria.pageNum}"/>">
            <input type="hidden" name="amount" value="<c:out value="${pageMaker.pagingCriteria.amount}"/>">
        </form>
    </div>
</body>
    <script>
        $(document).ready(function () {
            console.log("목록 페이지")
            $('#regBtn').on('click', function (e){
                self.location = "/animal/review";
            });

        });

        $('.move').on('click', function (e) {
            e.preventDefault();

            pageMove.find('#newinput').remove();

            pageMove.append("<input type='hidden' id='newinput' name='reviewNum' value='" + $(this).attr("href") + "'>");
            pageMove.attr('action', '/animal/viewDetails');
            pageMove.submit();
        })

        let pageMove = $('#pageMove');
        $(".pageInfo a").on("click", function(e){

            e.preventDefault();
            pageMove.find("input[name='pageNum']").val($(this).attr("href"));
            pageMove.attr("action", "/animal/reviewList");
            pageMove.submit();

        });
    </script>
</html>
