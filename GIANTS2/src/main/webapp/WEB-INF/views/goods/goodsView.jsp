<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 상품 상세 페이지 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goodsDetail.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.review.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.qna.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods_cart.js"></script>
<div class="page-main">
	<div class="content-main">
		<c:if test="${!empty user && user.mem_auth == 9}">
		<div class="align-left">
			<input type="button" value="[관리자]목록" onclick="location.href='${pageContext.request.contextPath}/member/adminMypageGoodsList.do'" id="admin_btn">
			<input type="button" value="일반목록" onclick="location.href='goodsList.do'">
		</div>
		<div class="align-right">
			<input type="button" value="수정" onclick="location.href='goodsUpdate.do?goods_num=${goods.goods_num}'">
		</div>
		</c:if>
		<div class="goods-photo">
			<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${goods.goods_num}">
		</div>
		<div class="goods-info" ><br><br>
			<div>
				<span>카테고리 - </span>
				<c:if test="${goods.goods_category == 1}">
					<a href="goodsList.do?keyfield=3&keyword=&order=1&goods_category=1">유니폼</a>
				</c:if>
				<c:if test="${goods.goods_category == 2}">
					<a href="goodsList.do?keyfield=3&keyword=&order=1&goods_category=2">모자</a>
				</c:if>
				<c:if test="${goods.goods_category == 3}">
					<a href="goodsList.do?keyfield=3&keyword=&order=1&goods_category=3">응원도구</a>
				</c:if>
				<c:if test="${goods.goods_category == 4}">
					<a href="goodsList.do?keyfield=3&keyword=&order=1&goods_category=4">기타</a>
				</c:if>
			</div>
			<h3 class="goods-name">${goods.goods_name}</h3>
			<hr size="2" width="97%">
			<form id="goods_cart" method="post">
				<input type="hidden" name="goods_num" value="${goods.goods_num}" id="goods_num">
				<input type="hidden" name="goods_dprice" value="${goods.goods_price}" id="goods_price">
				
				
				<ul> 
					<li>
						상태 :  
						<c:if test="${goods.goods_status == 1}">판매중</c:if>
						<c:if test="${goods.goods_status == 2}">판매중지</c:if>
						<input type="hidden" name="goods_status" value="${goods.goods_status}" id="goods_status">
					</li>
					<li>
						판매가 : <s><fmt:formatNumber value="${goods.goods_price}" type="number"/>원</s>
						  (<fmt:formatNumber value="${goods.goods_disc}" type="number"/>% 할인)
						<span style="font-size:30px;">
							<fmt:formatNumber value="${goods.goods_dprice}" type="number"/>원
						</span>
					</li>
					<li>
						평점 : 
						<span id="avg_star">★</span> (<span id="output_score">${avg_score}</span>)
					</li>
				<c:if test="${goods.goods_status == 1}">
					<li>
						<li>
						    옵션 : 
						    <select id="optionSelect" name="opt_num">
						        <option value="" class="align-center">===선택안함===</option>
						        <c:forEach var="option" items="${option}">
						            <option value="${option.opt_num}" data-stock="${option.goods_stock}">
						                <c:if test="${option.goods_stock > 0}">${option.goods_size} [재고 : ${option.goods_stock}]</c:if>
						                <c:if test="${option.goods_stock <= 0}">${option.goods_size} [품절]</c:if>
						            </option>
						        </c:forEach>
						    </select>
						    
						</li>
						
						
					</li>
					<%-- 
					<li>
						마킹리스트
						<select>
							<c:forEach var="player" items="playerVO">
							<option value="${player.player_num}">${player.player_num}번 ${player.player_name}</option>
							</c:forEach>
						</select>
					</li>
					--%>
					<li>
						수량 : 
						<input type="number" name="order_quantity" id="order_quantity">
						<img>
						<img>
					</li>
					
					<li>
						상품등록일 : ${goods.goods_regdate}
						<c:if test="${!empty goods.goods_mdate}"><br>최근수정일 : ${goods.goods_mdate}</c:if>
					</li>
				</c:if>
				</ul>
				
				<div class="goods-btns">
					<button type="button" class="not-css">
						<div id="goods_fav">
							<img id="fav_btn" data-num="${goods.goods_num}" src="${pageContext.request.contextPath}/images/nofav.png">
							<span>찜하기</span>
							<c:if test="${!empty user}">[<span id="output_fcount"></span>]</c:if>
						</div>
					</button>
					
				<c:if test="${goods.goods_status == 1 && total_stock > 0}">
						<button type="submit" class="not-css">
							<div id="goods_cart">
								<img id="cart_btn" data-num="${goods.goods_num}" src="${pageContext.request.contextPath}/images/cart.png" width="20">
								<span>장바구니</span>
							</div>
						</button>
				</form>               
			<!-- 장바구니 폼 끝 -->
			
			 <!-- 바로 구매 폼 -->
	        <form id="goods_direct" method="post" action="${pageContext.request.contextPath}/gorder/orderFormDirect.do">
		        <input type="hidden" id="hidden_opt_num" name="opt_num">
				<input type="hidden" name="goods_num">
				<input type="hidden" name="order_quantity">
				<input type="hidden" name="goods_name">
				<input type="hidden" name="goods_dprice">
				<input type="hidden" name="goods_status">
		        
			        <button type="submit" class="not-css">
						<div id="goods_pay">
							<img id="pay_btn" data-num="${goods.goods_num}" src="${pageContext.request.contextPath}/images/card.png" width="20">
							<span>바로구매</span>
						</div>
					</button>	
				
			</form>
			<script>
				    // select 태그에서 선택된 opt_num 넘겨주기
				    $('#optionSelect').change(function() {
				        var selectedOption = $(this).find('option:selected');
				        var optNumValue = selectedOption.val();
				        $('#hidden_opt_num').val(optNumValue);
				    });
			</script>
				</c:if>
				
				<c:if test="${total_stock <= 0}">
				<div id="sold-out" style="cursor:default;">
					SOLD OUT
				</div>
				</c:if>
				
				<c:if test="${goods.goods_status == 2}">
				<div id="sold-out" style="cursor:default;">
					<span>판매중지</span>
				</div>
				</c:if>
			</div>
				
				<hr size="1" width="97%">
			
		</div> <%-- end of goods-info --%>
		<div class="float-clear"></div>
		<div class="medium-nav">
			<nav>
				<ul>
					<li class="selected"><a href="#goods_content">상품상세정보</a>
					<li><a href="#goods_delivery">배송/교환 안내</a>
					<li><a href="#goods_review">상품후기</a>
					<li><a href="#goods_qna">상품문의</a>
				</ul>
			</nav>
		</div>
		<p>
		<div id="goods_content" class="goods-subinfo">
			<div class="align-center" style="margin-top:10px;">
				<img src="${pageContext.request.contextPath}/images/goods_detail_repeat.jpg" width="700">
			</div>
			${goods.goods_content}
		</div>
		<div class="medium-nav">
			<nav>
				<ul>
					<li><a href="#goods_content">상품상세정보</a>
					<li class="selected"><a href="#goods_delivery">배송/교환 안내</a>
					<li><a href="#goods_review">상품후기</a>
					<li><a href="#goods_qna">상품문의</a>
				</ul>
			</nav>
		</div>
		<div id="goods_delivery">
			<div class="deli-sub">
				<h3 class="del-title">*주문방법</h3>
				<ul>
					<li>각 코너를 클릭하셔서 들어갑니다.</li>
					<li>사진이나 상품명을 클릭하세요.</li>
					<li>'장바구니에 담기'를 클릭하세요.</li>
					<li>'장바구니에 넣었습니다' 메시지가 나오면, 주문상품을 확인한 후 '주문' 버튼을 클릭하세요.</li>
					<li>주문버튼을 누르면 '주문서'가 나옵니다.</li>
					<li>주문서를 작성 후 결제하면 주문이 완료됩니다.</li>
				</ul>
			</div>
			<div class="deli-sub">
				<h3 class="del-title">*상품배송</h3>
				<ul>
					<li>각 코너를 클릭하셔서 들어갑니다.</li>
					<li>주문하신 상품은 택배로 발송됩니다.</li>
					<li>주문하신 날로부터 3~7일 안에 받으실 수 있습니다.</li>
					<li>최종 주문 결제금액 기준 5만원 미만은 3,000원의 배송비가 청구되며 5만원 이상 주문 시 무료배송입니다.
						<br>(도서,산간,오지 일부 지역은 배송비가 추가될 수 있습니다.)</li>
				</ul>
			</div>
			<div class="deli-sub">
				<h3 class="del-title">*고객센터</h3>
				<ul>
					<li>반품처 : 서울특별시 강남구 역삼동 ****</li>
					<li>주문하신 상품은 택배로 발송됩니다.</li>
					<li>고객센터 : 070-1111-0000 (오전 10시 ~ 오후 5시 운영/토,일 및 공휴일 휴무)</li>
					<li>개인정보보호 담당자 : 홍길동 / 전화 : 051)000-0000 / <br>메일 : test@test.com</li>
				</ul>
			</div>
			<div class="deli-sub" style="height:350px;">
				<h3 class="del-title">*교환/반품</h3>
				<ul>
					<li>배송비 : 왕복 6,000원 (도서,산간,오지 일부 지역은 배송비가 추가될 수 있습니다.)</li>
					<li>상품 수령 후 7일 이내 교환/환불을 요청해야 합니다.</li>
					<li>
						교환/반품이 불가능한 경우
						<br>
						-반품 요청 기간(수령 후 7일 이내)이 경과한 경우<br>
						-상품을 사용(또는 착용, 착화) 혹은 훼손하여 재판매가 어려운 경우<br>
						-고객의 주문에 따라 개별적으로 생산된 상품의 경우(주문제작 상품 등)
					</li>
					<li>고객의 변심에 의한 교환 및 반품인 경우 배송비는 '소비자' 부담입니다.</li>
					<li>상품의 이상에 의한 교환 및 반품인 경우 배송비는 '판매자' 부담입니다.</li>
				</ul>
			</div>
		</div>
		<div class="medium-nav">
			<nav>
				<ul>
					<li><a href="#goods_content">상품상세정보</a>
					<li><a href="#goods_delivery">배송/교환 안내</a>
					<li class="selected"><a href="#goods_review">상품후기</a>
					<li><a href="#goods_qna">상품문의</a>
				</ul>
			</nav>
		</div>
		<div id="goods_review">
			<div class="align-right" style="margin:10px 23px 0 0;">
				<input type="button" value="리뷰작성" onclick="location.href='writeReview.do?goods_num=${goods.goods_num}'">
			</div>
			<div id="review_output"></div>
			<div id="review_page"></div>
		</div>  
		<div class="medium-nav">
			<nav>
				<ul>
					<li><a href="#goods_content">상품상세정보</a>
					<li><a href="#goods_delivery">배송/교환 안내</a>
					<li><a href="#goods_review">상품후기</a>
					<li class="selected"><a href="#goods_qna">상품문의</a>
				</ul>
			</nav>
		</div>
		<div id="goods_qna">
			<div class="align-right" style="margin:10px 23px 0 0;">
				<input type="button" value="문의등록" onclick="location.href='writeQna.do?goods_num=${goods.goods_num}'">
			</div>
			<div id="qna_output"></div>
			<div id="qna_page"></div>
		</div>
	</div> <%-- end of content-main --%>
</div>
<!-- 상품 상세 페이지 끝 -->