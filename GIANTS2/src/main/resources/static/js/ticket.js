$(function() {
	let checkCnt=0;
	/* --------------------
	   등급 클릭시 Block 노출
	-------------------- */
	$('.grade_title').click(function() {
		if($('.click-grade').length > 0) { $('.grade_title').removeClass('click-grade'); }
		$(this).addClass('click-grade');
				
		$.ajax({
			url:'selectedGrade.do',
			type:'post',
			data:{grade_num:$(this).attr('data-grade'), game_num:$('#game_num').val()},
			dataType:'json',
			success:function(param) {
				if(param.result == 'logout') {
					alert('Login 후 이용가능');
					location.href='../member/login.do';
				} else if(param.result == 'success') {
					$('.block-table').empty();
					
					let block_info = '<table class="block-table">';
						block_info += '<tr>';
						block_info += '<th>블록번호</th>';
						block_info += '<th>잔여석</th>';
						block_info += '</tr>';
						
					$(param.list).each(function(index, item) {
						block_info += '<tr data-seat="' + item.seat_num + '" class="selected-block">';
						block_info += '<td>' + item.seat_block + '</td>';
						
						if(item.seat_quantity == 0) { block_info += '<td>매진</td>'; }
						else { block_info += '<td>' + item.seat_quantity + '</td>'; }
						
						block_info += '</tr>';
					});
					
					block_info += '</table>';
						
					$('.select-block').append(block_info);
				} else { alert('좌석 선택 오류 발생'); }
			},
			error:function() { alert('Network 오류 발생'); }
		});
	});
	
	/* -------------------------
	   Block 클릭시 seat 정보 호출
	------------------------- */
	$(document).on('click', '.selected-block', function() {
		if($('.click-block').length > 0) { $('.selected-block').removeClass('click-block'); }
		$(this).addClass('click-block');
		
		$.ajax({
			url:'selectedBlock.do',
			type:'post',
			data:{seat_num:$(this).attr('data-seat'), game_num:$('#game_num').val()},
			dataType:'json',
			success:function(param) {
				if(param.result == 'logout') {
					alert('Login 후 이용가능');
					location.href='../member/login.do';
				} else if(param.result == 'success') {
					$('.select-left').empty();
					
					let seat = param.seat.seat_num;
					let grade = param.seat.grade_num;
					let block = param.seat.seat_block;
					let row = param.seat.seat_row.split(',');
					let col = param.seat.seat_col.split(',');
					
					let row_length = row.length;
					let col_length = col.length;
					let info_length = param.status.length;
					let listLeng = param.list.length;
					
					let seat_div = '<div class="seat-box">';
					seat_div += '<div class="ground"><h2>그라운드 방향</h2></div>';
					seat_div +=  '<div class="seat-check">';
					
					for(let i = 0; i < row_length; i++) {
						
						seat_div += '<div class="row-div">';
						seat_div += '<span>' + row[i] + '</span>';
						for(let j = 0; j < col_length; j++) {
							seat_div += '<input type="button" data-info="' + block + '^' + row[i] +'^'+ col[j] + '" class="seat-btn gn' + grade +'" data-seatNum = "' + seat
														 + '" data-info2="' + block + row[i] + col[j] + '" data-block="' + block + '" data-grade="' + grade + '" data-row="' + row[i] + '" data-col="' + col[j] + '">';
						}
						seat_div += '</div>';
					}
					
					seat_div += '</div>';
						
					$('.select-left').append(seat_div);
					
					for(let z = 0; z < info_length; z++) {
						$('input[data-info="'+param.status[z].seat_info+'"]').removeClass('gn' + grade + '').addClass('reserved').attr('disabled',true);
					}
					
					for(let a = 0; a < listLeng; a++) {
						$('input[data-info="'+param.list[a].seat_info+'"]').removeClass('gn' + grade + '').addClass('admin-reserved').attr('disabled',true);
						let status_num = '<input type="hidden" name="status_num" value="' + param.list[a].status_num + '">';
						$('#seat_edit').append(status_num);
					}
					
				} else { alert('블록 선택 오류 발생'); }
			},
			error:function() { alert('Network 오류 발생'); }
		});
	});
	
	$(document).on('click', '.seat-btn', function() {
		let check_seat = $(this).attr('data-seatNum');
		let check_block = $(this).attr('data-block');
		let check_row = $(this).attr('data-row');
		let check_col = $(this).attr('data-col');
		let info = check_block + check_row + check_col;
		
		if($(this).hasClass('clicked')) { 
			checkCnt--;
			$(this).removeClass('clicked');
			$(this).addClass('gn'+$(this).attr('data-grade'));
			$('#del'+$(this).attr('data-info2')).remove();
		} else {
			checkCnt++;
			
			$(this).removeClass('gn'+$(this).attr('data-grade'));
			$(this).addClass('clicked');
		
			let seat_info = '<tr class="seat-leng" id="del'+info+'"><td>';
			seat_info += '<img src="../images/grade' + $(this).attr('data-grade') + '.png"> ' + check_block + '블럭 ' + check_row + '행 ' + check_col + '번';
			
			/*seat_info += '<input type="hidden" name="seatB" class="seatB" value="' + check_block + '">';
			seat_info += '<input type="hidden" name="seatR" class="seatR" value="' + check_row + '">';
			seat_info += '<input type="hidden" name="seatC" class="seatC" value="' + check_col + '">';*/
			
			seat_info += '<input type="hidden" name="seat_num" id="seat_num" value="' + check_seat + '">';
			seat_info += '<input type="hidden" name="seat_info" value="' + check_block + '^' + check_row + '^' + check_col + '">';
			seat_info += '<input type="hidden" name="grade_num" value="' + $(this).attr('data-grade') + '">';
			seat_info += '</td></tr>';
			
			$('.seat-table').append(seat_info);
			
			if($('.seat-leng').length > 4) {
				alert('1인 최대 4매까지 예매가능');
				$('.seat-leng').last().remove();
				$(this).last().addClass('gn'+$(this).attr('data-grade'));
				return;
			}
		}

		if(checkCnt > 0){ $('.select-checked').show(); }
		else{ $('.select-checked').hide(); }
	});
	
	// 선택화면 초기화 버튼
	$(document).on('click', '#reset_window', function() { location.reload(); return false; });
	
	$('#order_seat').submit(function() {
		// checkbox 유효성 검사
		if($('.seat-leng').length == 0) {
			alert('구매할 좌석을 선택하세요');
			return false;
		}
	});
	
	/* ---------------
	   선택한 좌석정보
	------------------ */
	let seat = $('.seat-info').text();
	let array = seat.split(' ');
	let leng = array.length - 1;
	let title = $('#grade_title').val();
	
	$('#seatInfo').empty();
	
	for(let i = 0; i < leng; i++) {
		let seatArr = array[i].split('^');
		
		let output = '<span class="seatQuantity">' + title + ' ' + seatArr[0] + '블록 ';
		output += seatArr[1] + '행 ';
		output += seatArr[2] + '번</span><br>';
		output += '<input type="hidden" name="seat_info" class="seatBRC" value="'+seatArr[0]+seatArr[1]+seatArr[2]+'">';
		output += '<input type="hidden" class="seatBRCstatus" value="'+array[i]+'">';
		$('#seatInfo').append(output);
	}
	
	let quantity = $('.seatQuantity').length;
	let countSeat = '<input type="hidden" name="ticket_quantity" value="' + quantity + '" id="ticket_quantity">';
	
	$('#seatInfo').append(countSeat);
	
	// 선택좌석 금액
	let price = $('.price-total>td:nth-child(2)').text();
	$('.price-total>td:nth-child(2)').empty()
	$('.price-total').append((price * leng).toLocaleString() + '원');
	
	$('.group-btn').append('<input type="hidden" name="total_price" value="' + price * leng + '" id="totalPrice">');
	
	/* ---------------
	   예매 좌석정보
	------------------ */
	let seat2 = $('.seat-info').text();
	let array2 = seat2.split(' ');
	let leng2 = array.length - 1;
	let title2 = $('.gradeTitle').text();
	
	$('#status_info').empty();
	
	for(let i = 0; i < leng2; i++) {
		let seatArr2 = array2[i].split('^');
		
		let output2 = '<span class="seat-infoLine">' + title2 + ' ' + seatArr2[0] + '블록 ' + seatArr2[1] + '행 ' + seatArr2[2] + '번</span> ';
		let output3 = '<li>' + title2 + ' ' + seatArr2[0] + '블록 ' + seatArr2[1] + '행 ' + seatArr2[2] + '번</li>';
		$('#status_info').append(output2);
		$('.ticket-content ul').append(output3);
	}
	
	/* ---------------
	   버튼 클릭시 티켓이미지 저장
	------------------ */
	$(document).on('click', '#ticket_download', function() {
		html2canvas($('.ticket-info2')[0]).then(function(canvas) {
			let img = document.createElement('a');
			img.download = $('#ticketNum').val() + '.png';
			img.href=canvas.toDataURL();
			document.body.appendChild(img);
			img.click();
		});
	});
	
});
