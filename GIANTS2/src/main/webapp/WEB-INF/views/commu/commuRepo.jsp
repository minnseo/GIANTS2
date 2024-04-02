<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
<style>
body, div, h1, h2, h3, h4, h5, h6, ul, ol, li, dl, dt, dd, p, form, fieldset, input, table, tr, th, td {
    margin: 7px;
    padding: 0;
}

input[type="text"] {
    width: 25%;
    height: 100px;
}
</style>

<script>
$(document).ready(function(){
    $("#commuRepo").submit(function(event){
        if($("input[name='repo_category']:checked").length == 0){
            alert("신고유형 선택 필수!");
            event.preventDefault(); // Prevent form submission
        }
    });
});
</script>

<div class="page-main">
  	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">커뮤니티 신고</h2>
			<p>커뮤니티 신고 페이지입니다.</p>
		</div>
		<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	</div>
      	 
      	
      	<form:form modelAttribute="commuReportVO" action="commuRepo.do" id="commuRepo" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<input type="hidden" name="commu_num" value="${commu.commu_num}">
		<ul>
			<li>
				<form:radiobutton path="repo_category" value="1" id="status1" name="repo_category"/>음란성 또는 부적합한 내용
			</li>
			<li>
				<form:radiobutton path="repo_category" value="2" id="status2" name="repo_category"/>특정인 대상의 비방/욕설
			</li>
			<li> 
				<form:radiobutton path="repo_category" value="3" id="status3" name="repo_category"/>명예 훼손/사생활 침해 및 저작권 침해 등
			</li>
			<li style="margin-top:1%;">
				<form:label path="repo_content" style="margin-left:1%;">신고 내용</form:label>	
				<br>		
				<form:input path="repo_content" />
				<form:errors path="repo_content" cssClass="error-color"/>
			</li>
		</ul>
		
		<div class="align-center">
			<form:button class="accept-btn" style="width:5%;">등록</form:button>
			<input type="button" value="취소" id="regbtn" onclick="location.href='commuList.do'" class="accept-btn">
		</div> 
	</form:form>
      	

</div>
</html>