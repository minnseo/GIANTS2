package kr.spring.goods.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import kr.spring.member.vo.MemberVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude="review_photo")
public class GoodsReviewVO {
	private int review_num; //리뷰 번호
	private int mem_num; //작성자 회원번호
	private int goods_num; //상품 번호
	@NotEmpty
	private String review_title; //리뷰 제목
	@Range(min=1, max=5)
	private int review_score; //별점
	@NotEmpty
	private String review_content; //후기 내용
	private byte[] review_photo; //후기 사진
	private String review_photoname; //후기 사진 파일명
	private Date review_regdate; //후기등록일
	private Date review_mdate; //후기 최근 수정일
	private String review_ip;
	
	private String mem_id;
	private String mem_nickname;
	private String goods_name;
	
	//======이미지를 byte[]로 변환하는 메서드(BLOB 처리)=====//
	public void setUpload(MultipartFile upload) throws IOException{
		setReview_photo(upload.getBytes()); //MultipartFile -> byte[]
		setReview_photoname(upload.getOriginalFilename()); //파일 이름
	}
}
