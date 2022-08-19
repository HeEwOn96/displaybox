<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">

<!-- nav bar 파일-->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Nav bar</title>
<link rel="stylesheet" href="style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/b17d4fa9e7.js"
	crossorigin="anonymous"></script>
<script src="main.js" defer></script>
<!-- nav bar end -->

<!-- 제품 리스트 파일-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Aroma Shop - Home</title>
<link rel="icon" href="img/forusico.png" type="image/png">
<link rel="stylesheet" href="vendors/bootstrap/bootstrap.min2.css">
<link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="vendors/nice-select/nice-select.css">
<link rel="stylesheet"
	href="vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
<!-- 제품 리스트 끝 -->

<!-- 페이지 footer 파일 -->
<!-- Google Font -->
<link
	href='http://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<!-- Preloader -->
<link rel="stylesheet" href="css/preloader.css" type="text/css"
	media="screen, print" />
<!-- Icon Font-->
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/owl.theme.default.css">
<!-- Animate CSS-->
<link rel="stylesheet" href="css/animate.css">
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- Style -->
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="css/shopstyle.css">
<!-- Responsive CSS -->
<link href="css/responsive.css" rel="stylesheet">
<!-- 페이지 footer 끝-->
</head>

<body>
	<!---------------------------- nav bar 시작 ------------------>
	<%
	String result = (String) session.getAttribute("user_id");
	%>
	<nav class="navbar">
		<div class="navbar__logo" style="margin-right: -50px;">
			<a href="main.do?user_id=${result }"
				style="margin-right: 200px; font-weight: 600; font-size: 32px;">
				<img src="images/foruslogo3.png" width="60px" height="60px"
				style="margin-right: 5px;">EARTH BOX
			</a>
		</div>
		<ul class="navbar__menu">
			<strong><li>
			<% if (result == null) { %> 
			<a href="viewLogin.do">로그인</a> 
			<% } else { %>
			<a href="logoutService.do">로그아웃</a> 
			<% } %>
			</li></strong>
			<strong><li><a href="manual.do">이용방법</a></li></strong>
			<strong><li>
			<% if (result == null) { %> 
			<a href=viewLogin.do>주문내역</a> 
			<% } else { %>
			<a href=orderlist.do>주문내역</a> 
			<% } %>
			</li></strong>
		</ul>
		<a href="#" class="navbar__toogleBtn"> <i class="fas fa-bars"></i>
		</a>
	</nav>
	<!---------------------------- nav bar 끝 ------------------>


	<!-------------------- 주문 완료 -------------------------------->

	<div class="container h-100">
		<div class="text-center">
			<br>
			<br>
			<h1>구매가 정상적으로 완료되었습니다.</h1>
		</div>
	</div>

	<!-- 주문완료 -->
	<div class="orderInfo">


		<br /> <br /> <br />
		<p align="center">
			<strong>고객님의 결제가 완료 되었습니다.</strong><br> 제품 호출은 <a href=""
				style="color: #507050"><b>이용방법</b></a> 를 통하여 확인 가능합니다.
		</p>
		<br />
		<!----------------------------- 주문 목록 시작 --------------------------->
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"><img src="/img/product/${vo.g_img}"
									style="width: 500px; margin-right: 30px; margin-bottom: 50px;"></th>
							</tr>
							<tr>
								<th scope="col"><p
										style="font-size: 35px; font-height: 500px;">${vo.g_name }</p></th>
							</tr>
							<tr>
								<th scope="col"><p
										style="font-size: 30px; font-height: 500px;">￦<fmt:formatNumber value="${vo.g_price }" pattern="#,###"/></p></th>
							</tr>
							<tr>

							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<!---------------------------- 주문 목록 끝 --------------------->
	</div>
	<!-- 결제정보 -->
	<div class="orderArea" align="center">
		<div class="title">
			<h3>결제정보</h3>
			<br />
		</div>

		<div class="container h-100">
			<table class="table table-hover table-striped table-borderd"
				width='1000px'>

				<tr>
					<th scope="col">최종결제금액</th>
					<td scope="col">￦<fmt:formatNumber value="${vo.g_price }" pattern="#,###"/></td>
					<th scope="col"></th>
					<th scope="col"></th>
				</tr>
				<tr>
					<th scope="row">결제수단</th>
					<td scope="col">카카오 페이</td>
					<th scope="col"></th>
					<th scope="col"></th>
				</tr>
				<tr>
					<th scope="row">박스번호</th>
					<td scope="col">${vo.v_machine_space_no }</td>
					<th scope="col"></th>
					<th scope="col"></th>
				</tr>
				<tr>
					<th scope="row">박스비밀번호</th>
					<td scope="col">${vo.v_machine_pw}</td>
					<th scope="col"></th>
					<th scope="col"></th>
				</tr>

			</table>
		</div>
	</div>
	<br />
	<br />
	<p align="center">
		<a class="button primary-btn" href="keypad.do?g_seq=${vo.g_seq }">박스열기</a>
		<a
	</p>

	<!-------------------- 주문 완료 끝 -------------------------------->







	<footer>
		<div class="container">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="footer_logo   wow fadeInUp animated">
							<img src="images/foruslogo3.png" width="60px" height="60px"
								style="margin-right: 5px;">EARTH BOX
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center   wow fadeInUp animated">
						<div class="social">
							<h2>Follow Me on Here</h2>
							<ul class="icon_list">
								<li><a href="http://www.facebook.com/abdullah.noman99"
									target="_blank"><i class="fa fa-facebook"></i></a></li>
								<li><a href="http://www.twitter.com/absconderm"
									target="_blank"><i class="fa fa-twitter"></i></a></li>
								<li><a href=""><i class="fa fa-google-plus"></i></a></li>
								<li><a href=""><i class="fa fa-linkedin"></i></a></li>
								<li><a href="http://www.dribbble.com/abdullahnoman"
									target="_blank"><i class="fa fa-dribbble"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="copyright_text   wow fadeInUp animated">
							<p>
								문의 전화 <i class="fa fa-love"></i><a
									href="https://bootstrapthemes.co">010-1234-5678</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- ------------------------- footer 끝 ------------------>




	<!-- ========================= SCRIPTS  ============================== -->


	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.nicescroll.js"></script>
	<script src="js/owl.carousel.js"></script>
	<script src="js/wow.js"></script>
	<script src="js/script.js"></script>
	<script src="js/shopmain.js"></script>
	<script>
		function goodsStatusUpdate(g_seq) {

			$.ajax({
				url : "goodsStatusUpdate.do",
				type : "post",
				data : {
					"g_seq" : g_seq
				},
				success : function(data) {
					location.href = "/buycom.do?g_seq=${vo.g_seq }"
					console.log("성공")
				},
				error : function() {
					alert('error')
				}
			});
		}
	</script>
</body>
</html>