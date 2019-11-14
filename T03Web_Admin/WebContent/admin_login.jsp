<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Insert title here</title>
    <style>
        .bg {
            width: 1024px;
            align-self: center;
            /* text-align: center; */
            vertical-align: center;
            position: relative;
            margin: 0px auto;
        }
        .bg2 {
            top: 20px;
            height: 160px;
            text-align: center;
            vertical-align: center;
            margin: 5px 0px 5px 0px;
            
            position: relative;
            background: #50a3a2;
			background: -webkit-linear-gradient(top left, #50a3a2 0%, #53e3a6 85%);
			background: -moz-linear-gradient(top left, #50a3a2 0%, #53e3a6 85%);
			background: -o-linear-gradient(top left, #50a3a2 0%, #53e3a6 85%);
			background: linear-gradient(to bottom right, #50a3a2 0%, #53e3a6 85%);
        }
        .sub1 {
            width: 400px;
            margin: 20px;
        }
        .sub2 {
            width: 400px;
            height: 200px;
            margin: 20px;
            color: aliceblue;
            text-align: center;
            vertical-align: center;
            background-color: rgb(60, 170, 170);
            border-radius: 5px
        }
        .rightForm{
            width: 310px;
            height: 100px;
            text-align: right;
            line-height: 35px;

        }

        input {
            border: 0;
            background-color: #fff;
            color: rgb(60, 170, 170);
            border-radius: 5px;
            cursor: pointer;
        }

        input:hover {
            color: #fff;
            background-color: rgb(60, 170, 170 ,0.8);
            border: 2px #fff;
        }
        a {
            color: #fff;
            cursor: pointer;
        }
        a:hover{
            color: rgb(60, 170, 170);
            background-color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>

<body>
<center>
    <div class="bg">
        <div class="sub1">
            <a><img src="images/login.png" width="400" alt="LoginPicture" /></a>
        </div>
        <div class="sub2">
            <div class="bg2">
                <form action="Login" class="rightForm" method="post">
                    
                    Name: <input type="text" name="UserName" class="cent" required><br>
                    Password:<input type="password" name="pwd" class="cent" required><br>
                    <a href="signup.jsp">Sign up</a>
                    <input type="submit" value="Login">
                    
                </form>
            </div>
        </div>
    </div>
</center>
</body>

</html>