$(function(){
	//별점 정렬
	$(document).on('change','#sort_select',function(){
		myOrderListform($('#orderList_form'));
	});
	
	function myOrderListform(form){
		$(form).submit();
	}
	
});