<%@page import="org.springframework.ui.Model"%>
<%@page import="com.forus.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
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
	rel='stylesheet' type='text/
'>

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
<!-- icon fontawsome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>


<body>
	<!----------------------------- 로딩중 ------------------------>
	<div id="preloader">
		<div id="status">&nbsp;</div>
	</div>
	<!----------------------------- 로딩끝 ------------------------>


	<!---------------------------- nav bar 시작 ------------------>
	<%
	String result = (String) session.getAttribute("user_id");
	%>
	<nav class="navbar">
		<div class="navbar__logo" style="margin-right: -50px;">
			<a href="main.do?user_id=${result }"
				style="margin-right: 200px; font-weight: 600; font-size:32px;">
				 <img src="images/foruslogo3.png" width="60px" height="60px"
				style="margin-right: 5px;">EARTH BOX
			</a>
		</div>
		<ul class="navbar__menu">
			<%
			if (result == null) {
			%>
			<strong><li><a href="viewLogin.do">로그인</a></li></strong>
			<strong><li><a href="manual.do">이용방법</a></li></strong>
			<strong><li><a href="viewLogin.do">상품등록</a></li></strong>
			<strong><li><a href="viewLogin.do">상품회수</a></li></strong>
			<%
			} else {
			%>
			<strong><li><a href="logoutService.do">로그아웃</a></li></strong>
			<strong><li><a href="orderlist.do">주문내역</a></li></strong>
			<strong><li><a href="inputGoods.do">상품등록</a></li></strong>
			<strong><li><a href="getGoods.do">상품회수</a></li></strong>
			<%
			}
			%>

		</ul>
		<a href="#" class="navbar__toogleBtn"> <i class="fas fa-bars"></i>
		</a>
	</nav>
	<!---------------------------- nav bar 끝 ------------------>

	<!---------------------------- 제품 리스트 시작 ---------------->
	<section class="section-margin calc-60px">
		<div class="container">
			<div class="section-intro pb-60px">
				<h3 style="text-align:center">
					 <span class="section-intro__style" style="font-size: 40px; margin-bottom:70px;">한국 아델리움</span>
				</h3>
				<h4 style="font-size: 30px;color: #777;margin-top: 30px; text-align:center;">
					<span>'구매 중'인 제품은 구매할 수 없습니다.</span>
				</h4>
			</div>
			<div class="row">
				<!-- 제품리스트 출력 -->
				<!-- forEach문 사용 -->
				<c:forEach items="${list }" var="goodsVo">
					<div class="col-md-6 col-lg-4 col-xl-3">
						<div class="card text-center card-product">
							<p class="card-product__price" style="color: #599555; font-size:30px; margin-bottom: -30px;" >${goodsVo.g_status}
								중</p>
							<br>
							<div class="card-product__img">
								<!-- 상품 사진 출력 -->
								<img class="card-img" src=${goodsVo.g_img } alt="">
								<ul class="card-product__imgOverlay">
									<!-- 상세 페이지 보기 -->
									<%
									if (result == null) {
									%>
									<li><button type="button"
											onclick="location.href= 'viewLogin.do'">
											<i class="ti-search"></i>
										</button></li>
									<%
									} else {
									%>
									<li><button type="button"
											onclick="location.href= 'detail.do?g_seq=${goodsVo.g_seq}&user_id=${result }'">
											<i class="ti-search"></i>
										</button></li>
									<%
									}
									%>
									<!-- 장바구니 -->
									<%
									if (result == null) {
									%>
									<li><button type="button"
											onclick="location.href= 'viewLogin.do'">
											<i class="ti-search"></i>
										</button></li>
									<%
									} else {
									%>
									<li><button type="button"
											onclick="location.href= 'detail.do?g_seq=${goodsVo.g_seq}&user_id=${result }'">
											<i class="ti-search"></i>
										</button></li>
									<%
									}
									%>
									<!-- 관심 상품 -->
									<li><button>
											<i class="ti-heart"></i>
										</button></li>
								</ul>
							</div>
							<div class="card-body">
								<!-- 박스 번호 출력 -->
								<p style="color: #777; font-size:25px;">No.${goodsVo.v_machine_space_no}</p>
								<h4 class="card-product__title">
									<!-- 상품 	이름 출력 -->
									<a href="detail.do?g_seq=${goodsVo.g_seq}&user_id=${result }"><b style="font-size:30px;">${goodsVo.g_name}</b></a>
								</h4>
								<!-- 상품 가격 출력 -->
								<p class="card-product__price" style="font-size:25px;">￦<fmt:formatNumber value="${goodsVo.g_price }" pattern="#,###"/></p>
								
								
							</div>
						</div>
					</div>
				</c:forEach>
				<!-- 제품리스트 출력 끝 -->
			</div>
		</div>
		</div>
		</div>
		</div>
	</section>
	<!---------------------------- 제품 리스트 끝 ---------------->

	<div></div>

	<!-- ------------------------- footer 시작 ------------------>
	<footer>
		<div class="container">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="footer_logo   wow fadeInUp animated">
							<img src="images/foruslogo3.png" width="60px" height="60px"
								style="margin-right: 5px;"><p>EARTH BOX</p>
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
	<script src="js/shopmain.js"></script
</body>

</html>