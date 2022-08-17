<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<%
	String result = (String) session.getAttribute("user_id");
	%>

	<!---------------------------- nav bar 시작 ------------------>
	<nav class="navbar">
		<div class="navbar__logo" style="margin-right : -50px;">
			<a href="main.do?user_id=${result }"
			 style="margin-right: 200px; font-weight:600; font-size:32px;">
			<img src="images/foruslogo3.png" width="60px" height="60px" style="margin-right: 5px;">EARTH BOX</a>
		</div>
		<ul class="navbar__menu">
			<strong><li>
					<%
					if (result == null) {
					%> <a href="viewLogin.do">로그인</a> <%
 } else {
 %>
					<a href="logoutService.do">로그아웃</a> <%
 }
 %>
			</li></strong>
			<strong><li><a href="manual.do">이용방법</a></li></strong>
			<strong><li><a href=orderlist.do>주문내역</a></li></strong>
		</ul>
		<a href="#" class="navbar__toogleBtn"> <i class="fas fa-bars"></i>
		</a>
	</nav>
	<!---------------------------- nav bar 끝 ------------------>

	<!---------------------------- 배너 시작 --------------------->
	<div class="container h-100">
		<div class="text-center">
			<h1>상품 회수</h1>
		</div>
	</div>
	</div>
	<!---------------------------- 배너 끝 --------------------->

	<!---------------------------- 장바구니 시작 --------------------->
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"><b>제품</b></th>
								<th scope="col"><b>비밀번호</b></th>
								<th scope="col"><b>가격</b></th>
								<th scope="col"><b>구매날짜</b></th>
								<th scope="col"><b>삭제</b></th>

							</tr>
						</thead>
						<tbody>

							<c:forEach items="${vo }" var="vo">
								<form action="deleteGoods.do">
									<tr>
										<input type="hidden" name="g_seq" id="g_seq" +${i}
											value="${vo.g_seq }">
										<td>
													<img src=${vo.g_img } width="250px" height="250px">
													<p>${vo.g_name}</p>
										</td>
										<td>
											<h5>${vo.v_machine_pw}</h5>
										</td>
										<td>
											<h5><fmt:formatNumber value="${vo.g_price }" pattern="#,###"/>원</h5>
										</td>
										<td>
											<h5>${vo.g_regdate}</h5>
										</td>
										<td>
											<button class="btn btn-info btn-sm"
												onclick="goDelete(${vo.g_seq})">삭제</button>
										</td>
									</tr>
								</form>
						</tbody>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</section>
	<br />
	<br />
	<br />
	<br />
	<br />
	<p align="center">
		<a class="button primary-btn" href="main.do?user_id=${result }">뒤로가기</a>

	</p>
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
					<div class="col-md-12 text-center wow fadeInUp animated">
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



	<!-- ========================= SCRIPTS ============================== -->


	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.nicescroll.js"></script>
	<script src="js/owl.carousel.js"></script>
	<script src="js/wow.js"></script>
	<script src="js/script.js"></script>
	<script src="js/shopmain.js"></script>
	<script>
		let goDelete = function(g_seq){
			$.ajax({
				url : "deleteGoods.do",
				type : "post",
				data : {"g_seq" : g_seq},
				success : function(data){
					console.log("성공")
					location.href="/getGoods.do";
				},
				error : function(){alert('error')} 
			});
		}
		
		
	
	</script>

</body>
</html>