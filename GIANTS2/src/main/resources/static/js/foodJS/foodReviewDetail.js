$(function(){
	
	//삭제하기 버튼
	$(document).on('click','#delete_review',function(){
		let review_num = $('#review_num').val();
		let check = confirm('정말 리뷰를 삭제하시겠습니까?');
		
		if(check){
			$.ajax({
				url:'../food/foodReviewDelete.do',
				type:'post',
				data:{review_num:review_num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인이 필요한 기능입니다.');
					}else if(param.result == 'success'){
						alert('삭제완료\n목록으로 돌아갑니다.');
						location.href="/food/foodCompDetailReview.do?comp_num="+$('#comp_num').val();
					}else if(param.result == 'MisMatchUser'){
						alert('잘못된 요청');
					}else{
						alert('리뷰삭제 오류 발생');
					}
				},
				error:function(){
					alert('리뷰삭제 - 네트워크 오류 발생');
				}
			});// end of ajax
		}else{
			alert('삭제를 취소하셧습니다.');
		}
	});

});













