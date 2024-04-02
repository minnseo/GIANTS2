<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
     .myChartCss{
     display: block;
     box-sizing: border-box; 
     text-align: center;
     }
     
    .mypage-form-test{
	position: relative; /* Relative positioning */
    width: 1000px;
    box-sizing: border-box;
    overflow: hidden;
}
 </style>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2><a href="${pageContext.request.contextPath}/member/adminMypageSaleManage.do">총 매출</a> / <a href="${pageContext.request.contextPath}/member/adminMypageSaleDetail.do">상세 매출</h2></a>
		<p>자이언츠 총 매출 정보입니다.</p>
	</div>
</div>
<div class="mypage-form-test">
	<!-- 굿즈 판매 원형 차트 사용을 위해 변수 셋팅-->
	<c:set var="order_sale" value=""/>
	<c:set var="title_month" value=""/>
	<c:forEach var="sales" items="${monthList}" varStatus="status">
		<c:if test="${status.index==0}">
			<c:set var="title_month" value="${title_month  += sales.title_month}"/>
		</c:if>
		<c:if test="${status.index!=0}">
			<c:set var="title_month" value="${title_month  += ','}"/>
			<c:set var="title_month" value="${title_month  += sales.title_month}"/>
		</c:if>	
				
		<c:if test="${status.index==0}">
			<c:set var="order_sale" value="${order_sale  += sales.month_sale}"/>
		</c:if>
		<c:if test="${status.index!=0}">
			<c:set var="order_sale" value="${order_sale  += ','}"/>
			<c:set var="order_sale" value="${order_sale  += sales.month_sale}"/>
		</c:if>
	</c:forEach>
	
	
	<div class="align-center">
		<h3>2023년 총 매출</h3>
		<br>
		<em><h1><fmt:formatNumber value="${order_revenue}"/>원</h1></em>
	</div>
	<br>
	<!-- 총 매출 그래프 시작--> 
	<div class="myChartCss">
		<canvas id="myChart"></canvas>
		<script>
		 const ctx = document.getElementById('myChart');
		 var title_month_order = [${title_month}];
		 var month_order_sale = [${order_sale}];
		  new Chart(ctx, {
		    
		    data: {
		      labels: title_month_order, //월
		      
		      datasets: [{
		    	type: 'line',
		        label: '월매출',
		        data: month_order_sale, //월 별 판매량
		        borderWidth: 3, 
		        borderColor: 'rgb(221, 3, 47)',
		      }
		      ,{
		    	  type: 'bar',
			        label: '월매출',
			        data: month_order_sale, //월 별 판매량
			        borderWidth: 3, 
			        backgroundColor : 'rgb(5, 35, 69)',
			        borderColor: 'white',
		      }
		      
		      ]
		    },
		    options:{
                scales: {
   		        y: {
   			          beginAtZero: true
   			        }, 
   			      }, 
   			    plugins:{
                    legend: {
                        display: false
                    },
	            },
   	                
	        }
		  });
		</script>	
	</div>	
	<br>
	
  
</div>
	