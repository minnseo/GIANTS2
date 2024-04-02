<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 리뷰 등록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goodsReview.css">
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>리뷰 작성</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form modelAttribute="goodsReviewVO" action="writeReview.do" id="review_register" enctype="multipart/form-data">
		<form:errors element="div" cssColor="error-color"/>
		<ul>
			<li> 
				<label for="goods_num">구매목록</label>
				<select name="goods_num" id="select_list">
					<c:forEach var="goods" items="${order_list}">
					<option id="select_gnum" value="${goods.goods_num}"<c:if test="${goods_num == goods.goods_num}">selected</c:if>>${goods.goods_name}</option>
					</c:forEach>
				</select>
				<span class="error-color" id="gnum_error"></span>
				<script>
					$(function(){
						$('#gnum_error').text('상품 필수 선택');
						
						if($('#select_gnum').val() > 0){
							$('#gnum_error').text('');
						}
						
					});
				</script>
			</li>
			<li>
				<form:label path="review_title">제목</form:label>
				<form:input path="review_title"/>
				<form:errors path="review_title" cssClass="error-color"/>
			</li>
			<li>
				<fieldset>
					<span id="output_score">별점을 선택하세요</span>
					<input type="radio" name="review_score" value="5" id="rate1"><label for="rate1" class="review-star">★</label>
					<input type="radio" name="review_score" value="4" id="rate2"><label for="rate2" class="review-star">★</label>
					<input type="radio" name="review_score" value="3" id="rate3"><label for="rate3" class="review-star">★</label>
					<input type="radio" name="review_score" value="2" id="rate4"><label for="rate4" class="review-star">★</label>
					<input type="radio" name="review_score" value="1" id="rate5"><label for="rate5" class="review-star">★</label>
					<label>별점</label>
				</fieldset>
				<script> <%-- 별점 변경시 표시되는 숫자 변경 --%>
				 	$(document).ready(function () {
				 		$('input[type="radio"]').click(function () {
				 	          var radioVal = $('input[name="review_score"]:checked').val();
				 	         $('#output_score').text(radioVal);
				 	    });
					});
				</script>
			</li>
			<li>
				<form:label path="review_content">내용</form:label>
				<br>
				<form:textarea path="review_content"/>
				<form:errors path="review_content" cssClass="error-color"/>
			</li>
			<li>
				<label for="upload">사진</label>
				<input type="file" id="upload" name="upload" accept="image/gif,image/png,image/jpeg">
			</li>
		</ul>
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="이전" onclick="location.href='${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${goods_num}#goods_review'">
		</div>
	</form:form>
</div>
<!-- 리뷰 등록 끝 -->