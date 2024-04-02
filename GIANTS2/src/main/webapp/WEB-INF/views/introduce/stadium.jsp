<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
<style>
.intoduce-title p{
	display: inline-block;
    font-size: 13px;
}
.title01{
	display:flex;
}


.title02{
    font-size: 50px;
    color: #333;
    font-weight: 900;
    line-height: 100%;
    letter-spacing: -1px;
    text-transform: uppercase;
    margin-right: 44%;
    margin-bottom:3%;
}

.title02 span {
	margin-top: 8%;
    font-size: 24px;
    display: block;
}

.title02-1 {
	display:flex;
	margin-top: 2%;
}

.title03 {
	display:flex;
}

dd {
	margin-top:12%;
}

dt {
	margin-top:25%;
}

/*  
dl {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
*/

.sazik {
    height: 400px;
    float:right;
    margin-bottom:6%;
}
#photo1{
	margin-left:20%;
}

hr{
	margin-top:1%;
}

.gap{
	display:flex;
}

.a-tab ul li a.over {
    position: relative;
    background: #dd0330;
    border-color: #dd0330;
    color: #fff;
    text-decoration: underline;
}
.a-tab ul li a {
    display: block;
    height: 34px;
    line-height: 34px;
    font-size: 14px;
    letter-spacing: -1px;
    padding: 0 21px;
    font-weight: bold;
    text-decoration: none;
    border: solid #ccc;
    border-width: 1px;
    color: #767676;
}

.a-tab ul li a {
    display: block;
    height: 34px;
    line-height: 34px;
    font-size: 14px;
    letter-spacing: -1px;
    padding: 0 21px;
    font-weight: bold;
    text-decoration: none;
    border: solid #ccc;
    border-width: 1px;
    color: #767676;
}

.a-tab{
	display:flex;
    margin-left: 0%;
    margin-bottom: 4%;
    margin-top: -3%;
}


</style>  
 
<div class="page-main">
    <div class="introduce-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">소개</h2>
			<p>자이언츠의 사직구장 소개입니다.</p>
		</div>
		<hr size="0.05" width="100%" noshade>
	</div>
	
	
	
	<div class="title02-1">
	<p class="title02">
		<span>모두가 함께 즐기는</span>
		사직 야구장
	</p>
	<div class="a-tab align-right">
		<ul>
			<li style="margin-top:20%; display:flex;">
				<a href="stadium.do" class="over">구장 소개</a>
				<a href="map.do">오시는 길</a>
				<a href="food.do">먹거리</a>
				<a href="player.do">선수 소개</a>
			</li>
		</ul>
	</div>
	</div>
	<div class="gap">
		<div class="title03" style="width:100%">
			<dl>
				<dt>위치</dt>
				<dd>부산광역시 동래구 사직로 45 종합운동장</dd>
				<hr size="0.03" width="140%" color="#ccd3de" noshade>
				<dt>면적</dt>
				<dd>총 면적 : 50.301㎡</dd>
				<hr size="0.03" width="140%" color="#ccd3de" noshade>
				<dt>시설</dt>
				<dd>관람석 22,990석</dd>
				<hr size="0.03" width="140%" color="#ccd3de" noshade>
			</dl>
		</div>
		<div style="margin-bottom:5%;">
			<img src="${pageContext.request.contextPath}/images/사직야구장.png" class="sazik" width="700" height="700">
			<span style="font-size : 106%;">
			대한민국 부산광역시 동래구 사직동에 있는 야구장으로 1985년 10월에 완공되었으며 23,646석의 관람석이 있다.<br>
			구장 크기는 좌·우 펜스까지 95㎡, 중앙 펜스까지 118㎡이고, 펜스 높이가 펜스 상단 철망을 포함해서 4.8㎡다.<br>
			외형은 일본 요코하마 스타디움과 비슷하다.<br><br>
			본래는 야구는 물론 축구나 럭비 등 다양한 종목의 경기가 함께 열릴 수 있는 다용도 종합경기장으로 지어졌다.<br>
			그래서 내야 관중석은 가변식이었으나, 지금은 야구 경기만 치르고 있어 내야석을 이동할 일은 없다.
			</span>
		</div>	
	</div>
	</div>
	