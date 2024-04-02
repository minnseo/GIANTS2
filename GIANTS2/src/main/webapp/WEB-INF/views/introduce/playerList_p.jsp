<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
li{
	float:left;
}
.result-display{
	width:400px;
	height:200px;
	margin:50px auto;
	border:1px solid #000;
	display:flex;
	align-items:center;
	justify-content:center;
}

.modifyLink{
	text-decoration : underline;
	color: gray;
	text-decoration-color:gray;
}

.modifyLink:hover{
	color:#196ef7;
}

modifyLink:hover visited{
	color:gray;
}


</style>
<!-- [관리자] 선수 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%"><a href="playerList_p.do" style="color:black;">선수 소개  [포수]</a></h2>
			<p>자이언츠 선수 소개 페이지입니다.</p>
		</div>
	</div>
	<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	
	

	
	
	
	
	
	<div class="aaa">
		 <div class="dropdown">
	        <button class="dropdown-btn"><img src="${pageContext.request.contextPath}/images/아래화살표.png">포수</button>
	        <div class="dropdown-submenu">
	            <a href="player.do">감독</a>
	            <a href="plyaerList_c.do">코치</a>
	            <a href="playerList_t.do" >투수</a>
	            <a href="playerList_p.do" class="over">포수</a>
	            <a href="playerList_w.do">외야수</a>
	            <a href="playerList_n.do">내야수</a>
	   	 </div>
    </div>
	<div>
	<form action="playerList_p.do" id="search_form" method="get"  style="padding-bottom: 24px;">
		<ul class="search align-center">
			<li style="margin: 0px 11px 10px 0;">
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">SELECTED</c:if>>선수명</option>
					<%-- <option value="2" <c:if test="${param.keyfield == 2}">SELECTED</c:if>>선수 포지션</option> --%>
				</select>
			</li>
			<li style="margin: 0px 11px 10px 0;">
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" style="height:30px;" placeholder='선수명을 검색하세요.'>
			</li>
			<li>
				<input type="submit" value="검색" style="height:30px;"  class="accept-btn">
			</li>
		</ul>
		</form> 
		</div>
		<div class="a-tab align-right">
		<ul>
			<li style="margin-top:20%; display:flex;">
				<a href="stadium.do">구장 소개</a>
				<a href="map.do">오시는 길</a>
				<a href="food.do">먹거리</a>
				<a href="player.do" class="over">선수 소개</a>
			</li>
		</ul>
	</div>
	</div>
	
	<!-- 목록 -->
	<c:if test="${count == 0}">
		<div class="result-display">표시할 선수목록이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>선수</th>
				<th>번호</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>포지션</th>
				<th>투타</th>
				<th>경력사항</th>
				<th>입단년도</th>
			</tr> 
			<c:forEach var="player" items="${list}">
				<c:if test="${player.player_position == '포수'}">
					<tr>
						<td class="align-center"><img src="${pageContext.request.contextPath}/introduce/imageView.do?player_num=${player.player_num}"  width="200" height="200"></td>
						<td class="align-center">${player.player_backnumber}</td>
						<td class="align-center">
						<c:if test="${user.mem_auth != 9}">${player.player_name}</c:if>
						<c:if test="${!empty user && user.mem_auth == 9}"><a href="admin_playerModify.do?player_num=${player.player_num}" class="modifyLink">${player.player_name}</a></c:if>
						</td>
						<td class="align-center">${player.player_birthday}</td>
						<td class="align-center">${player.player_position}</td>
						<td class="align-center">${player.player_toway}</td>
						<td class="align-center">${player.player_career}</td>
						<td class="align-center">${player.player_join}</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		
		<div class="align-right" >
			<c:if test="${!empty user && user.mem_auth == 9}">
			<input type="button" value="선수 등록" onclick="location.href='admin_player.do'" class="accept-btn">
			</c:if>
		</div>
		
		
		<!-- 페이지 -->
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- [관리자] 선수 목록 끝 -->