<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="mypage-main">
		<div id="main_header">
			<tiles:insertAttribute name="header"/>
		</div>
		<div id="mypage_body">
			<div class="mypage-nav">
				<tiles:insertAttribute name="nav"/>
			</div>
			<div class="mypage-body">
				<tiles:insertAttribute name="body"/>
			</div>
		</div> 
		<div id="main_footer" class="page_clear">
			<tiles:insertAttribute name="footer"/>
		</div>
	</div>
</body>
</html>