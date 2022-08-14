<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Animated Login Form</title>
	<link rel="stylesheet" type="text/css" href="css/loginstyle.css">
	<link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/a81368914c.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="img/forusico.png" type="image/png">
</head>
<body>
	<img class="wave" src="img/wave.png">
	<div class="container">
		<div class="img">
			<img src="img/bg.svg">
		</div>
				<img src="images/foruslogo.png" style="margin-left: 50px; margin-top:100px; margin-bottom: -100px; width:600px;">
		<div class="login-content" style="margin-left:200px;">
			<form action="login.do" method='post'>
				<h2 class="title" >EARTH BOX</h2>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>아이디</h5>
           		   		<input type="text" name = "user_id" class="input">
           		   </div>
           		</div>
           		<div class="input-div pass">
           		   <div class="i"> 
           		    	<i class="fas fa-lock"></i>
           		   </div>
           		   <div class="div">
           		    	<h5>비밀번호</h5>
           		    	<input type="password" name = "user_pw" class="input">
            	   </div>
            	</div>
            	<input type="submit" class="btn" value="로그인">
            </form>
        </div>
    </div>
    <script type="text/javascript" src="js/main.js"></script>
</body>
</html>
