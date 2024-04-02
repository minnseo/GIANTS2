package kr.spring.trading.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = "trade_photo")
public class TradingVO {
	private int trade_num; //중고거래 게시글 번호 
	@NotEmpty
	private String trade_title; //제목
	@NotEmpty
	private String trade_content; //내용
	@Range(min=1, max=99999999)
	private int trade_price; //거래물품 가격
	private int trade_hit; //조회수
	private Date trade_date; //등록일
	private Date trade_modifydate; //수정일
	private int trade_status; //거래 상태(0:판매중, 1:거래완료)
	private byte[] trade_photo; //대표이미지
	private String trade_photoname; //대표이미지 파일명
	private String trade_ip; //ip주소
	private int mem_num; //회원번호

	private String mem_id; //아이디
	private String mem_nickname; //닉네임
	
	private int mark_cnt; //북마크 개수
	
	//======이미지를 byte[]로 변환하는 메서드(BLOB 처리)=====//
	public void setUpload(MultipartFile upload) throws IOException{
		setTrade_photo(upload.getBytes()); //MultipartFile -> byte[]
		setTrade_photoname(upload.getOriginalFilename()); //파일 이름
	}
}
