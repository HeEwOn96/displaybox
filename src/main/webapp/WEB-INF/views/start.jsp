<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
/* NOTE: I only tested this on Google Chrome.*/

body{
  background: #fff;
}

.container{
  width: 100%;
  margin-left: auto;
  margin-right: auto;
  text-align: center;
}

.container h1:nth-child(1) {
  color: #355c7d;
  font-family: "Work Sans", sans-serif;
  font-weight: 800;
  font-size: 50px;
  margin: 0 0 0 19%;
  text-align: left;
  white-space: nowrap;
  overflow: hidden;
  width: 100%;
  animation: type 1s steps(40,end) forwards;
  margin-block-start: 0.01em;
  line-height : 95%;
}

.container h1:nth-child(2) {
  opacity: 0;
  font-family: "Work Sans", sans-serif;
  margin: 0 auto auto auto;
  background-image: linear-gradient(to top, #37ecba 0%, #72afd3 100%);
  font-weight: 800;
  font-size: 150px;  
  width: 100%;
  white-space: nowrap;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  overflow: hidden;
  line-height : 95%;
  animation: shring-animation 1.2s steps(40,end) 1s forwards, blink .5s step-end infinite alternate;
}




@keyframes shring-animation {
  0% {
    background-position: 0 0;
    opacity: 0;
    width: 0;
  }
  1% {
    background-position: 0 0;
    opacity: 1;
    border-right: 1px solid orange;
  }
  50% {
    background-position: 150px 0;
    opacity: 1;
    border-right: 1px solid orange;
  }
  100% {
    background-position: 400px 0;
    opacity: 1;
    border-right: 1px solid orange;
  }
}

@keyframes type {
  0% {
    width: 0;
  }
  1%, 99%{
    border-right: 1px solid orange;
  }
  100%{
    border-right: none;
  }
}

@keyframes blink {
  50% {
    border-color: transparent;
  }
}

.spacebr{
	margin-bottom : 100px;
	margin-right: 500px;
	}

.spacebr2{
	margin-top : 400px;
	margin-right : 1000px;
	}
@import url("https://fonts.googleapis.com/css?family=Rubik:700&display=swap");
* {
  box-sizing: border-box;
}
*::before, *::after {
  box-sizing: border-box;
}

.col1{
  background-color: #599555;
  color: white;
  font-weight: 600;
  font-size: 120px;
  text-align: right;
  margin-left: 100px;
  width: 100%;
  line-height : 95%;
}

</style>
<body>
<div class = "spacebr container">
<img src="images/foruslogo.png" alt="" style="width:550px; margin-right:80px; margin-bottom:-100px;">
</div>
<div class = "container">
  <h1>자원도 절약하고 환경도 지키는</h1>
  <h1>EARTH BOX</h1>
  <div class = "spacebr2 container">
</div>
<div class = "container">
  <h1><a class="col1" href="main.do">사용시작</a></h1>
  </div>
</div>

</body>
</html>