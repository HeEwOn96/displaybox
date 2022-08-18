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
	<%String result = (String)session.getAttribute("user_id");%>
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
					<% if(result == null){ %> <a href="viewLogin.do">로그인</a> <% } else { %>
					<a href="logoutService.do">로그아웃</a> <% } %>
			</li></strong>
			<strong><li><a href="manual.do">이용방법</a></li></strong>
			<strong><li>
					<% if(result == null){ %> <a href=viewLogin.do>주문내역</a> <% } else { %>
					<a href=orderlist.do>주문내역</a> <%} %>
			</li></strong>
		</ul>
		<a href="#" class="navbar__toogleBtn"> <i class="fas fa-bars"></i>
		</a>
	</nav>
	<!---------------------------- nav bar 끝 ------------------>


	<!---------------------------- 배너 시작 --------------------->
	<div class="container h-100">
		<div class="text-center">
			<h1 style="margin-bottom: 30px;">제품 구매</h1>
			</nav>
		</div>
	</div>
	</div>
	<!---------------------------- 배너 끝 --------------------->


	<!---------------------------- 장바구니 시작 --------------------->
	<div class="container">
		<div class="cart_inner">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th scope="col"><p
									style="font-size: 35px; font-weight: 500px !important;">${vo.g_name }</p></th>
						</tr>
						<tr>
							<th scope="col"><img src="${vo.g_img}"
								style="width: 500px; margin-right: 30px; margin-bottom: 50px;"></th>
						</tr>
						<tr>
							<th scope="col"><p
									style="font-size: 30px; font-height: 500px;">
									￦
									<fmt:formatNumber value="${vo.g_price }" pattern="#,###" />
								</p></th>
						</tr>
						<tr>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="cart_inner">
			<div class="table-responsive">
				<table class="table">
					<tr class="bottom_button">
						<td><h5
								style="text-align: left !important; padding-right: 400px">포인트</h5></td>
						<td></td>
						<td></td>
						<td>
							<div class="cupon_text d-flex align-items-center">
								<span id="CanPoint" style="font-size: 17px; margin-left: 200px">
									${vo.user_point} </span> <span
									style="font-size: 17px; margin: 0px 10px 0px 5px"> point</span>
								<input type="number" placeholder="사용할 포인트" id="use-point">
								<button class="primary-btn btn"
									onclick="usingPoint(${vo.g_price},${vo.user_point})">적용</button>

							</div>
						</td>
					</tr>
					<tr>
						<td><h5 style="text-align: left !important;">총 결제 금액</h5></td>
						<td></td>
						<td></td>
						<td><span id="final-price" style="font-weight: bold;">￦<fmt:formatNumber
									value="${vo.g_price}" pattern="#,###" /></span>&nbsp원</td>
					</tr>
					<tr class="shipping_area">
						<td class="d-none d-md-block"><h5
								style="text-align: left !important;">결제 방법</h5></td>
						<td></td>
						<td></td>
						<td>
							<div class="shipping_box">
								<ul class="list">
									<li><input type="radio" name="payment" value="">신용카드</li>
									<li><input type="radio" name="payment" value="">가상계좌</li>
									<li><input type="radio" name="payment" value="">카카오페이</li>
									<li><input type="radio" name="payment" value="">네이버페이</li>
								</ul>
								<button type="button" id="kakaopay">카카오페이</button>
							</div>

						</td>
					</tr>
					<tr class="out_button_area">
						<td class="d-none-l"></td>
						<td class=""></td>
						<td></td>
						<td></td>
						<td>
							<div class="checkout_btn_inner d-flex align-items-center">
								<button type="button" class="primary-btn ml-2"
									onclick="location.href='detail.do?g_seq=${vo.g_seq}&user_id=${result }';">뒤로가기</button>
								<button type="button" class="primary-btn ml-2"
									onclick="goodsStatusUpdate(${vo.g_seq })">결제하기</button>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!---------------------------- 장바구니 끝 --------------------->
	<!-- ------------------------- footer 시작 ------------------>
	<footer>
		<div class="container">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="footer_logo   wow fadeInUp animated">
							<img src="images/foruslogo3.png" width="60px" height="60px"
								style="margin-right: 5px;">
							<p>EARTH BOX</p>
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
	
	// 상품 상태 업데이트
	function goodsStatusUpdate(g_seq){
		var user_point = parseInt($("#use-point").val())
		console.log(user_point)
		// nan 값 처리
		if (isNaN(user_point)){
			user_point=0;
		}
	
		console.log(g_seq)
		
		$.ajax({
			url : "goodsStatusUpdate.do",
			type : "post",
			data : {"g_seq" : g_seq,
			"user_point" : user_point	
			},
			success : function(){
				console.log("성공")
			},
			error : function(){
				alert('error')
				} 
		});
		
	}

	// 카카오페이 API
  	$(document).on("click", "#kakaopay", function () {
	
  		$.ajax({
			url: 'kakaopay.do',
			type : "post",
			dataType: 'json',
			success: function(data){
				var box = data.next_redirect_pc_url;
				window.open(box);
				window.location.href = data.next_redirect_app_url;
			},
			error: function(){
				alert("오류")
			}
		});
	})
		
	// 포인트 사용버튼 클릭 시 최종결제금액 변경
	function usingPoint(g_price,user_point){
        var price = parseInt(g_price)
        var point = parseInt($("#use-point").val())
        console.log()
        
        console.log("가격 : "+price)
        console.log("포인투 : "+point)
        
		if (isNaN(point)){
			point=0;
		}
        
        var fPrice = price-point
        console.log(fPrice)
        
         fPrice = fPrice.toString().replace(
                 /\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        $("#final-price").html("")
        $("#final-price").html("￦" + fPrice)
        
	}
		
	
    $('#use-point').on('propertychange change keyup paste input', function() {
        var CanPoint = parseInt($("#CanPoint").html())
         var point =  parseInt($("#use-point").val());
        
        console.log("사용할포인뚜 : "+point)
        console.log("사용가눙한 : "+CanPoint)
        console.log("함수싫행")
         
        if(point > CanPoint) {
           
           $("#use-point").val(CanPoint)
           
        }
        
         });

	  	
	</script>
</body>
</html>








