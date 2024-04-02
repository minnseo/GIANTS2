$(function(){
	$('#member_login').submit(function(){
		if($('#mem_id').val().trim()==''){
			alert('아이디를 입력하세요.');
			$('#mem_id').val('').focus();
			return false;
		}
		if($('#passwd').val().trim()==''){
			alert('비밀번호를 입력하세요.');
			$('#passwd').val('').focus();
			return false;
		}
	})
});