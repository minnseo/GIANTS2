package kr.spring.commu.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class CommuReplyVO {
	private int re_num; //댓글 번호
	private String re_content; //내용
	private String re_date; //등록일
	private String re_mdate; //수정일
	private String re_ip; //ip주소
	private int commu_num; //부모글 번호
	private int mem_num; //회원 번호
	
	private String mem_id; //회원 아이디
	private String mem_nickname; //회원 닉네임(별명)
	
	//원하는 시간 형식으로 포맷하여 저장
	public void setRe_date(String re_date) {
		this.re_date = DurationFromNow.getTimeDiffLabel(re_date);
	}
	public void setRe_mdate(String re_mdate) {
		this.re_mdate = DurationFromNow.getTimeDiffLabel(re_mdate);
	}
}
