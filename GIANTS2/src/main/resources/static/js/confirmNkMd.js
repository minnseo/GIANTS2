$(function(){
	let checkNk = 0;
	
	//닉네임 중복 체크
	$('#confirmNkMd').click(function(){
		if($('#mem_nickname').val().trim()==''){
			$('#message_nk').css('color', 'red').text('닉네임를 입력하세요');
			$('#mem_nickname').val('').focus();
		}
		
		$('#message_nk').text(''); //메시지 초기화
		$.ajax({
			url:'confirmNkMd.do',
			type:'post',
			data:{mem_nickname:$('#mem_nickname').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'nkNotFound'){
					$('#message_nk').css('color','#000').text('등록가능한 닉네임입니다.');
					checkNk = 1;			
				}else if(param.result == 'nkDuplicated'){
					$('#message_nk').css('color','red').text('중복된 닉네임입니다.');
					checkNk = 0;
				}else{
					checkNk = 0;
					alert('NK중복체크 오류');
				}
			},
			error:function(){
				checkNk=0;
				alert('네트워크 오류 발생');
			}
		});
	})//end of click
	
	//닉네임 중복 안내 메시지 초기화 및 닉네임 중복 값 초기화
	$('#member_register #mem_nickname').keydown(function(){
		checkNk = 0;
		$('#message_nk').text('');
	})//end of keydown
	
	//submit 이벤트 발생 시 닉네임 중복 체크 여부 발생
	$('#member_register').submit(function(){
		if(checkNk == 0){
		$('#message_nk').css('color', 'red').text('닉네임 중복 체크 필수');
			if($('#mem_nickname').val().trim()==''){
				$('#mem_nickname').val('').focus();		
			}
			return false;
		}
	})//end of submit
});