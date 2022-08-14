<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<style>
body {
	background-color: white;
}

div {
	background-color: white;
}

.pwWrap {
	width: 100%;
	max-width: 700px;
	max-heigth: 700px;
	background: #fff;
	margin: 100px auto;
}

.pwWrap .pwSection {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	height: 10px;
	margin-bottom: 100px;
}

.pwWrap .pwSection .dot {
	display: block;
	width: 40px;
	height: 40px;
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
	font-size: 25px;
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
	font-size: 80px;
	font-weight: 400;
	width: 33.33%;
	border: 5px solid #fff;
	border-radius: 100px;
	padding: 40px 0;
	cursor: pointer;
	background-color: #e9ecef;
	color: #495057;
}

.back {
	float: left;
	font-size: 40px;
	font-weight: 600;
	width: 300px;
	height: 100px;
	border: 5px solid #fff;
	border-radius: 50px;
	background-color: #599555;
	color: #f9f9ee;
}

.check {
	float: right;
	font-size: 40px;
	font-weight: 600;
	width: 300px;
	height: 100px;
	border: 5px solid #fff;
	border-radius: 50px;
	background-color: #599555;
	color: #f9f9ee;
}

.pwWrap .numberSection .number:last-child {
	
}

.pwWrap.error .message {
	opacity: 1;
	color: red;
}

.pwWrap.confirm .message {
	opacity: 1;
	color: green;
}

.block {
	float: left;
	font-size: 120px;
	font-weight: 600;
	width: 33.33%;
	border: 5px solid #fff;
	border-radius: 50px;
	padding: 12px 0;
	cursor: pointer;
	background-color: #fff;
	color: #fff;
}

.number1 {
	float: left;
	font-size: 80px;
	font-weight: 400;
	width: 33.33%;
	border: 5px solid #fff;
	border-radius: 100px;
	padding: 27px 0;
	cursor: pointer;
	background-color: #599555;
	color: #495057;
}
</style>
</head>

<body>
	<div class="pwWrap">
		<div class="pwSection">
			<span class="dot"></span> <span class="dot"></span> <span class="dot"></span>
			<span class="dot"></span>
			<p class="message">&nbsp;</p>
		</div>
		<div class="numberSection">
			<button class="number">1</button>
			<button class="number">2</button>
			<button class="number">3</button>
			<button class="number">4</button>
			<button class="number">5</button>
			<button class="number">6</button>
			<button class="number">7</button>
			<button class="number">8</button>
			<button class="number">9</button>
			<button class="number1">
				<img src="images/undo.png" style="width: 33.33%;"onclick="location.href='main.do'">
			</button>
			<button class="number">0</button>
			<button class="number1">
				<img src="images/tap.png" style="width: 33.33%;">
			</button>
		</div>

		<!--  
	<div class="buttonsection">
		<button class="back" type="button" onclick="location.href='main.do'"></button>
		<button class="check" type="button" onclick="location.href='orderlist.do'">입력하기</button>
	</div>
	-->

		<script>
			var link = "main.do?user_id=${result }";
			
			
		
		
			function PwCheck(pw) {
				const _this = this;
				_this.pwStr = pw.toString(); // 문자, 숫자열을 모두 허용하기 위해 무조건 한가지 타입으로 맞춤
				_this.password = []; // 지정된 패스워드
				_this.passwordNumber = []; // 입력할 패스워드
				_this.cnt = 0; // 입력횟수 체크
				_this.compChk = false; // 입력완료 체크 
				_this.msg = [ '입력하신 박스가 없습니다.비밀번호를 확인해주세요', 'Success! 😍' ];

				_this.parent = document.querySelector('.pwWrap');
				_this.dots = document.querySelectorAll('.dot');
				_this.numbers = document.querySelectorAll('.number');
				_this.message = document.querySelector('.message');

				// 비밀번호를 배열에 넣음 
				_this.getPw = function() {
					for (let i = 0; i < _this.pwStr.length; i++) {
						_this.password[i] = _this.pwStr[i];
					}
				}

				// 숫자버튼 click이벤트 연동
				_this.handleListener = function() {
					if (!_this.compChk) {
						_this.numbers.forEach(function(number) {
							number.addEventListener('click', function() {
								_this.handleNumber(number)
							});
						})
					}
				}

				// 숫자키를 눌렀을때 이벤트 
				_this.handleNumber = function(number) {
					if (!_this.compChk) {
						_this.passwordNumber[_this.cnt] = number.textContent;
						_this.handleDotActive(true);
						_this.cnt++;
						if (_this.cnt === 4) {
							_this.handleResult();
						}
					}
				}

				// dot 활성화 
				_this.handleDotActive = function(type) {
					if (type) {
						_this.dots.forEach(function(dot, i) {
							if (i === _this.cnt)
								dot.classList.add('active');
						})
					} else {
						_this.dots.forEach(function(dot) {
							dot.classList.remove('active');
						})
					}
				}

				// 비밀번호 비교
				_this.handleCheckPw = function() {
					let compare = JSON.stringify(_this.password) === JSON
							.stringify(_this.passwordNumber);
					return compare;
				}

				// 결과처리 
				_this.handleResult = function() {
					if (_this.handleCheckPw()) {
						_this.parent.classList.add('confirm');
						_this.message.textContent = _this.msg[1];
						_this.compChk = true;
						alert("성공");
						location.href=link;
					} else {
						_this.parent.classList.add('error');
						_this.message.textContent = _this.msg[0];
						// 입력상태 초기화 
						_this.passwordNumber = [];
						_this.cnt = 0;
						_this.compChk = true; // 일시적인 클릭 방지 
						setTimeout(function() {
							_this.compChk = false;
							_this.parent.classList.remove('error');
							_this.handleDotActive();
						}, 2000);
					}
				}

				_this.init = function() {
					_this.handleListener();
					_this.getPw();
				}()
			}

			var mypw = ${vo.v_machine_pw};
			console.log('${vo.v_machine_pw}')
			let pwCheck = new PwCheck(mypw);
		</script>
</body>
</html>