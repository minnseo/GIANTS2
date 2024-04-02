package kr.spring.introduce.vo;

import java.io.IOException;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PlayerVO {
	private int player_num; //선수 번호
	@NotEmpty
	private String player_name; //선수 이름
	@NotEmpty
	private String player_backnumber; //선수 등번호 
	@NotEmpty
	private String player_position; //선수 포지션
	//@NotEmpty
	private byte[] player_photo; //선수 사진
	private String player_photoname; //선수 사진 파일명
	@NotEmpty
	private String player_birthday; //선수 생일 
	@NotEmpty
	private String player_height; //선수 키 
	@NotEmpty
	private String player_weight; //선수 몸무게
	@NotEmpty
	private String player_toway; //선수 투타
	@NotEmpty
	private String player_join; //선수 입단년도 
	@NotEmpty
	private String player_career; //선수 경력사항
	
	//업로드 파일 처리
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile  -> byte[] 변환
		setPlayer_photo(upload.getBytes());

		//파일명 구하기
		setPlayer_photoname(upload.getOriginalFilename());
	}
}
