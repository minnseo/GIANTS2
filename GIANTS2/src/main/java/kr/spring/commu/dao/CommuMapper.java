package kr.spring.commu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.commu.vo.CommuFavVO;
import kr.spring.commu.vo.CommuReplyVO;
import kr.spring.commu.vo.CommuReportVO;
import kr.spring.commu.vo.CommuVO;

@Mapper
public interface CommuMapper {
	//부모글
	public List<CommuVO> selectList(Map<String,Object> map);
	
	public int selectRowCount(Map<String,Object> map);
	
	public void insertCommu(CommuVO commu);
	
	public CommuVO selectCommu(Integer commu_num);
	
	@Update("UPDATE commu SET commu_hit = commu_hit + 1 WHERE commu_num = #{commu_num}")
	public void updateHit(Integer commu_num);
	
	@Update("UPDATE commu SET commu_title = #{commu_title}, commu_content = #{commu_content}, commu_ip = #{commu_ip}, commu_modifydate = SYSDATE WHERE commu_num = #{commu_num}")
	public void updateCommu(CommuVO commu);
	
	@Delete("DELETE FROM commu WHERE commu_num=#{commu_num}")
	public void deleteCommu(Integer commu_num); 
	
	//좋아요
	@Select("SELECT * FROM commu_like WHERE commu_num=#{commu_num} AND mem_num=#{mem_num}")
	public CommuFavVO selectFav(CommuFavVO fav);
	
	@Select("SELECT COUNT(*) FROM commu_like WHERE commu_num=#{commu_num}") 
	public int selectFavCount(Integer commu_num);
	
	@Insert("INSERT INTO commu_like (commu_like_num,commu_num,mem_num) VALUES (commu_like_seq.nextval,#{commu_num},#{mem_num})")
	public void insertFav(CommuFavVO fav);
	
	@Delete("DELETE FROM commu_like WHERE commu_like_num=#{commu_like_num}")
	public void deleteFav(Integer fav_num);
	
	//부모글 삭제 시 좋아요가 존재하면, 부모글이 삭제되기 전 좋아요를 먼저 삭제
	@Delete("DELETE FROM commu_like  WHERE commu_num=#{commu_num}")
	public void deleteFavByCommuNum(Integer commu_num);
	
	
	//댓글
	public List<CommuReplyVO> selectListReply(Map<String,Object> map);
	
	@Select("SELECT COUNT(*) FROM commu_reply WHERE commu_num=#{commu_num}")
	public int selectRowCountReply(Map<String,Object> map);
	
	@Select("SELECT * FROM commu_reply WHERE re_num=#{re_num}")
	public CommuReplyVO selectReply (Integer re_num);
	
	public void insertReply(CommuReplyVO commuReply);
	
	@Update("UPDATE commu_reply SET re_content=#{re_content},re_ip=#{re_ip},re_mdate=SYSDATE WHERE re_num=#{re_num}")
	public void updateReply(CommuReplyVO commuReply);		
	
	@Delete("DELETE FROM commu_reply WHERE re_num=#{re_num}")
	public void deleteReply(Integer re_num);
	
	//부모글 삭제 시 댓글이 존재하면, 부모글이 삭제되기 전 댓글을 먼저 삭제
	@Delete("DELETE FROM commu_reply WHERE commu_num=#{commu_num}")
	public void deleteReplyByCommuNum(Integer commu_num);
	
	
	
	//신고
	public List<CommuReportVO> selectListReport (Map<String,Object> map);
	
	@Select("SELECT COUNT(*) FROM commu_report WHERE repo_num=#{repo_num}")
	public int selectRowCountReort(Map<String,Object> map);
	
	@Select("SELECT * FROM commu_report WHERE repo_num=#{repo_num}")
	public CommuReportVO selectReport (Integer repo_num);
	public void insertReport(CommuReportVO commuReport);
	
	@Delete("DELETE FROM commu_report WHERE repo_num=#{repo_num}")
	public void deleteReport(Integer repo_num);
	
	
}
