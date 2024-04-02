<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<!-- googleChart.js -->
<!-- 굿즈 카테고리 별 매출 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
.category-sales{
text-align : center;
     position : relative;
     left : 900px;
     bottom: 1020px;
}
     
    .mypage-form{
    	margin-left: 50px;
    }
#salesTable{
	text-align: center;
}
     
 </style>
<body>
<div class="page-main">
  	<!-- 굿즈 상세 매출 테이블 -->
	<div class="goods_sale_quantity">
		<div class="mypage-top2">
			<div class="mypage-top-title">
				<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
				<h2>굿즈 상세 매출</h2>
				<span>매출액 순</span>
			</div>
		</div>
		<div class="mypage-form">
	    <table class="striped-table" id="salesTable">
			<tr>
				<th>판매순위</th>
				<th>상품명</th>
				<th>상품사진</th>
				<th>매출</th>     
			</tr>
			<!-- Controller에서 가공해서 받아와도 됨. (나중에 해보기) -->
			<!-- 배열 형태로 인식하기 위해서 문자열인 경우 따옴표를 붙여준다. varStatus로 index를 불러와 조건 체크 -->
			<c:set var="goods_name" value=""/>
			<c:set var="goods_quanitity" value=""/>
			<c:forEach var="order" items="${list}" varStatus="status">
			
				<c:if test="${status.index==0}">
					<c:set var="goods_name" value="${goods_name  += '\"'}"/>
					<c:set var="goods_name" value="${goods_name  += order.goods_name}"/>
					<c:set var="goods_name" value="${goods_name  += '\"'}"/>
				</c:if>
				<c:if test="${status.index!=0}">
					<c:set var="goods_name" value="${goods_name  += ','}"/>
					<c:set var="goods_name" value="${goods_name  += '\"'}"/>
					<c:set var="goods_name" value="${goods_name  += order.goods_name}"/>
					<c:set var="goods_name" value="${goods_name  += '\"'}"/>
				</c:if>
				<c:if test="${status.index==0}">
					<c:set var="goods_quanitity" value="${goods_quanitity  += order.order_quantity}"/>
				</c:if>
				<c:if test="${status.index!=0}">
					<c:set var="goods_quanitity" value="${goods_quanitity  += ','}"/>
					<c:set var="goods_quanitity" value="${goods_quanitity  += order.order_quantity}"/>
				</c:if>
			<!-- 테이블 내용 시작 -->
			<tr>
				<td>
					${order.sales_rank}
				</td>
				<td>
				<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${order.goods_num}">
				${order.goods_name}
				</a>
				</td>
				<td>
					<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${order.goods_num}" width="80" height="80">
				</td>
				<td>
					<fmt:formatNumber value="${order.total_sales}"/>원
					 
				</td>
			</tr>
			</c:forEach>
		</table>
		</div>
	</div>
		<!-- 차트에 넘겨주기 위해 카테고리 판매량 셋팅 -->
	<c:set var="category_count" value=""/>
	<c:forEach var="category" items="${categoryList}" varStatus="status">
		<c:if test="${status.index==0}">
			<c:set var="category_count" value="${category_count  += category.count_category}"/>
		</c:if>
		<c:if test="${status.index!=0}">
			<c:set var="category_count" value="${category_count  += ','}"/>
			<c:set var="category_count" value="${category_count  += category.count_category}"/>
		</c:if>	
	</c:forEach>
<div class="category-sales">
	<div class="polarArea-Chart" id="polarArea-Chart" style="max-width:500px">
	<span>카테고리 별 통계</span>
	  <canvas id="polarAreaChart"></canvas>
	</div>
</div>

<!-- polar차트 -->
<script type="text/javascript">
const polarCtx = document.getElementById("polarAreaChart").getContext('2d');
var category_count_list = [${category_count}]; //배열 형태로 넣어준다
const polarAreaChart = new Chart(polarCtx, {
	type : 'polarArea',
	data : {
		labels : ["유니폼", "모자", "응원도구", "기타"],
		datasets : [{
			data : category_count_list,
			backgroundColor : [
				'rgba(5, 35, 69)',
				'rgba(139, 214, 165)', 
				'rgba(221, 3, 47)',
				'rgba(252, 204, 241)'
				
			],
			borderAlign: 'inner' // 다각형 차트로 설정
		}]
	},
	options : {
		circular : false, 
		scales : {
			r:{
				startAngle : -30,
				grid : {
					circular : false,
				}
			}
		}
	,
		plugins : {
			title : {
				display : true,
				text : '카테고리 별 수익'
			}
		}
	}
});

</script>

	
</div>
	
</body>
</html>