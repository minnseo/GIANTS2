$(function(){
	
	//메뉴보기 클릭
	$(document).on('click','#showMenu',function(){
		location.href="foodCompDetailMenu.do?comp_num=" + $('#showComp').val();
	});

	//리뷰보기 클릭
	$(document).on('click','#showReview',function(){
		location.href="foodCompDetailReview.do?comp_num=" + $('#showComp').val();
	});
	
	//식품 클릭시
	$(document).on('click','.food-info',function(){
		let classes = $(this).attr('class').length;
		if(classes == 10){
			return;
		}
		$('#food_number').val($(this).attr('data-food_num'));
		$('#frm_foodDetail').submit();
	});
	
});