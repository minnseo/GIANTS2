package kr.spring.member.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"mem_photo"})
public class MemberDetailVO {
	private String mem_auid; // 자동로그인
	@NotEmpty
	private String mem_name; // 일반회원명
	@Size(min = 6, max = 6)
	private String mem_public; // 생년월일
	@Size(min = 11, max = 11)
	private String mem_phone; // 전화번호
	@Email
	@NotEmpty
	private String mem_email; // 이메일
	@Size(min = 5, max = 5)
	private String mem_zipcode; // 우편번호
	@NotEmpty
	private String mem_address1; // 상세주소
	@NotEmpty
	private String mem_address2; // 주소2
	private byte[] mem_photo; // 프로필사진
	private String mem_photoname; // 프로필사진이름
	private int mem_point; // 적립금
	private Date mem_regdate; // 가입일
	private Date mem_modifydate; // 수정일
	//파일 업로드처리
	public void setUpload(MultipartFile upload) throws IOException{
		setMem_photo(upload.getBytes());
		setMem_photoname(upload.getOriginalFilename());
	}

}