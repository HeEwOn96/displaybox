<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<style>
body{
background-color : white;
}

div{
background-color : white;
}

.pwWrap {
  width: 100%;
  max-width: 1000px;
  max-heigth: 1000px;
  background: #fff;
  margin: 100px auto;
}

.pwWrap .pwSection {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 400px;
}

.pwWrap .pwSection .dot {
  display: block;
  width: 50px;
  height: 50px;
  background-image: linear-gradient(to top, #e6e9f0 0%, #eef1f5 100%);
  border-radius: 100%;
  margin: 0 5px;
}

.pwWrap .pwSection .dot.active {
  background: lightblue;
}

.pwWrap .pwSection .message {
  position: absolute;
  bottom: 50px;
  left: 0;
  z-index: 1;
  min-width: 100%;
  text-align: center;
  font-size: 30px;
  font-weight: bold;
  letter-spacing: -0.03em;
  opacity: 0;
  transition: .2s ease-out;
}

.pwWrap .numberSection {
  overflow: hidden;
}

.pwWrap .numberSection .number {
  float: left;
  font-size: 150px;
  font-weight: 600;
  width: 33.33%;
  border: 5px solid #fff;
  border-radius: 50px;
  padding: 12px 0;
  cursor: pointer;
  background-image: linear-gradient(to right, #43e97b 0%, #38f9d7 100%);
  color: white;
}

.pwWrap .numberSection .number:last-child {
  margin-left: 33.33%;
}

.pwWrap.error .message {
  opacity: 1;
  color: red;
}

.pwWrap.confirm .message {
  opacity: 1;
  color: green;
}
</style>
</head>

<body>
	<div class="pwWrap">
    <div class="numberSection">
        <button class="number" onclick="location.href='BoxLed1.do?btn=1';">1off</button>
        <button class="number" onclick="location.href='BoxLed1.do?btn=2';">1on</button>
        <button class="number" onclick="location.href='BoxLed2.do?btn=3';">2off</button>
        <button class="number" onclick="location.href='BoxLed2.do?btn=4';">2on</button>
        <button class="number" onclick="location.href='BoxLed3.do?btn=5';">3off</button>
        <button class="number" onclick="location.href='BoxLed3.do?btn=6';">3on</button>
        <button class="number" onclick="location.href='BoxLed4.do?btn=7';">4off</button>
        <button class="number" onclick="location.href='BoxLed4.do?btn=8';">4on</button>
    </div>
</div>

<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/music.js"></script>
</body>
</html>