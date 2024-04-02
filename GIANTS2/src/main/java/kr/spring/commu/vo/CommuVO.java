package kr.spring.commu.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommuVO {
	private int commu_num; //커뮤니티 번호
	@NotEmpty
	private String commu_title; //커뮤니티 제목
	@NotEmpty
	private String commu_content; //내용
	private int commu_hit; //조회수
	private Date commu_date; //등록일
	private Date commu_modifydate; //수정일
	private String commu_ip; //ip주소
	private int mem_num; //회원 번호
	
	private String mem_id; //아이디
	private String mem_nickname; //별명
	
	private int re_cnt; //댓글 개수
	private int fav_cnt; //좋아요 개수
}
