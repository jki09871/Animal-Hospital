<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> <%--데이피커 필요 --%>

<style>
    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        text-align: center;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
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
</style>

<div class="container-stories">
    <div class="container">
        <div class="basic animal">
            <h1 class="text-primary text-center">등록된 동물</h1>
            <div class="btn-container">
            <button class="btn">목록</button>
               <a> <input type="text" id="datepicker1" placeholder="시작 날짜" autocomplete="off" value="${Time.startTime}" }> ~
                   <input type="text" id="datepicker2" placeholder="끝 날짜" autocomplete="off" value="${Time.endTime}">
               </a>
                <button type="button" id="timeBtn">검색</button>
            </div>
            <table>

            <tr>
                <th>동물 이름</th>
                <th>방문 날짜</th>
                <th>증상</th>
                <th>수의사</th>
            </tr>

            <c:forEach var="readList" items="${read}">
                <tr class="pet_info">
                    <td>${readList.PET_NAME}(${readList.CALCULATED_AGE}살)</td>
                    <td><a class="move" href="${readList.RECORD_ID}">${readList.DATE_OF_VISIT}</a></td>
                    <td>${readList.SYMPTOMS}</td>
                    <td>${readList.DOCTOR}</td>
                </tr>
                <input type="hidden" id="pet_id" value="<c:out value="${readList.PET_ID}"/>">
            </c:forEach>
            </table>


            <form method="get" action="/pet/prescription/list" id="readForm">
                <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
                <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
                <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
                <input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
                <input type="hidden" name="startTime" value="<c:out value="${cri.startTime}"/>">
                <input type="hidden" name="endTime" value="<c:out value="${cri.endTime}"/>">
                <input type="hidden" name="pet_Id" value="">
            </form>
        </div>
    </div>
</div>


<script>
    let readForm = $('#readForm');

    $(document).ready(function (){
        let pet_Id = "${cookie.pet_Id.value}";
        console.log(pet_Id);
    })

    $('.btn').click(function (){
        readForm.submit();
    })

    $('.move').on('click', function (e) {
        e.preventDefault();

        readForm.find('#newinput').remove();

        readForm.append("<input type='hidden' id='newinput' name='record_Id' value='" + $(this).attr("href") + "'>");
        readForm.attr('action', '/pet/prescription/details/unravel');
        readForm.submit();
    });
    $(function() {
        let currentDate = new Date();

        $("#datepicker1").datepicker({
            maxDate: currentDate, // 오늘 날짜까지만 선택 가능
            onSelect: function(selectedDate) {
                let minDate = $("#datepicker1").datepicker("getDate");
                $("#datepicker2").datepicker("option", "minDate", minDate); // 시작 날짜 이후로 종료 날짜 설정
            }
        });

        $("#datepicker2").datepicker({
            maxDate: currentDate // 오늘 날짜까지만 선택 가능
        });
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd',	//날짜 포맷이다. 보통 yy-mm-dd 를 많이 사용하는것 같다.
            prevText: '이전 달',	// 마우스 오버시 이전달 텍스트
            nextText: '다음 달',	// 마우스 오버시 다음달 텍스트
            closeText: '닫기', // 닫기 버튼 텍스트 변경
            currentText: '오늘', // 오늘 텍스트 변경
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더중 월 표시를 위한 부분
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더 중 월 표시를 위한 부분
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],	//한글 캘린더 요일 표시 부분
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],	//한글 요일 표시 부분
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],	// 한글 요일 표시 부분
            showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
            yearSuffix: '년',	//
            showButtonPanel: true,	// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
//        buttonImageOnly: true,	// input 옆에 조그만한 아이콘으로 캘린더 선택가능하게 하기
//        buttonImage: "images/calendar.gif",	// 조그만한 아이콘 이미지
//        buttonText: "Select date"	// 조그만한 아이콘 툴팁
        });

    });

    $('#timeBtn').on('click', function (){
        let startTime = $('#datepicker1').val();
        let endTime = $('#datepicker2').val();
        let pet_Id = "${cookie.pet_Id.value}";

        if (startTime == ''){
            alert("시작 시간을 선택해주세요");
            return false;
        } else if (endTime == ''){
            alert("마지막 시간을 선택해주세요");
            return false;
        }

        readForm.attr("action", "/pet/prescription/details");
        readForm.find("input[name='startTime']").val(startTime);
        readForm.find("input[name='endTime']").val(endTime);
        readForm.find("input[name='pet_Id']").val(pet_Id);
        readForm.submit();
    });


</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
