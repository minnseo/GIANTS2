<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 문의 수정 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goods.css">
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>문의 수정</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form modelAttribute="goodsQnaVO" action="updateGoodsQna.do" id="qna_modify">
		<form:hidden path="qna_num"/>
		<form:hidden path="goods_num"/>
		<form:errors element="div" cssColor="error-color"/>
		<ul>
			<li>
				<label>문의할 상품</label>
				${goodsQnaVO.goods_name}
			</li>
			<li>
				<form:label path="qna_title">제목</form:label>
				<form:input path="qna_title"/>
				<form:errors path="qna_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="qna_content">내용</form:label>
				<form:textarea path="qna_content"/>
				<form:errors path="qna_content" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>수정</form:button>
			<input type="button" value="상세페이지" onclick="location.href='goodsDetail.do?goods_num=${goodsQnaVO.goods_num}#goods_qna'">
		</div>
	</form:form>
</div>
<!-- 문의 등록 끝 -->