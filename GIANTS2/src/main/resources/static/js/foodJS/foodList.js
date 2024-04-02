$(function(){
	//별점 정렬
	$(document).on('change','#sort_select',function(){
		categoryListform($('#foodList_sort'));
	});
	
	//매장 상세정보 폼 호출
	$(function(){
		$(document).on('click','.f-list',function(){
			let comp_form = $(this).find('form');
			comp_form.submit();
		});
	});
	
	function categoryListform(form){
		$(form).submit();
	}
	
});