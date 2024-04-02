<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 유저 QR코드 생성 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/qrcode.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="${pageContext.request.contextPath}/food/forder/myFoodOrderList.do'">내 주문목록</a> | 주문상세정보 | QR코드</h2>
	</div>
	<hr noshade="noshade">
	<!-- 내용물 시작 -->
	<div class="orderDetail-container">
		<!-- 타이틀 -->
		<div class="order-title">
			<h2>QR코드 출력화면</h2>
			<hr>
		</div>
		<!-- QR이미지 출력부분 -->
		<div class="order-List align-center">
			<input type="hidden" value="http://localhost:8000${qrlink}" id="qrlink">
			<div id="qrcode"></div>
			
			<p>
				<a href="http://localhost:8000${qrlink}">기업QR승인 페이지</a><br><br>
				http://localhost:8000${qrlink}
			</p>
		</div>
		<!-- 하단 버튼들 -->
		<div class="order-buttons align-center">
			<input type="button" value="뒤로가기" class="orderDetail-btn" onclick="location.href='${pageContext.request.contextPath}/food/forder/myFoodOrderList.do?f_order_num=${f_order_num}'">
		</div>
	</div>
	<!-- 내용물 끝 -->
	<script type="text/javascript">
		$(function(){
			let qrcode = new QRCode(document.getElementById("qrcode"),{
				width:100,
				height:100
			});
			
			function makeCode(){
				let qrlink = document.getElementById("qrlink");
				qrcode.makeCode(qrlink.value);
			}
			makeCode();
		});
	</script>
</div>
<!-- 유저 QR코드 생성끝 -->