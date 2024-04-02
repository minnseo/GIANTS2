<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<!-- 일반회원일때 NAV -->
	<c:if test="${!empty user && user.mem_auth == 2}">
		<ul>
			<li class="nav-title"><b>회원정보</b></li>
			<li><a href="${pageContext.request.contextPath}/member/updateMember.do">회원정보수정</a></li>
			<li><a href="${pageContext.request.contextPath}/member/changePasswd.do">비밀번호변경</a></li>
			<li><a href="${pageContext.request.contextPath}/member/changeNkMd.do">닉네임변경</a></li>
			<li><a href="${pageContext.request.contextPath}/member/deleteMember.do">회원탈퇴</a></li>
			<li><b>구매내역</b></li>
			<li><a href="${pageContext.request.contextPath}/member/memberMypageTicketList.do">Ticket</a></li>
			<li><a href="${pageContext.request.contextPath}/member/memberMypageFoodList.do">Foods</a></li>
			<li><a href="${pageContext.request.contextPath}/gorder/orderList.do">Goods</a></li>
			<li><b>관심목록</b></li>
			<li><a href="${pageContext.request.contextPath}/member/bookmarkList.do">중고거래</a></li>
			<li><a href="${pageContext.request.contextPath}/member/goodsFavList.do">찜한 굿즈</a></li>
		</ul>
	</c:if>
	<!-- 기업회원일때 NAV -->   
	<c:if test="${!empty user && user.mem_auth == 3}">
		<ul>
			<li class="nav-title"><b>회원정보</b></li>
			<li class="nav_item"><a href="${pageContext.request.contextPath}/member/updateCompany.do">회원정보수정</a></li>
			<li><a href="${pageContext.request.contextPath}/member/changePasswd.do">비밀번호변경</a></li>
			<li><a href="${pageContext.request.contextPath}/member/deleteCompany.do">회원탈퇴</a></li>
			<li><b>FOOD</b></li>
			<li><a href="${pageContext.request.contextPath}/member/compMypageFoodList.do">푸드목록</a></li>
			<li><a href="${pageContext.request.contextPath}/member/compMypageOrderList.do">주문내역</a></li>
		</ul>
	</c:if>
	<!-- 관리자일때 NAV -->
	<c:if test="${!empty user && user.mem_auth == 9}">
		<ul class="mypage-nav">
			<li><b>관리</b></li>
			<li><a href="${pageContext.request.contextPath}/member/admin_list.do">회원목록</a></li>
			<li><a href="${pageContext.request.contextPath}/ticket/gradeList.do">좌석관리</a></li>
			<li><a href="${pageContext.request.contextPath}/member/adminMypageTicket.do">티켓관리</a></li>
			<li><a href="${pageContext.request.contextPath}/member/adminMypageGoodsList.do">굿즈목록</a></li>
			<li><a href="${pageContext.request.contextPath}/member/adminMypageGoodsOrderList.do">굿즈주문내역</a></li>
			<li><a href="${pageContext.request.contextPath}/member/adminMypageSaleManage.do">매출관리</a></li>
		</ul>
	</c:if>
</div>