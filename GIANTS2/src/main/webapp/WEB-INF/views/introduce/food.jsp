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
    margin-right: 53%;
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
	margin-top:7%;
}

dt {
	margin-top:17%;
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
	margin-left:67%;
	margin-bottom:2%;
	
}
</style>  
 
<div class="page-main">
    <div class="introduce-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">먹거리</h2>
			<p>사직구장의 먹거리 소개입니다.</p>
		</div>
		<hr size="0.05" width="100%" noshade>
	</div>
	
	
	
	<div class="title02-1">
	
	<div class="a-tab align-right">
		<ul>
			<li style="margin-top:20%; display:flex;">
				<a href="stadium.do" >구장 소개</a>
				<a href="map.do">오시는 길</a>
				<a href="food.do" class="over">먹거리</a>
				<a href="player.do">선수 소개</a>
			</li>
		</ul>
	</div>
	</div>

	<div class="align-center">
		<img src="${pageContext.request.contextPath}/images/먹거리.png">
	</div>


</div>
	