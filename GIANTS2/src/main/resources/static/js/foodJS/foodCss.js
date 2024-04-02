$(document).ready(function() {
	
	/*	===========================
			fixCompFoodList 시작
		=========================== */
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
	/*	===========================
			fixCompFoodList 끝
		=========================== */
});
