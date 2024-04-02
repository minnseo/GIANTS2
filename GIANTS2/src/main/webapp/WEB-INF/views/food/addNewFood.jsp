<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 메뉴/식품 등록 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
.page-main{
	color:gray !important;	
}
</style>
<!-- include ckeditor js -->
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<!-- 타이틀 시작 -->
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">기업</a> | <a href="/food/food_CompDetail.do">메뉴/식품 등록</a></h2>
	</div>
	<hr noshade="noshade">
	<!-- 타이틀 끝 -->
 	<!-- 상품 등록 폼 시작 -->
	<form:form modelAttribute="foodVO" action="addNewFood.do" id="food_add" enctype="multipart/form-data">
		<div class="comp-container tbox">
			<h2>식품 등록</h2>
			<!-- 상단 분리박스 -->
			<div class="inner-top">
				<ul>
					<li>
						<div class="label-wid"><form:label path="food_name">식품명</form:label></div>
						<form:input path="food_name" placeholder="최대20자" autocomplete="off"/>
						<form:errors path="food_name" cssClass="error-color"/>
					</li>
					<li>
						<div class="label-wid"><form:label path="food_price">식품가격</form:label></div>
						<form:input path="food_price" type="number" placeholder="최대9자리숫자" autocomplete="off"/>
						<form:errors path="food_price" cssClass="error-color"/>
					</li>
					<li>
						<div class="label-wid"><form:label path="food_quantity">재고수량</form:label></div>
						<form:input path="food_quantity" type="number" placeholder="최대9자리숫자" autocomplete="off"/>
						<form:errors path="food_quantity" cssClass="error-color"/>
					</li>
					<li><b>상품설명</b></li>
					<li>
						<form:textarea path="food_content"/>
						<form:errors path="food_content" cssClass="error-color"/>
						<script>
							function MyCustomUploadAdapterPlugin(editor){
								editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
									return new UploadAdapter(loader);
								}
							}
							
							ClassicEditor.create(document.querySelector('#food_content'),{
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
			</div>
			<hr noshade="noshade">
			<!-- 하단 분리박스 -->
			<div class="inner-bottom">
				<ul>
					<li>
						<div class="label-wid"><label for="upload1">식품 메인 이미지</label></div>
						<input type="file" name="upload1" id="upload1" accept="image/gif,image/png,image/jpeg"></input>
					</li>
					<li>
						<div class="label-wid"><label for="upload2">식품 상세 이미지</label></div>
						<input type="file" name="upload2" id="upload2" accept="image/gif,image/png,image/jpeg"></input>
					</li>
					<li>
						<div class="label-wid"><label>표시 여부</label></div>
						<form:radiobutton path="food_status" value="1" id="food_status1"/>비활성화
						<form:radiobutton path="food_status" value="2" id="food_status2" />활성화
						<form:errors path="food_status" cssClass="error-color"/>
					</li>
				</ul>
			</div>
			<div class="align-center">
				<form:button>등록하기</form:button>
				<input type="button" value="취소" onclick="location.href='fixCompFoodList.do'">
			</div>
		</div>
	</form:form>
	<!-- 상품 등록 폼 끝 -->
</div>
<!-- 메뉴/식품 등록 페이지 끝 -->