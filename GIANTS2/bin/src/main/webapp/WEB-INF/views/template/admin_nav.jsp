<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Admin menu S -->
<div class="side-bar">
	<ul>
		<li>
			<input type="button" value="회원관리" onclick="location.href='${pageContext.request.contextPath}/member/admin_list.do'" class="menu-btn">
		</li>
		<li>
			<input type="button" value="상품관리" onclick="location.href='${pageContext.request.contextPath}/item/admin_list.do'" class="menu-btn">
		</li>
		<li>
			<input type="button" value="주문관리" onclick="location.href='${pageContext.request.contextPath}/order/admin_list.do'" class="menu-btn">
		</li>
	</ul>
</div>
<!-- Admin menu E -->
