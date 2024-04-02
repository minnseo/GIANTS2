$(document).ready(function() {

	function toggleSidebar() {
		$(".button").toggleClass("active");
		$("#main_header").toggleClass("move-to-left");
		$("#main_body").toggleClass("move-to-left");
		$("#main_footer").toggleClass("move-to-left");
		$(".sidebar-hr").toggleClass("hr-in");
		$(".sidebar-hr").toggleClass("hr-out");
		$(".sidebar").toggleClass("sidebar-Fin");
		$(".sidebar").toggleClass("sidebar-Fout");
		$(".sideTop").toggleClass("top-on");
		$(".sidebar-item").toggleClass("active");
		$("#sub_item1").attr('class','sidebar-right');
	}

	$(".button").on("click tap", function() {
		toggleSidebar();
	});

	
	//서브 아이템들의 버튼 동작
	$(".sidebar-item").on("click tap", function(){
		$(".sidebar-right").attr('class','sidebar-right hide');
		let subId = "#sub_item" + $(this).attr('id').substr(-1);
		$(subId).attr('class','sidebar-right');
	});

});