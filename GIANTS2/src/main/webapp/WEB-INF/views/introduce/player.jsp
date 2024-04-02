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
.roster-img{
	position: relative;
    float: left;
    width: 570px;
    height: 604px;
    background: none;
}

.roster-txt{
	float: left;
    width: 390px;
    padding-left: 0;
    padding-top: 60px;
    position: relative;
}

img{
    border: 0px;
    vertical-align: middle;
}

.director{
	overflow:hidden;
    margin-top: -5%;
}


.pos{
	font-size: 24px;
    font-weight: bold;
    color: black;
}

.name{
	font-size: 54px;
    font-weight: bold;
    color: #fff;
    line-height: 100%;
    padding-top: 15px;
    margin-bottom: 35px;
}

.nb{
    display: inline-block;
    width: 90px;
    height: 60px;
    vertical-align: top;
    line-height: 100%;
    font-size: 50px;
    font-weight: bold;
    background: url(/html/_Img/stat/nb_bg_new.png) no-repeat left 3px;
    color: #fff;
    text-align: center;
    overflow: hidden;
    margin-left: 15px;
    padding-top: 2px;
    height: 52px;
    margin-top: 5px;
    background: #dd0330;
    border-radius: 10px;
    padding-top: 0;
}

dt{
    display: block;
    float: left;
    width: 80px;
    color: black;
    margin: 5px 0px;
    font-weight: bold;
}

dd{
    display: block;
    float: left;
    width: 305px;
    border-left: none;
    /* font-size: 12px; */
    padding-left: 5px;
    margin: 5px 0px;
    color: black;
}

strong{
	color: black;
}

.ename{
	margin-bottom:5%;
}


/*  
.bbb{
	background:#ffffff url(/_Img/Board/roster/roster_view_bg_01.jpg) no-repeat center top;
	height:800px;
}

*/



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
			<h2 style="margin-right:5%"><a href="player.do" style="color:black;">선수 소개  [감독]</a></h2>
			<p>자이언츠 선수 소개 페이지입니다.</p>
		</div>
	</div>
	<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	
	
	
		
	<div class="aaa">
		 <div class="dropdown">
	        <button class="dropdown-btn pos"><img src="${pageContext.request.contextPath}/images/아래화살표.png">감독</button>
	        <div class="dropdown-submenu">
	            <a href="player.do" class="over">감독</a>
	            <a href="playerList_c.do">코치</a>
	            <a href="playerList_t.do" >투수</a>
	            <a href="playerList_p.do">포수</a>
	            <a href="playerList_w.do">외야수</a>
	            <a href="playerList_n.do">내야수</a>
	   	 </div>
		</div>
		
		<div class="a-tab align-right" style="margin-left:38%;">
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
	

	<div class=bbb>
	<div class="director">
	<c:forEach var="player" items="${list}">
	<c:if test="${player.player_position == '감독'}">
		<div class="roster-img">
		<img src="${pageContext.request.contextPath}/introduce/imageView.do?player_num=${player.player_num}">
		</div>	
		<div class="roster-txt">
			<p class="pos">${player.player_position}</p>
			<p class="name">
				<strong>
					<c:if test="${user.mem_auth != 9}">${player.player_name}</c:if>
					<c:if test="${!empty user && user.mem_auth == 9}"><a href="admin_playerModify.do?player_num=${player.player_num}" style="color:black;">${player.player_name}</a></c:if>
				<span class="nb">${player.player_backnumber}</span>
				</strong>
			</p>
			<p class="ename">LARRY JAMES SUTTON</p>
			<hr size="0.03" width="140%" noshade>
			<dl >
				<dt>생년월일</dt>
				<dd>${player.player_birthday}</dd>
				<dt>입단년도</dt>
				<dd>${player.player_join}</dd>
				<dt>학력사항</dt>
				<dd>
				Mater Dei High School (캘리포니아, 미국)<br>
				University of Illinois (일리노이, 미국)
				</dd>
				<dt>선수경력사항</dt>
				<dd>
				(1992) 캔자스시티 로얄스 지명<br>
				(1992-1999) 캔자스시티 로얄스<br>
				(2000-2001) 세인트루이스 카디널스<br>
				(2002) 오클랜드 어슬레틱스<br>
				(2004) 플로리다 말린스<br>
				(2005-2006) 현대 유니콘스<br>
				(2007) 기아 타이거즈
				</dd>
				<dt>코치경력사항</dt>
				<dd>${player.player_career}</dd>
			</dl>
		</div>			
	</c:if>
	</c:forEach>			
	</div>
	</div>
	
		
		
		<div class="align-right" >
			<c:if test="${!empty user && user.mem_auth == 9}">
			<input type="button" value="선수 등록" onclick="location.href='admin_player.do'" class="accept-btn">
			</c:if>
		</div>
		
		
		
	
</div>
<!-- [관리자] 선수 목록 끝 -->