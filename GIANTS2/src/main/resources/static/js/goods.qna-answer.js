$(function(){
	let rowCount = 5;
	let currentPage;
	let count;
	
	//답변 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		
		//서버와 통신
		$.ajax({
			url:'listAnswer.do',
			type:'post',
			data:{pageNum:pageNum, rowCount:rowCount, qna_num:$('#qna_num').val()},
			dataType:'json',
			success:function(param){
				$('#loading').hide(); //로딩이미지 감추기
				
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시에는 div 내부 내용물 제거
					$('#output').empty();
				}
				
				displayReplyCount(param); //댓글 수 읽어오기
				
				//답변 목록
				$(param.list).each(function(index, item){
					let output = '<div class="item">';
					output += '<ul class="detail-info">';
					output += '<li><b>[관리자]</b> ' + item.mem_id + '  ';
					
					if(item.gans_mdate){
						output += '<span class="modify-date align-right"> | ' + item.gans_mdate + ' 수정</span>';
					} else{
						output += '<span class="modify-date align-right"> | ' + item.gans_regdate + ' 등록</span>';
					}
					output += '</li>';
					output += '</ul>';
					output += '<div class="sub-item">';
					output += '<p>' + item.gans_content.replace(/\r\n/g, '<br>') + '</p>';
					
					if(param.user_num == item.mem_num){
						output += '<div class="ans-btns align-right">';
						output += ' <input type="button" data-num="' + item.gans_num + '"value="수정" class="modify-btn">';
						output += ' <input type="button" data-num="' + item.gans_num + '"value="삭제" class="delete-btn">';
						output += '</div>';
					}
					output += '<hr size="1" noshade>';
					output += '</div>'; //end of sub-item
					output += '</div>'; //end of item
					
					//문서 객체 추가
					$('#output').append(output);
				}); //end of list each
				
				//paging button 처리
				if(currentPage >= Math.ceil(count / rowCount)){
					//다음 페이지 없음
					$('.paging-button').hide();
				}else{
					$('.paging-button').show();
				}
			},
			error:function(){
				$('#loading').hide(); //로딩이미지 감추기
				
				alert('네트워크 오류 발생');
			}			
		}); //end of ajax
	} //end of selectList
	
	//더보기 버튼 클릭시 데이터 추가
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	}); //end of paging-button click
	
	//답변 등록
	$('#gans_form').submit(function(event){
		if($('#gans_content').val().trim() == ''){
			alert('내용을 입력하세요');
			$('#gans_content').val('').focus();
			return false;
		}
		
		//입력한 정보 읽기
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'writeAnswer.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('관리자 로그인 후 작성할 수 있습니다.');
				}else if(param.result == 'notAdmin'){
					alert('잘못된 접근! 관리자만 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//답변 작성이 성공하면 새로 등록한 댓글을 포함해서 첫번쨰 페이지의 답변을 다시 호출함
					selectList(1); 
					location.reload(); //새로고침
				}else{
					alert('답변 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}			
		}); //end of ajax
		//기본 이벤트 제거
		event.preventDefault();
	}); //end of ans_form submit
	
	//답변 작성 폼 초기화
	function initForm(){
		$('.textarea').val('');
		$('#ans_first .letter-count').text('300/300');
	} //end of initForm
	
	//입력한 글자수 체크
	$(document).on('keyup', 'textarea', function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength > 300){
			$(this).val($(this).val().substring(0,300));
		}else{
			let remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id') == 'gans_content'){
				$('#ans_first .letter-count').text(remain);
			}else{
				$('#mans_first .letter-count').text(remain);
			}
		}
	}); //end of textarea keyup
	
	//답변 삭제
	$(document).on('click', '.delete-btn', function(){
		let gans_num = $(this).attr('data-num');
		
		//서버와 통신
		$.ajax({
			url:'deleteAnswer.do',
			type:'post',
			data:{gans_num:gans_num},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('관리자로 로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'notAdmin'){
					alert('관리자만 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					
					let choice = confirm('답변을 삭제하시겠습니까?');
					if(choice){
						alert('답변삭제 완료');
						selectList(1); //목록 갱신
						location.reload(); //새로고침
					}
				}else if(param.result == 'wrongAccesss'){
					alert('타인이 작성한 답변은 삭제할 수 없습니다.');
				}else{
					alert('답변 삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		}); //end of ajax
	}); //end of delete-btn click
	
	//답변 수정 폼 호출
	$(document).on('click', '.modify-btn', function(){
		let gans_num = $(this).attr('data-num'); //답변 번호
		let tmp = $(this).parent();
		let gans_content = $(tmp).parent().find('p').html().replace(/<br>/gi, '\r\n'); //답변 내용
		
		//답변 수정 폼 UI
		let modifyUI = '<form id="mans_form">';
		modifyUI += '<input type="hidden" name="gans_num" id="mans_num" value="' + gans_num + '">';
		modifyUI += '<textarea rows="3" cols="50" name="gans_content" id="mans_content" class="rep-content">' + gans_content + '</textarea>';
		modifyUI += '<div id="mans_first"><span class="letter-count">300/300</span></div>';
		modifyUI += '<div id="mans_second">';
		modifyUI += ' <input type="submit" value="수정">';
		modifyUI += ' <input type="button" value="취소" class="re-reset">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" width="100%" noshade>';
		modifyUI += '</form>';
		
		initModifyForm();
		
		//수정버튼을 감싸고 있는 div 감추기
		$(tmp).parent().hide();
		//수정 폼을 수정하고자 하는 데이터가 있는 div에 노출하기
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 셋팅
		let inputLength = $('#mans_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		$('#mans_first .letter-count').text(remain);
	}); //end of modify-btn click

	//수정 폼에서 취소 버튼 클릭 시 수정 폼 초기화
	$(document).on('click', '.re-reset', function(){
		initModifyForm();
	}); //end of re-reset click
	
	//답변 수정 폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mans_form').remove();
	} //end of initModifyForm
	
	//답변 수정
	$(document).on('submit', '#mans_form', function(event){
		if($('#mans_content').val().trim() == ''){
			alert('내용을 입력하세요.');
			$('#mans_content').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateAnswer.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('관리자로 로그인해야 수정할 수 있습니다.');
				}else if(param.result == 'notAdmin'){
					alert('관리자만 수정할 수 있습니다.');
				}else if(param.result == 'success'){
					//수정한 내용 처리
					$('#mans_form').parent().find('p').html($('#mans_content').val().replace(/</g, '$lt;').replace(/>/g,'&gt;').replace(/\r\n/g, '<br>').replace(/\r/g , '<br>').replace(/\n/g, '<br>'));
					
					//최근 수정일 처리
					$('#mans_form').parent().find('.modify-date').text('최근수정일 : 방금 전');
					
					//수정 폼 초기화
					initModifyForm();
					
				}else if(param.result == 'wrongAccess'){
					alert('타인의 답변은 수정할 수 없습니다.')
				}else{
					alert('답변 수정 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		}); //end of ajax
		
		//기본 이벤트 제거
		event.preventDefault();
	}); //end of mans_form submit
	
	//댓글 수 표시
	function displayReplyCount(data){
		let count = data.count;
		let output;
		if(count == 0){
			output = '댓글수(0)';
		}else{
			output = '댓글수(' + count + ')';
		}
		//문서 객체에 추가
		$('#output_rcount').text(output);
	}
	
	//초기 데이터(목록) 호출
	selectList(1);
	
});