<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/jquery-3.7.1.js"></script>

<html>
<head>
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

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

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
        }

        .submit-button {
            width: 150px;
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
    </style>
</head>
<body>
<h2>Add Medical Record</h2>
    <form action="/pet/prescription/record" method="POST">

        <label for="doctor">수의자:</label><br>
        <input type="text" id="doctor" name="doctor" required autocomplete="off"><br><br>

        <label for="pet_Id">마이크로칩 번호:</label><br>
        <input type="text" id="pet_Id" name="pet_Id" required autocomplete="off"><br><br>

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
</body>

</html>
