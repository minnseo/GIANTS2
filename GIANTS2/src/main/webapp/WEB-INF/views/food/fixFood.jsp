<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 메뉴/식품 수정 페이지 -->
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodFix.js"></script>
<div class="page-main">
	<!-- 타이틀 시작 -->
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">매장</a> | <a href="/food/food_CompDetail.do">메뉴/식품 수정</a></h2>
	</div>
	<hr noshade="noshade">
	<!-- 타이틀 끝 -->
 	<!-- 상품 수정 폼 시작 -->
	<form:form modelAttribute="foodVO" action="fixFood.do" id="food_fix" enctype="multipart/form-data">
		<form:hidden path="food_num"/>
		<div class="comp-container tbox">
			<h2>식품 수정</h2>
			<!-- 상단 분리박스 -->
			<div class="inner-top">
				<ul>
					<li>
						<form:label path="food_name" class="label-wid">식품명</form:label>
						<form:input path="food_name" placeholder="최대20자" autocomplete="off"/>
						<form:errors path="food_name" cssClass="error-color"/>
					</li>
					<li>
						<form:label path="food_price" class="label-wid">식품가격</form:label>
						<form:input path="food_price" type="number" placeholder="최대9자리숫자" autocomplete="off"/>
						<form:errors path="food_price" cssClass="error-color"/>
					</li>
					<li>
						<form:label path="food_quantity" class="label-wid">재고수량</form:label>
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
						<label for="upload1" class="label-wid">식품 메인 이미지</label>
						<input type="file" name="upload1" id="upload1" accept="image/gif,image/png,image/jpeg"></input>
						<form:errors path="food_photo1" cssClass="error-color"/>
						<span id="upload1_name">
							<c:if test="${empty foodVO.food_photo1}"></c:if>
							<c:if test="${!empty foodVO.food_photo1}">현재 등록된 이미지 - ${foodVO.food_photo1_name}</c:if>
						</span>
					</li>
					<li>
						<label for="upload2" class="label-wid">식품 상세 이미지</label>
						<input type="file" name="upload2" id="upload2" accept="image/gif,image/png,image/jpeg"></input>
						<form:errors path="food_photo2" cssClass="error-color"/>
						<span id="upload2_name">
							<c:if test="${empty foodVO.food_photo2}"></c:if>
							<c:if test="${!empty foodVO.food_photo2}">현재 등록된 이미지 - ${foodVO.food_photo2_name}</c:if>
						</span>
					</li>
					<li>
						<label class="label-wid">표시 여부</label>
						<form:radiobutton path="food_status" value="1" id="food_status1"/> 비활성화
						<form:radiobutton path="food_status" value="2" id="food_status2"/> 활성화
						<form:errors path="food_status" cssClass="error-color"/>
					</li>
				</ul>
			</div>
			<div class="align-center">
				<form:button>수정하기</form:button>
				<input type="button" value="취소" onclick="location.href='fixCompFoodList.do'">
			</div>
		</div>
	</form:form>
	<!-- 상품 수정 폼 끝 -->
</div>
<!-- 메뉴/식품 수정 페이지 끝 -->