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
    margin-right: 60%;
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
	margin-left:64%;
	margin-bottom:2%;
	
}
.map{
    width: 123%;
    border-top: #dd0330 2px solid;
    border-collapse: collapse;
    border-spacing: 0px;
}


ul, ol, li {
    list-style: none;
    margin: 10px;
    padding: 0px;
}



</style>  
 
 
 
<div class="page-main">
    <div class="introduce-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">오시는 길</h2>
			<p>사직구장 오시는 길입니다.</p>
		</div>
		<hr size="0.05" width="100%" noshade>
	</div>
	
	
	<!--  <h1><img src="${pageContext.request.contextPath}/images/Giantlogo.png" width="200" height="200"></h1>-->
 <div class="a-tab align-right">
		<ul>
			<li style="margin-top:33%; display:flex;">
				<a href="stadium.do">구장 소개</a>
				<a href="map.do" class="over">오시는 길</a>
				<a href="food.do">먹거리</a>
				<a href="player.do">선수 소개</a>
			</li>
		</ul>
	</div>
	
	
	<div class="gap">
		<div class="title03" style="width:60%">
			<dl>
				<dt>주소</dt>
				<dd>부산광역시 동래구 사직로 45 종합운동장</dd>
				<hr size="0.03" width="130%" color="#ccd3de"  noshade>
				<dt>티켓예매</dt>
				<dd>051-852-1982</dd>
				<hr size="0.03" width="130%" color="#ccd3de" noshade>
				<dt>전화번호</dt>
				<dd>051-590-9000</dd>
				<hr size="0.03" width="130%" color="#ccd3de" noshade>
			</dl>
		</div>
		<table class="map">
			<tbody>
				<tr>
					<th scope="row" class="bus">버스</th>
					<td>
						<ul>
							<li>
								<strong>* 버스 :</strong>
								 10, 44, 50, 57, 80, 111, 131, 189, 1002(심야)
							</li>
							<li>
								<strong>* 마을버스 :</strong>
								 17
							</li>
						</ul>
					</td>
				</tr>
				
				
				<tr>
					<th scope="row" class="subway">지하철</th>
					<td>
						<ul>
							<li>
								<strong>* 사직역 :</strong>
								 부산 3호선 사직역 1번 출구로 나와 아시아드대로를 따라 앞쪽으로 약 125m 직진합니다.<br>
								 이동 후 삼거리가 나오는데 우측에 있는 사직로로 방향을 틀어 자이언츠파크 앞 횡단보도까지 약 386m 직진합니다.<br>
								 횡단보도를 건넌 후 우측방향으로 약 50m 직진하면 좌측에 부산사직종합운동장 입구가 있습니다.<br>
							</li>
							<li>
								<strong>* 종합운동장역 :</strong>
								 부산 3호선 종합운동장역(빅토리움) 11번 출구로 나와 아시아드대로를 따라 앞쪽으로 약 395m 직진합니다.<br>
								 이동 후 종합운동장 사거리가 나오는데 좌측으로 방향을 틀어 세계로병원 앞 횡단보도까지 약 174m 직진합니다.<br>
								 횡단보도를 건넌 후 우측방향으로 약 168m 직진하면 삼거리가 나옵니다.<br>
								 삼거리에서 좌측방향으로 틀어 약 217m 직진하면 좌측에 부산사직종합운동장 입구가 있습니다.<br>
							</li>
						</ul>
					</td>
				</tr>
				
				
				
				<tr>
					<th scope="row" class="car">자가용</th>
					<td>
						<ul>
							<li>
								<strong>* 경부고속도로 이용시 :</strong>
								경부고속도로 - 구서I.C - 송월타올삼거리(우회전) - 사직야구장
							</li>
							<li>
								<strong>*  남해고속도로 이용시 :</strong>
								 남해고속도로 - 북부산진입 - 제2낙동교 - 만덕터널 - 반도보라아파트 - 사직야구장
							</li>
							<li>
								<strong>*  공항 이용시 :</strong>
								 구포대교방향 - 만덕터널 - 반도보라아파트 - 사직야구장(사직운동장)
							</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>	
	</div>
	</div>
	