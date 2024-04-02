$(function(){
	let form = $('#foodList_sort');
	
	//상단 카테고리 초기화
	let cboxes = $('.food-cbox');
	for(let i=0; i<cboxes.length; i++){
		if($('#comp_cate').val()==(i+1)){
			$(cboxes[i]).attr('class','food-cbox food-cbox-on');
		}
	}
	
	//상단 카테고리 작동 시작
	$(document).on('click','.food-cbox',function(){
		$('.food-cbox').attr('class','food-cbox');
		$(this).attr('class','food-cbox food-cbox-on');
		$('#comp_cate').val($(this).attr('data-comp_cate'))
		categoryListform(form);
	});
	//상단 카테고리 작동 끝
	
	function categoryListform(form){
		$(form).submit();
	}
});