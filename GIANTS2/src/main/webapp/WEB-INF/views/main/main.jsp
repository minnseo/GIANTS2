<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
button{
	border: none;
	background-color: white;	
}
</style>
<!-- 내용 S -->
<!-- 이미지 슬라이드 시작 -->
<div class="image-slide">
	<ul>
		<li>
			<img src="${pageContext.request.contextPath}/images/main-image4.jpg" width="100%">
		</li>
		
		<li>
			<img src="${pageContext.request.contextPath}/images/main-image3.jpg" width="100%">
		</li>
		
		<li>
			<img src="${pageContext.request.contextPath}/images/main-image5.jpg" width="100%">
		</li>
	</ul>
</div>
 <script>
$(document).ready(function() {
	
    var slideIndex = 0;
    showSlide(slideIndex);
          
    function showSlide(index) {
    	var slides = $(".image-slide li");
        if (index >= slides.length) {
        	slideIndex = 0;
        } else if (index < 0) {
        	slideIndex = slides.length - 1;
		}
        slides.hide();
        slides.eq(slideIndex).fadeIn();
        slideIndex++;
        setTimeout(function() {
        	showSlide(slideIndex);
        }, 3000); // 3초마다 이미지 전환
	}
});
</script>
<!-- 이미지 슬라이드 끝 -->

<div class="main-div">
	<div class="main1">
		<div class="section-title align-center">
			<h2>경기일정</h2>
			<hr size="0.05" width="10%" noshade style="margin:3px auto;">
			<h3>롯데자이언츠 정규리그 일정</h3>
		</div>
		<c:forEach var="game" items="${list}" begin="0" end="3">
		<div class="game-info align-center">
			<div class="div-margin">
			<c:if test="${game.game_week == 0}"><span class="spanWeek">WEEK</span></c:if>
			<c:if test="${game.game_week == 1}"><span class="spanWeekend">WEEKEND</span></c:if>
			</div>
			<div class="div-margin">${game.game_date} ${game.game_time} [사직]</div>
			<div class="div-margin"><img src="${pageContext.request.contextPath}/images/${game.game_team}.png"> VS <img src="${pageContext.request.contextPath}/images/giants.png"></div>
			<div class="div-margin">
				<hr size="0.05" width="10%" noshade style="margin:3px auto;">
				<c:if test="${game.game_state == 0 || game.game_state == 1 || game.game_state == 2}"><span class="spanStatus">경기예정</span></c:if>
				<c:if test="${game.game_state == 3}"><span class="spanStatus">경기취소</span></c:if>
				<c:if test="${game.game_state == 4}"><span class="spanStatus">경기종료</span></c:if>
				<hr size="0.05" width="10%" noshade style="margin:3px auto;">
			</div>
		</div>
		</c:forEach>
	</div> 
	<div class="main2">
		<div class="section-title align-center goods-space">
			<h2>GOODS TOP7</h2>
			<hr size="0.05" width="10%" noshade style="margin:3px auto;">
			<c:forEach var="goods" items="${goodsList}" begin="0" end="6">
			<div class="news-info">
				<div class="news-left">
					<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${goods.goods_num}" height="62">
				</div>
				<div class="news-right">
					<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${goods.goods_num}">
						<span>${goods.goods_name}</span>
					</a>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
	<div class="main3">
		<div class="main3-1">
			<div class="section-title align-center">
				<h2>자이언츠 뉴스</h2>
				<hr size="0.05" width="10%" noshade style="margin:3px auto;">
				<c:forEach var="news" items="${newsList}" begin="0" end="3">
					<div class="news-info">
						<div class="news-left"><img src="${pageContext.request.contextPath}/images/giants.png"></div>
						<div class="news-right">
							<a href="${pageContext.request.contextPath}/news/newsDetail.do?news_num=${news.news_num}">
								<h3>${fn:substring(news.news_title, 0, 20)}</h3>
								<p>${fn:substring(news.news_content, 0, 20)}</p>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="main3-2">
			<div class="ticket-btn">
				<a href="${pageContext.request.contextPath}/ticket/gameList.do"><img src="${pageContext.request.contextPath}/images/ticket_btn.png"></a>
			</div>
			<div class="goods-btn">
				<a href="${pageContext.request.contextPath}/goods/goodsList.do"><img src="${pageContext.request.contextPath}/images/goods_btn.png"></a>
			</div>
		</div>
	</div>
</div>
<div class="main-div2">
	<div class="main4">
		<a href="https://www.facebook.com/lottegiantsbusan/" target="_blank" title="facebook">
			<img src="${pageContext.request.contextPath}/images/facebook.png" width="100%" height="100">
		</a>
	</div>
	<div class="main5">
		<a href="https://www.youtube.com/channel/UCAZQZdSY5_YrziMPqXi-Zfw" target="_blank" title="youtube">
			<img src="${pageContext.request.contextPath}/images/youtube.jpg" width="100%" height="100">
		</a>
	</div>
	<div class="main6">
		<a href="https://www.instagram.com/busanlottegiants/" target="_blank" title="instagram">
			<img src="${pageContext.request.contextPath}/images/instagram.png" width="100%" height="100">
		</a>
	</div>
</div>

