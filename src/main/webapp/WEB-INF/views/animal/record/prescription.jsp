<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/cmmn/header.jsp"%>


<!--한국어  달력 쓰려면 추가 로드-->
<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> <%--데이피커 필요 --%>
<title>Title</title>
    <style>
        /* 폼을 가운데로 정렬하고, 스타일링 */
        form {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        /*label {*/
        /*    display: block;*/
        /*    margin-bottom: 8px;*/
        /*    font-weight: bold;*/
        /*}*/

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        textarea {
            height: 100px;
            max-height: 150px;
            max-width: 645px;
        }
        .SearchBtn {
            height: 45px;
            width: 80px;
            border-radius: 5px;
            text-align: center;

        }

        .SearchBtn {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
        }

        .submit-button {
            width: 100px;
            padding: 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            float: right;
        }

        .submit-button:hover {
            background-color: #45a049;
        }

        input[readonly] {
            background-color: #f0f0f0; /* 진한 회색으로 설정 */
        }


        /** 팝업 css **/

    </style>
<div class="container-stories">
    <div class="container">
        <div class="basic animal">
        <h2>Add Medical Record</h2>
            <form action="/pet/prescription/record" method="POST">

                <label for="doctor">수의자:</label><br>
                <input type="text" id="doctor" name="doctor" required autocomplete="off" value="<c:out value="${sessionScope.loginId.owner_Id}"/>" readonly ><br><br>

                <label for="date_Of_Visit">진료 날짜:</label><br>
                <input type="text" id="date_Of_Visit" name="date_Of_Visit" required autocomplete="off" placeholder="클릭 후 날짜를 선택 해주세요" readonly><br><br>

                <label for="pet_Id">마이크로칩 번호:</label><br>
                <input type="text" id="pet_Id" name="pet_Id" required autocomplete="off" style="width: 550px" readonly>
                <input type="button" value="번호 찾기" onclick="openChild()" class="SearchBtn"><br><br>


                <label for="pet_Name">이름:</label><br>
                <input type="text" id="pet_Name" name="pet_Name" required autocomplete="off"><br><br>

                <label for="pet_Age">나이:</label><br>
                <input type="date" id="pet_Age" name="pet_Age" required autocomplete="off"><br><br>


                <label for="symptoms">증상:</label><br>
                <textarea id="symptoms" name="symptoms" rows="4" cols="50" required autocomplete="off"></textarea><br><br>


                <label for="diagnosis">진단:</label><br>
                <textarea id="diagnosis" name="diagnosis" rows="4" cols="50" required autocomplete="off"></textarea><br><br>


                <label for="treatment">치료:</label><br>
                <textarea id="treatment" name="treatment" rows="4" cols="50" required autocomplete="off"></textarea><br><br>


                <label for="prescription">처방:</label><br>
                <textarea id="prescription" name="prescription" rows="4" cols="50" required autocomplete="off"></textarea><br><br>


                <button type="submit" class="submit-button">작성</button>
            </form>
        </div>
    </div>
</div>

<script>



    function openChild() {

        // window.open("open할 window", "자식창 이름", "팝업창 옵션");
         window.open("/registered/petNumberSearch", "childForm", "width=780, height=800, resizable = no, scrollbars = no");
    }


    $(function() {
        let currentDate = new Date();

        $("#date_Of_Visit").datepicker({
        });
    });
    $(function() {
        let currentDate = new Date();
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
        maxDate: currentDate
//        buttonImageOnly: true,	// input 옆에 조그만한 아이콘으로 캘린더 선택가능하게 하기
//        buttonImage: "images/calendar.gif",	// 조그만한 아이콘 이미지
//        buttonText: "Select date"	// 조그만한 아이콘 툴팁
    });
    });
</script>
<%@include file="/WEB-INF/views/cmmn/footer.jsp"%>
