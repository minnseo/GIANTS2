$(function(){
	$('#chat').click(function(){
		$.ajax({
			url:'../chat/chatRoomWrite.do',
			type:'post',
			data:{trade_num:$(this).attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 채팅이 가능합니다.');
				}else if(param.result == 'samePerson'){
					alert('본인과의 채팅은 불가합니다.');
				}else if(param.result == 'alredyExist' || param.result == 'success'){ 
					open('../chat/chatting.do?chatroom_num='+param.chatroom_num,'chat','left=460px,toolbar=no,location=no,status=no,menubar=no,resizable=no,scrollbars=no,width=1000,height=1000');
				}else{
					alert('채팅방 생성 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
});