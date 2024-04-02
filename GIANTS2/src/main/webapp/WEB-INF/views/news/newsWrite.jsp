<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 뉴스 등록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/news.css">
<!-- include libraries (jquery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckdeitor js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<style>
.ck-editor__editable_inline{ 
	min-height:250px;
}
</style>
<div class="page-main">
	<div class="news-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>[관리자] 뉴스 등록</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form modelAttribute="newsVO" action="newsWrite.do" id="register_form">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="news_title">제목</form:label>
				<form:input path="news_title"/>
				<form:errors path="news_title" cssClass="error-color"/>
			</li>
			<li><label>내용</label></li>
			<li>
				<form:textarea path="news_content"/>
				<form:errors path="news_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#news_content'), {
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
		<div class="align-right">
			<form:button>등록</form:button>
			<input type="button" value="목록" onclick="location.href='newsList.do'">
		</div>
	</form:form>
</div>
<!-- 뉴스 등록 끝 -->