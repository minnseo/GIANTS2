package kr.spring.member.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"comp_photo"})
public class CompanyDetailVO {
	// Comp_detail 테이블
	@Size(min = 10, max = 10)
	private String comp_num; // 사업자번호(임시로등록)
	private String comp_num_1;
	private String comp_num_2;
	private String comp_num_3;
	@NotEmpty
	private String comp_owner; // 사업자명
	@NotEmpty
	private String comp_name; // 기업명
	@NotEmpty
	private String comp_cate; // 기업카테고리
	@Size(min = 11, max = 11)
	private String comp_phone; // 전화번호
	@Email
	@NotEmpty
	private String comp_email; // 이메일
	@Size(min = 5, max = 5)
	private String comp_zipcode; // 우편번호
	@NotEmpty
	private String comp_address1;// 주소
	@NotEmpty
	private String comp_address2;// 상세주소
	private byte[] comp_photo; // 프로필사진
	private String comp_photoname;// 프로필사진이름
	private Date comp_regdate; // 가입일
	private Date comp_modifydate;// 수정일
	private String comp_content; // 내용
	
	private float comp_score;		//평점
	
}