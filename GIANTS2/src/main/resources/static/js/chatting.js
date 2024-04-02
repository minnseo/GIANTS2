$(function(){
	let message_socket; //웹소켓 식별자
	/* --------------
	 *  웹소켓 연결
	 * ------------ */
	function alarm_connect(){
		message_socket = new WebSocket("ws://localhost:8000/message-ws.do");
		message_socket.onopen = function(evt){
			//채팅 페이지에 진입할 시 채팅 메시지 발송
			if($('#chatting').length == 1){ //jquery는 모든 태그를 배열로 반환 -> length가 1일 시 index가 하나 존재
				message_socket.send("msg:"); //웹소켓에 msg: 을 보낼 시 selectMsg();가 데이터를 읽어옴
			}
			console.log('채팅 페이지 접속');
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		message_socket.onmessage = function(evt){
			let data = evt.data;
			if($('#chatting').length == 1 && data.substring(0, 4) == 'msg:'){
				selectMsg();
			}
		};
		message_socket.onclose = function(evt){
			//소켓이 종료된 후 부가적인 작업이 있을 경우 명시
			console.log('채팅 종료');
		};
	}
	alarm_connect();

	/*-------------------
			채팅하기	
	--------------------*/
	
	//채팅 데이터 읽기
	function selectMsg(){
		
		//서버와 통신
		$.ajax({
			url:'../chat/chatDetailAjax.do',
			type:'post',
			data:{chatroom_num:$('#chatroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					message_socket.close();
				}else if(param.result == 'success'){
					//메시지 표시 UI 초기화
					$('#chatting_message').empty();
					
					let chat_date = '';
					$(param.list).each(function(index,item){
						let output = '';
						//chat_date는 String타입으로 설정되어있어 날짜,시간이 다 나옴(년월일 시분초)
						//날짜 추출 - 공백을 기준으로 날짜,시간 분리하면 0번 인덱스에 저장됨
						if(chat_date != item.chat_date.split(' ')[0]){
							chat_date = item.chat_date.split(' ')[0];
							output += '<div class="date-position"><span>'+chat_date+'</span></div><br>';
						}
						
						//일반 메시지
						if (item.mem_num == param.user_num) { //내가 보낸 메시지
							output += '<div class="from-position"><div class="space-message">' + item.mem_id; //** 닉네임 있을 시 닉네임 보이게끔 처리하기
							output += '<div id="read_cnt">' +  item.read_count + '</div>'
						} else { //다른 사람이 보낸 메시지
							output += '<div class="to-position">';
							output += '<div class="space-photo">';
							output += '<img src="../member/viewProfile.do?mem_num=' + item.mem_num + '" width="40" height="40" class="my-photo">';
							output += '</div><div class="space-message">';
							output += item.mem_id; //** 닉네임 있을 시 닉네임 보이게끔 처리하기
						}
						//공통
						output += '<div class="item" id="msg">';
						output += ' <span>' + item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') + '</span>';
						output += '</div>';
						//시간 추출 - 공백을 기준으로 날짜,시간 분리하면 1번 인덱스에 저장됨
						output += '<div class="chat_date">' + item.chat_date.split(' ')[1] + '</div><br>';
						output += '</div>';
						output += '</div><div class="space-clear"></div>';
						
						//문서 객체 추가
						$('#chatting_message').append(output);
						//스크롤을 하단에 위치시킴
						$('#chatting_message').scrollTop($('#chatting_message')[0].scrollHeight);
					});
				}else{
					alert('채팅 메시지 읽기 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
				
	}
	
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
		//enter(13) 클릭 시 전송, shift+enter 클릭 시 줄바꿈
		if(event.keyCode == 13 && !event.shiftKey){
			$('#detail_form').trigger('submit');
		}
	});
	
	//채팅 등록
	$('#detail_form').submit(function(event){
		if($('#message').val().trim() == ''){
			alert('메시지를 입력하세요!');
			$('#message').val('').focus();
			return false;
		}
		if($('#message').val().length > 1333){
			alert('메시지는 1333까지만 입력 가능합니다.');
			return false;
		}
		
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'../chat/writeChat.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
					message_socket.close();
				}else if(param.result == 'success'){
					//폼 초기화
					$('#message').val('').focus();
					//메시지가 저장되었다고 소켓에 신호를 보냄
					message_socket.send('msg:');
				}else{
					alert('채팅 등록 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
		
		//ajax통신을 위해 기본 이벤트 제거
		event.preventDefault();
	});	
	
	/*-------------------
		채팅방 나가기
	--------------------*/
	/*
	$('#delete_chatroom').click(function(){
		let choice = confirm('채팅방을 퇴장하시겠습니까?');
		if(!choice){
			return;
		}
		
		//서버와 통신
		$.ajax({
			url:'../chat/deleteChatRoomMemberAjax.do',
			type:'post',
			data:{chatroom_num:$('#chatroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 사용할 수 있습니다.');
				} else if(param.result == 'success'){
					alert('채팅방 퇴장 완료');
					location.href='../chat/chatList.do';
				} else{
					alert('채팅방 퇴장 처리 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});	
	*/		
});