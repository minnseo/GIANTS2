
$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	
	//댓글 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		$.ajax({
			url:'listReply.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,commu_num:$('#commu_num').val()},
			dataType:'json',
			success:function(param){
				$('#loading').hide(); //로딩 이미지 감추기
				count = param.count;
				//처음 호출 시는 해당 ID의 div의 내부 내용을 제거
				if(pageNum == 1){
					$('#output').empty();
				}
				//댓글 수 읽어오기
				displayReplyCount(param);
				
				//[댓글 목록] - 배열 형태이므로 each메서드 사용
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					
					output += '<ul class="detail-info">';
					/*-----프로필사진-----*/
					output += '<li>';
					output += '<img src="../member/viewProfile.do?mem_num='+item.mem_num+
								'" width="40" height="40" class="my-photo">';
					output += '</li>';
					/*-----닉네임(or아이디),수정일(or등록일)-----*/
					output += '<li>';
					//닉네임 있으면 닉네임이, 없으면 아이디가 보이게 설정
					if(item.nick_name){
						output += item.mem_nickname + '<br>';
					}else{
						output += item.mem_id + '<br>';
					}
					//수정했으면 수정일이, 안 했으면 등록일이 보이게 설정
					if(item.re_mdate){
						output += '<span class="modify-date">최근 수정일 : ' + item.re_mdate + '</span>';
					}else{
						output += '<span class="modify-date">등록일 : ' + item.re_date + '</span>';
					}
					output += '</li>';
					output += '</ul>';
					
					output += '<div class="sub-item">';
					//replace(/검색단어/g, 대체단어) : 검색 단어가 들어간 모든 걸 찾아 대체 단어로 바꿔줌.
					//content에 html을 불허하도록 설정해놨기 때문에, 줄바꿈만 허용하기 위해 \r\n을 <br>로 교체.
					output += '<p>' + item.re_content.replace(/\r\n/g,'<br>') + '</p>';
					//로그인 회원 번호 = 작성자 회원 번호 일치 시 (작성자 본인일 시) 수정,삭제 가능
					if(param.user_num == item.mem_num){
						output += ' <input type="button" data-num="'+item.re_num+'" value="수정" class="modify-btn accept-btn">';
						output += ' <input type="button" data-num="'+item.re_num+'" value="삭제" class="delete-btn accept-btn">';
					}
					output += '<hr size="1" noshade>'; 
					output += '</div>'; //end of sub-item
					
					output += '</div>'; //end of item
					
					//문서 객체 추가
					$('#output').append(output);
				});
				
				//[paging button] 처리
				if(currentPage >= Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음 페이지가 있음
					$('.paging-button').show();
				}
			},
			error:function(){
				$('#loading').hide(); //로딩 이미지 감추기
				alert('네트워크 오류 발생');
			}
		});
	}
	
	
	//다음 댓글 보기 버튼 클릭 시 데이터 추가
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	
	
	//댓글 등록 (기본이벤트 제거를 위해 event를 인자로 받음)
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim() == ''){
			alert('내용을 입력하세요!');
			$('#re_content').val('').focus();
			return false;
		}
		//입력한 정보 읽기
		//.serialize()를 통해 form에 기입된 데이터를 한 번에 가져옴
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'writeReply.do',
			
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//새로 삽입한 글을 포함해서 첫번째 페이지의 게시글을 다시 호출
					selectList(1);
				}else{
					alert('댓글 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
	}); //end of submit
	
	
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}
	
	
	

	
	//댓글 수정 폼 호출
	//미래 태그이므로 다음과 같이 표기
	$(document).on('click','.modify-btn',function(){
		//댓글 번호
		let re_num = $(this).attr('data-num');
		//댓글 내용
		//replace(/검색단어/gi, 대체단어) : 검색 단어가 들어간 모든 걸 대소문자 구분 없이 찾아 대체 단어로 바꿔줌.
		let content = $(this).parent().find('p').html().replace(/<br>/gi,'\r\n');
		
		//댓글 수정 폼 UI
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="re_num" id="mre_num" value="'+re_num+'">';
		modifyUI += '<textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content">'
					+content+'</textarea>';
		modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span></div>';
		modifyUI += '<div id="mre_second" class="align-right">';
		modifyUI += ' <input type="submit" value="수정" class="modify-btn accept-btn">';
		modifyUI += ' <input type="button" value="취소" class="re-reset accept-btn">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';
		
		//이전에 이미 수정하던 댓글이 있는데 다른 댓글의 수정 버튼을 클릭하면
		//기존 수정하던 폼은 사라지고 등록되어있는 댓글 정보(sub-item)를 다시 보여줌
		initModifyForm();
		
		//지금 클릭해서 수정하고자 하는 데이터는 감추기 (수정 버튼을 감싸고 있는 div)
		//parent() : 직계 부모
		$(this).parent().hide();
		
		//수정 폼을 수정하고자 하는 데이터가 있는 div에 노출
		//parents() : 부모들 중에서 검색
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 세팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);
	});
	
	
	//수정 폼에서 취소 버튼 클릭 시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	
	//댓글 수정 폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	
	
	
	
	
	
	//textarea에 내용 입력 시 글자 수 체크
	//미래 태그이므로 다음과 같이 표기
	$(document).on('keyup','textarea',function(){
		let inputLength = $(this).val().length; //입력한 글자 수 구하기
		if(inputLength > 300){ //300자 초과 입력 시
			$(this).val($(this).val().substring(0,300));
		}else{ //300자 이하 입력 시
			//남은 글자 수 구하기
			let remain = 300 - inputLength;
			remain += '/300';
			//글자 수 변경
			if($(this).attr('id') == 're_content'){ //등록 폼
				$('#re_first .letter-count').text(remain);
			}else{ //수정 폼
				$('#mre_first .letter-count').text(remain);
			}
		}
	});
	
	
	
	
	
	
	
	
	
	
	
	//댓글 수정
	$(document).on('submit','#mre_form',function(event){
		if($('#mre_content').val().trim() == ''){
			alert('내용을 입력하세요');
			$('#mre_content').val('').focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'updateReply.do',
			type:'post',
			data:form_data,
			dataType:'json',  
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result == 'success'){
					//수정 내용 처리
					$('#mre_form').parent().find('p').html($('#mre_content').val()
																			.replace(/</g,'&lt;')
																			.replace(/>/g,'&gt;')
																			.replace(/\r\n/g,'<br>')
																			.replace(/\r/g,'<br>')
																			.replace(/\n/g,'<br>'));
					//최근 수정일 처리
					$('#mre_form').parent().find('.modify-date').text('최근 수정일 : 5초미만');
					//수정폼 초기화
					initModifyForm();														
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('댓글 수정 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
	
	//댓글 삭제
	//미래 태그이므로 다음과 같이 표기
	$(document).on('click','.delete-btn',function(){
		//댓글 번호
		let re_num = $(this).attr('data-num');
		//서버와 통신
		$.ajax({
			url:'deleteReply.do',
			type:'post',
			data:{re_num:re_num},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('삭제가 완료되었습니다.');
					selectList(1); //목록 갱신
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글은 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	
	//댓글 수 표시
	function displayReplyCount(data){
		let count = data.count;
		let output;
		if(count == 0){
			output = '댓글 수(0)';
		}else{
			output = '댓글 수('+count+')';
		}
		//문서 객체에 추가
		$('#output_rcount').text(output);
	}
	
	
	//초기 데이터(목록) 호출
	selectList(1);
	
});