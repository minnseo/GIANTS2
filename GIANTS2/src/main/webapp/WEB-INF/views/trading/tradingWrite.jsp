<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 중고거래 게시판 글 등록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KMS/trading.css">
<!-- include libraries (jquery, bootstrap) -> CKEditor를 사용하기 위해 필요한 라이브러리 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include CKEditor js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>게시글 작성</h2>
	<br>
	<form:form modelAttribute="tradingVO" action="tradingWrite.do" id="register_form" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
			<ul>
				<li>
					<form:label path="trade_title"><b>제목</b></form:label>
					<form:input path="trade_title" id="trading_title"/>
					<form:errors path="trade_title" cssClass="error-color"/>
				</li>
				<li>
					<form:label path="trade_price"><b>가격</b></form:label>
					<form:input path="trade_price" type="number" id="price_form"/>원
					<form:errors path="trade_price" cssClass="error-color"/>
				</li>
				<li>
					<label for="upload"><b>상품 이미지</b></label>
					<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg">
					<form:errors path="trade_photo" cssClass="error-color"/>
				</li>
				<br>
				<li>
					<form:textarea path="trade_content"/>
					<form:errors path="trade_content" cssClass="error-color"/>
					<script>
						function MyCustomUploadAdapterPlugin(editor){
							editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
								return new UploadAdapter(loader);
							}
						}
						
						ClassicEditor.create(document.querySelector('#trade_content'),{
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
				<li id="status">
					<label><b>거래 상태</b></label>&nbsp;
					<form:radiobutton path="trade_status" value="0" id="status1"/>판매중
					<form:radiobutton path="trade_status" value="1" id="status2"/>거래 완료
				</li>
			</ul>
			<br>
			<div class="align-center">
				<form:button class="red-btn small">등록</form:button>
				<input type="button" value="목록" onclick="location.href='tradingList.do'" class="classic-btn small">
			</div>
	</form:form>
</div>
<!-- 중고거래 게시판 글 등록 끝 -->