<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글 수정 시작 -->
<!-- include libraries (jquery, bootstrap) : CKEditor 사용을 위해 필요 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
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
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">글 수정</h2>
			<p>커뮤니티 글 수정 페이지입니다.</p>
		</div>
		<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	</div>
	
	<form:form modelAttribute="commuVO" action="update.do" id="modify_form">
	<form:hidden path="commu_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="commu_title"><b>제목</b></form:label>
				<form:input path="commu_title"  style="width:95%; height:20px; margin-left:2%;"/>
				<form:errors path="commu_title" cssClass="error-color" style="margin-left: 4.5%;"/>
			</li>
			<li style="margin-top:1%;">
			<li><h4>내용</h4></li>
			<li style="margin-top:1%;">
				<form:textarea path="commu_content"/>
				<form:errors path="commu_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#commu_content'),{
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
		<div class="align-center" style="margin-top:2%;">
			<form:button class="accept-btn" style="width:5%;">수정</form:button>
			<input type="button" value="목록" onclick="location.href='commuList.do'" class="accept-btn">
		</div>
	</form:form>
</div>
<!-- 게시판 글 수정 끝 -->