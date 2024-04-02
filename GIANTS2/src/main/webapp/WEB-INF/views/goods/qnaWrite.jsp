<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 문의 등록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goods.css">
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>문의 작성</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form modelAttribute="goodsQnaVO" action="writeQna.do" id="qna_register">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="goods_num">문의할 상품</label>
				<select name="goods_num" id="qna_gnum" required>
					<option class="select-gnum align-center" value="0">====선택====</option>
					<c:forEach var="goods" items="${goods_list}">
					<option class="select-gnum" value="${goods.goods_num}"<c:if test="${goods_num == goods.goods_num}">selected</c:if>>${goods.goods_name}</option>
					</c:forEach>
				</select>
				<span class="error-color" id="gnum_error"></span>
				<script>
					$(function(){
						$('#gnum_error').text('상품 필수 선택');
						
						console.log($('#qna_gnum option:selected').val());
						if($('#qna_gnum option:selected').val() > 0){
							$('#gnum_error').text('');
						}
						
					});
				</script>
			</li>
			<li>
				<form:label path="qna_title">제목</form:label>
				<form:input path="qna_title"/>
				<form:errors path="qna_title" cssClass="error-color"/>
			</li>
			<br>
			<li>
				<form:label path="qna_content">내용</form:label>
				<form:textarea path="qna_content"/>
				<form:errors path="qna_content" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="이전" onclick="location.href='${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${goods_num}#goods_qna'">
		</div>
	</form:form>
</div>
<!-- 문의 등록 끝 -->