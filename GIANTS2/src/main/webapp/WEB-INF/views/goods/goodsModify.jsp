<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품 수정폼 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goods.css">
<!-- include libraries (jquery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckdeitor js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.option.js"></script>
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>[관리자] 상품수정</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form modelAttribute="goodsVO" action="goodsUpdate.do" id="update_form" enctype="multipart/form-data">
		<form:hidden path="goods_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<%-- 
				<img src="${pageContext.request.contextPath}/goods/goodsPhotoView.do" width="200" height="200">
				<br> --%>
				<label for="upload">상품 썸네일 사진</label>
				<input type="file" id="upload" name="upload" accept="image/gif,image/png,image/jpeg">
				<c:if test="${!empty goodsVO.goods_photo}">
				<div id="file_detail">
					<span>(${goodsVO.goods_photoname})파일이 등록되어 있습니다.</span>
				</div>
				</c:if>
				<form:errors path="goods_photo" cssClass="error-color"/>
			</li>
			<li> 
				<form:label path="goods_name">상품명</form:label>
				<form:input path="goods_name"/>
				<form:errors path="goods_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="goods_status">상태</form:label>
				<form:radiobutton path="goods_status" value="1"/><span class="radio-status">판매중</span>
				<form:radiobutton path="goods_status" value="2"/><span class="radio-status">판매중지</span>
				<form:errors path="goods_content" cssClass="error-color"/>
			</li>
			<li>
				<label>상품 카테고리</label>
				<input type="hidden" id="goods_category" name="goods_category" value="${goodsVO.goods_category}">
				<c:if test="${goodsVO.goods_category == 1}">유니폼</c:if>
				<c:if test="${goodsVO.goods_category == 2}">모자</c:if>
				<c:if test="${goodsVO.goods_category == 3}">응원도구</c:if>
				<c:if test="${goodsVO.goods_category == 4}">기타</c:if>
			</li>
				
			<li>
				<c:forEach var="goodsOptionVO" items="${list}" varStatus="status">
				<div>
					<input type="hidden" name="goods_sizes" value="${goodsOptionVO.goods_size}">
					<label for="goods_stock${status.count}">${goodsOptionVO.goods_size} 수량</label>
					<input id="goods_stock${status.count}" name="goods_stocks" type="number" value="${goodsOptionVO.goods_stock}" placeholder="재고수량 입력"/>
					<span id="stock_msg${status.count}"></span>
				</div>
				</c:forEach>
			</li>
			<li>
				<form:label path="goods_price">상품가격</form:label>
				<form:input path="goods_price" type="number"/> 원
				<form:errors path="goods_price" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="goods_disc">할인율</form:label>
				<form:input path="goods_disc" type="number"/> %
				<form:errors path="goods_disc" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="goods_dprice">판매가격</form:label>
				<form:input path="goods_dprice" type="number" readonly="true"/> 원
				<form:errors path="goods_dprice" cssClass="error-color"/>
			</li>
			<li>상품설명</li>
			<li>
				<form:textarea path="goods_content"/>
				<form:errors path="goods_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#goods_content'), {
									extraPlugins:[MyCustomUploadAdapterPlugin]
								 })
								 .then(editor => {
									 window.editor = editor;
								 })
								 .catch(error => {
									 console.error(error);
								 });
				</script>
			</li>
		</ul>
		<div class="align-center" style="margin-top:5px;">
			<form:button class="default-btn">수정</form:button>
			<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/member/adminMypageGoodsList.do'">
		</div>
	</form:form>
</div>
<!-- 상품 수정폼 시작 -->