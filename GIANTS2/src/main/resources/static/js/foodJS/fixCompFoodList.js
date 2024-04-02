$(function(){
	//해당 삭품 삭제
	$(document).on('click','.del-food',function(){
		let check = confirm('상품을 삭제 하시겠습니까?');
		if(!check){
			return;
		}
		const num = $(this).attr('data-num');
		let frId = '#del_form_' + num;
		//console.log('폼 네임 확인하기 : ' + frId);
		
		$(frId).submit();
	});
	
	//CSS 스크립트 시작
	$('.compFood-list a').hover(function(){
		//글씨 CSS			//in
		$(this).css({
			"color":"black",
			"font-size": "2.6em",
		});
		//이미지 CSS
		$('.compFood-list a img').css("width","60px");
	},
	function(){				//out
		$(this).css({
			"color":"gray",
			"font-size": "2.5em",
		});
		//이미지 CSS
		$('.compFood-list a img').css("width","58px");
	});
	//CSS 스크립트 끝
});