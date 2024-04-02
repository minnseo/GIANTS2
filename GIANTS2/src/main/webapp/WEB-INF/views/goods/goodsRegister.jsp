<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품 등록폼 시작 -->
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
		<h2>[관리자] 상품등록</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form modelAttribute="goodsVO" action="registerGoods.do" id="register_form" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<%-- 
				<img src="${pageContext.request.contextPath}/goods/imageView.do" width="200" height="200">
				<br> --%>
				<label for="upload">상품 썸네일 사진</label>
				<input type="file" id="upload" name="upload" accept="image/gif,image/png,image/jpeg">
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
				<form:errors path="goods_status" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="goods_category">상품 카테고리</form:label>
				<form:select path="goods_category" id="goods_category">
					<form:option value="0">===선택===</form:option>
					<form:option value="1">유니폼</form:option>
					<form:option value="2">모자</form:option>
					<form:option value="3">응원도구</form:option>
					<form:option value="4">기타</form:option>
				</form:select>
				<form:errors path="goods_category" cssClass="error-color"/>
			</li>
			<li class="hasSize" style="display:none;">
				<div>
					<input type="hidden" name="goods_sizes" value="85">
					<label for="goods_stock1">85</label>
					<input id="goods_stock1" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock1}"/>
					<span id="stock_msg1"></span>
				</div>
				<div>
					<input type="hidden" name="goods_sizes" value="90">
					<label for="goods_stock2">90</label>
					<input id="goods_stock2" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock2}"/>
					<span id="stock_msg2"></span>
				</div>
				<div>
					<input type="hidden" name="goods_sizes" value="95"/>
					<label for="goods_stock3">95</label>
					<input id="goods_stock3" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock3}"/>
					<span id="stock_msg3"></span>
				</div>
				<div>
				    <input type="hidden" name="goods_sizes" value="100"/>
				    <label for="goods_stock4">100</label>
					<input id="goods_stock4" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock4}"/>
					<span id="stock_msg4"></span>
				</div>
				<div>
					<input type="hidden" name="goods_sizes" value="105"/>
					<label for="goods_stock5">105</label>
					<input id="goods_stock5" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock5}"/>
					<span id="stock_msg5"></span>
				</div>
				<div>
					<input type="hidden" name="goods_sizes" value="110"/>
					<label for="goods_stock6">110</label>
					<input id="goods_stock6" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock6}"/>
					<span id="stock_msg6"></span>
				</div>
			</li>
			<li class="hasNoSize" style="display:none;">
				<input type="hidden" name="goods_sizes" value="옵션없음"/>
				<label for="goods_stock7">옵션없음</label>
				<input id="goods_stock7" name="goods_stocks" type="number" placeholder="재고수량 입력" value="${goods_stock7}"/>
				<span id="stock_msg7"></span>
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
			<li><label>상품설명</label></li>
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
		<div class="align-center" style="margin-top:10px;">
			<form:button class="default-btn">등록</form:button>
			<input type="button" value="목록" onclick="location.href='goodsList.do'">
		</div>
	</form:form>
</div>
<!-- 상품 등록폼 시작 -->