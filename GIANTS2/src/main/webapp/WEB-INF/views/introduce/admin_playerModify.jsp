<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
<style>
body, div, h1, h2, h3, h4, h5, h6, ul, ol, li, dl, dt, dd, p, form, fieldset, input, table, tr, th, td {
    margin: 5px;
    padding: 0;
}
#player_toway{
	margin-left:2.5%;
}
#player_weight{
	margin-left:1.5%;
}
#player_height{
	margin-left:3.7%;
}
#player_position{
	margin-left:1.5%;
}
#player_backnumber{
	margin-left:2.5%;
}
#player_name{
	margin-left:4%;
}
#upload{
	margin-left:3%;
}
input[type="text"]{
	width:20%;
	height: 20px;
}
</style>
<div id="item_form" class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">선수 정보 수정</h2>
			<p>선수 정보 수정 페이지입니다.</p>
		</div>
	</div>
	<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	
	
	<form:form modelAttribute="playerVO" action="admin_playerModify.do" id="admin_playerModify" enctype="multipart/form-data">
		<form:hidden path="player_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<ul class="align-left" style="margin-top: 3%;">
			<li>
				<form:label path="player_name">선수명</form:label>
				<form:input path="player_name"/>
				<form:errors path="player_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_backnumber">선수 번호</form:label>
				<form:input path="player_backnumber"/>
				<form:errors path="player_backnumber" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_position">선수 포지션</form:label>
				<form:input path="player_position"/>
				<form:errors path="player_position" cssClass="error-color"/>
			</li>
			<li>
				<label for="upload">선수 사진</label>
				<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg">
				<form:errors path="player_photo" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_birthday">선수 생년월일</form:label>
				<form:input path="player_birthday"/>
				<form:errors path="player_birthday" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_height">선수 키</form:label>
				<form:input path="player_height" />
				<form:errors path="player_height" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_weight">선수 몸무게</form:label>
				<form:input path="player_weight" />
				<form:errors path="player_weight" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_toway">선수 투타</form:label>
				<form:input path="player_toway"/>
				<form:errors path="player_toway" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_join">선수 입단년도</form:label>
				<form:input path="player_join"/>
				<form:errors path="player_join" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="player_career">선수 경력사항</form:label>
				<form:input path="player_career"/>
				<form:errors path="player_career" cssClass="error-color"/>
			</li>
			
			
		</ul>
		<div class="align-center" style="margin-top:3%;">
			<form:button class="accept-btn" style="width:6%;">수정</form:button>
			<input type="button" value="삭제" id="delete_btn" class="accept-btn">
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						//히스토리를 지우면서 이동
						location.replace('admin_playerDelete.do?player_num=${playerVO.player_num}');
					}
				};
			</script>
			<input type="button" value="목록" onclick="location.href='player.do'" class="accept-btn">
		</div>
	</form:form>
</div>