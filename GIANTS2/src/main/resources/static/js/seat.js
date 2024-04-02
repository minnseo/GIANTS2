$(function() {
	// 좌석블록정보 등록 활성화
	$('#open_seatForm').click(function() {
		$('#seat_write').show();
		$('.seatUpdate').hide();
	});
	
	// 좌석블록정보 취소
	$('#close_seatForm').click(function() {
		$('#seat_write').hide();
		location.reload();
	});
	
	$(document).on('click', '.closeForm', function() {
		$('.seatUpdate').hide();
		location.reload();
	});
	
	/* ----- checkbox 설정 ----- */
	// checkbox[name=seat_row]
	// 전체
	$(document).on('click', '#check_row', function() {
		if($('#check_row').is(':checked')) {
			$('.seat-row').prop('checked', true);
			quantituSet();
		} else { $('.seat-row').prop('checked', false); }
	});
	
	// 개별
	$(document).on('click', '.seat-row', function() {
		if($('input[class="seat-row"]:checked').length == $('.seat-row').length) {
			$('#check_row').prop('checked', true);
		} else { $('#check_row').prop('checked', false); }
		
		if($('input[class="seat-col"]:checked').length > 0) { quantituSet(); }
	});
	
	// checkbox[name=seat_col]
	// 전체
	$(document).on('click', '#check_col', function() {
		if($('#check_col').is(':checked')) {
			$('.seat-col').prop('checked', true);
			quantituSet();
		} else { $('.seat-col').prop('checked', false); }
	});
	// 개별
	$(document).on('click', '.seat-col', function() {
		if($('input[class="seat-col"]:checked').length == $('.seat-col').length) {
			$('#check_col').prop('checked', true);
		} else { $('#check_col').prop('checked', false); }
		
		if($('input[class="seat-row"]:checked').length > 0) { quantituSet(); }
	});
	
	function quantituSet() {
		let seat_row = $('input[class="seat-row"]:checked').length;
		let seat_col = $('input[class="seat-col"]:checked').length;
		let quantity = seat_row * seat_col;
		
		$('#seat_quantity').attr('value', quantity);
	}
	
	// 좌석정보 등록
	$('#seat_write').submit(function(event) {
		// 유효성 검사
		if($('#seat_block').val().trim() == '0' || $('#seat_block').val().trim() == '') {
			$('#block_error').text('1부터 935이하의 값 입력');
			$('#seat_block').val('').focus();
			return false;
		}
		if($('input[name="seat_row"]:checked').length == 0) {
			$('#row_error').text('좌석행 선택 필수');
			return false;
		}
		if($('input[name="seat_col"]:checked').length == 0) {
			$('#col_error').text('좌석열 선택 필수');
			return false;
		}
		
		event.prevenDefault();
	});
	
	// 좌석정보 수정
	$(document).on('submit', '.seatUpdate', function(event) {
		// 유효성 검사
		if($('.seat-block').val().trim() == '0' || $('.seat-block').val().trim() == '') {
			$('.block-error').text('1부터 935이하의 값 입력');
			$('.seat-block').val('').focus();
			return false;
		}
		if($('input[name="seat_row"]:checked').length == 0) {
			$('.row-error').text('좌석행 선택 필수');
			return false;
		}
		if($('input[name="seat_col"]:checked').length == 0) {
			$('.col-error').text('좌석열 선택 필수');
			return false;
		}
		
		event.prevenDefault();
	});
	
	// 좌석 수정 UI
	$(document).on('click', '.seat-update', function() {
		$('#seat_write').hide();
		$('.seatform-update').empty();
		
		let seat_num = $('#seatNum').val();
		
		let output = '<form action="seatUpdate.do" class="seatUpdate" method="post">';
		output += '<input type="hidden" name="seat_num" id="seat_num" value="' + seat_num + '">';
		output += '<input type="hidden" name="grade_num" id="gradeNum" value="' + $('#grade_num').val() + '">';
		output += '<ul>';
		output += '<li>';
		output += '<label for="seat_block">블럭번호</label>';
		output += '<input type="number" name="seat_block" class="seat-block" value="'+$(this).attr('data-seatblock')+'">';
		output += '<span class="block-error error-color"></span>';
		output += '</li>';
		output += '<li>';
		output += '<label for="seat_row">좌석행</label>';
		output += '<input type="checkbox" value="selectRow" class="check-row">All';
		output += '<input type="checkbox" name="seat_row" value="A" class="seat-row2">A';
		output += '<input type="checkbox" name="seat_row" value="B" class="seat-row2">B';
		output += '<input type="checkbox" name="seat_row" value="C" class="seat-row2">C';
		output += '<input type="checkbox" name="seat_row" value="D" class="seat-row2">D';
		output += '<input type="checkbox" name="seat_row" value="E" class="seat-row2">E';
		output += '<input type="checkbox" name="seat_row" value="F" class="seat-row2">F';
		output += '<input type="checkbox" name="seat_row" value="G" class="seat-row2">G';
		output += '<span class="row-error error-color"></span>';
		output += '</li>';
		output += '<li>';
		output += '<label for="seat_col">좌석열</label>';
		output += '<input type="checkbox" value="selectCol" class="check-col">All';
		output += '<input type="checkbox" name="seat_col" value="1" class="seat-col2">1';
		output += '<input type="checkbox" name="seat_col" value="2" class="seat-col2">2';
		output += '<input type="checkbox" name="seat_col" value="3" class="seat-col2">3';
		output += '<input type="checkbox" name="seat_col" value="4" class="seat-col2">4';
		output += '<input type="checkbox" name="seat_col" value="5" class="seat-col2">5';
		output += '<input type="checkbox" name="seat_col" value="6" class="seat-col2">6';
		output += '<input type="checkbox" name="seat_col" value="7" class="seat-col2">7';
		output += '<input type="checkbox" name="seat_col" value="8" class="seat-col2">8';
		output += '<input type="checkbox" name="seat_col" value="9" class="seat-col2">9';
		output += '<input type="checkbox" name="seat_col" value="10" class="seat-col2">10';
		output += '<span class="col-error error-color"></span>';
		output += '</li>';
		output += '<li>';
		output += '<label for="seat_quantity">좌석개수</label>';
		output += '<input type="number" name="seat_quantity" class="seat-quantity" value="">';
		output += '</li>';
		output += '<li>';
		output += '<input type="submit" value="수정" class="admin-btn small">';
		output += ' <input type="button" value="취소" class="closeForm gray-btn small">';
		output += '</li>';
		output += '</ul>';
		output += '</form>';
		
		$('.seatform-update').append(output);
	});
	
	/* ----- checkbox 설정2 ----- */
	// checkbox[name=seat_row]
	// 전체
	$(document).on('click', '.check-row', function() {
		if($('.check-row').is(':checked')) {
			$('.seat-row2').prop('checked', true);
			quantituSet2();
		} else { $('.seat-row2').prop('checked', false); }
	});
	
	// 개별
	$(document).on('click', '.seat-row2', function() {
		if($('input[class="seat-row2"]:checked').length == $('.seat-row2').length) {
			$('.check-row').prop('checked', true);
		} else { $('.check-row').prop('checked', false); }
		
		if($('input[class="seat-col2"]:checked').length > 0) { quantituSet2(); }
	});
	
	// checkbox[name=seat_col]
	// 전체
	$(document).on('click', '.check-col', function() {
		if($('.check-col').is(':checked')) {
			$('.seat-col2').prop('checked', true);
			quantituSet2();
		} else { $('.seat-col2').prop('checked', false); }
	});
	// 개별
	$(document).on('click', '.seat-col2', function() {
		if($('input[class="seat-col2"]:checked').length == $('.seat-col2').length) {
			$('.check-col').prop('checked', true);
		} else { $('.check-col').prop('checked', false); }
		
		if($('input[class="seat-row2"]:checked').length > 0) { quantituSet2(); }
	});
	
	function quantituSet2() {
		let seat_row = $('input[class="seat-row2"]:checked').length;
		let seat_col = $('input[class="seat-col2"]:checked').length;
		let quantity = seat_row * seat_col;
		
		$('.seat-quantity').attr('value', quantity);
	}
	
	/* ----- 좌석관리 UI ----- */
	let admin_grade = $('#admin_grade').val();
	let admin_seat = $('#admin_seat').val();
	let admin_seatBlock = $('#admin_block').val();
	let admin_seatRow = $('#admin_row').val().split(',');
	let admin_seatCol = $('#admin_col').val().split(',');
	
	let rowLeng = admin_seatRow.length;
	let colLeng = admin_seatCol.length;
	
	$.ajax({
		url:'seatEditForm.do',
		type:'post',
		data:{seat_num:admin_seat},
		dataType:'json',
		success:function(param) {
			let listLeng = param.list.length;
			
			let seatBox = '<div class="ground"><h2>그라운드 방향</h2></div>';
			seatBox +=  '<div class="seat-check2">';
							
			for(let i = 0; i < rowLeng; i++) {
				seatBox += '<div class="row-div">';
				seatBox += '<span>' + admin_seatRow[i] + '</span>';
				for(let j = 0; j < colLeng; j++) {
					seatBox += '<input type="button" data-info="' + admin_seatBlock + '^' + admin_seatRow[i] +'^'+ admin_seatCol[j] + '" class="seat-btn gn' + admin_grade
												+ '" data-seatNum = "' + admin_seat + '" data-info2="' + admin_seatBlock + admin_seatRow[i] + admin_seatCol[j]
												+ '" data-block="' + admin_seatBlock + '" data-grade="' + admin_grade + '" data-row="' + admin_seatRow[i] + '" data-col="' + admin_seatCol[j] + '">';
				}
				seatBox += '</div>';
			}
							
			seatBox += '</div>';
			
			$('.admin_seatBox').append(seatBox);
			
			for(let z = 0; z < listLeng; z++){
				if($('input[data-info="'+param.list[z].seat_info+'"]')){
					$('input[data-info="'+param.list[z].seat_info+'"]').removeClass('gn' + admin_grade + '').addClass('admin-reserved');
					let status_num = '<input type="hidden" name="status_num" value="' + param.list[z].status_num + '">';
					$('#seat_edit').append(status_num);
				} else {
					$('input[data-info="'+param.list[z].seat_info+'"]').removeClass('admin-reserved').addClass('gn' + admin_grade + '');
					
				}
			}
			
			let status_num = '<input type="hidden" name="status_num" value="0">';
			$('#seat_edit').append(status_num);
		},
		error:function() { alert('Network 오류 발생'); }
	})
	
	let checkCnt = 0;
	
	$(document).on('click', '.seat-btn', function() {
		let check_seat = $(this).attr('data-seatNum');
		let check_block = $(this).attr('data-block');
		let check_row = $(this).attr('data-row');
		let check_col = $(this).attr('data-col');
		let info = check_block + check_row + check_col;
		
		//if($(this).hasClass('admin-reserved')) { $(this).addClass('clicked'); }
		
		if($(this).hasClass('clicked')) { 
			checkCnt--;
			$(this).removeClass('clicked').removeClass('admin-reserved');
			$(this).addClass('gn'+$(this).attr('data-grade'));
			$('#del'+$(this).attr('data-info2')).remove();
		} else {
			checkCnt++;
			$(this).removeClass('gn'+$(this).attr('data-grade'));
			$(this).addClass('clicked');
		
			let seat_info = '<tr class="seat-leng" id="del'+info+'"><td>';
			seat_info += '<img src="../images/grade' + $(this).attr('data-grade') + '.png"> ' + check_block + '블럭 ' + check_row + '행 ' + check_col + '번';
			
			seat_info += '<input type="hidden" id="seatNUM" name="seat_num" value="' + check_seat + '">';
			seat_info += '<input type="hidden" id="seatINFO" name="seat_info" value="' + check_block + '^' + check_row + '^' + check_col + '">';
			seat_info += '<input type="hidden" id="gradeNUM" name="grade_num" value="' + $(this).attr('data-grade') + '">';
			seat_info += '</td></tr>';
			
			$('.seat-table').append(seat_info);
			
		}

		if(checkCnt > 0){ $('.select-checked').show(); }
		else{ $('.select-checked').hide(); }
	});
	
	$(document).on('submit', '#seat_edit', function() {
		if($('.seat-leng').length == 0) {
			alert('상태를 변경할 좌석을 선택하세요');
			return false;
		}
		
		/*$.ajax({
			url:'seatEdit.do',
			type:'post',
			data:{seat_num:$('#seatNUM').val(), grade_num:$('#gradeNUM').val(), seat_info:$('#seatINFO').val()},
			dataType:'json',
			success:function(param) {
				if(param.result == 'success') {
					location.href='gradeList.do';
				}
			},
			error:function() { alert('Network 오류 발생'); }
		});*/
	});
});
