$(function(){
	
	//메뉴보기 클릭
	$(document).on('click','#showMenu',function(){
		location.href="foodCompDetailMenu.do?comp_num=" + $('#showComp').val();
	});

	//리뷰보기 클릭
	$(document).on('click','#showReview',function(){
		location.href="foodCompDetailReview.do?comp_num=" + $('#showComp').val();
	});
});