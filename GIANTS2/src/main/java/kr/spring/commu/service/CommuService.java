package kr.spring.commu.service;

import java.util.List;
import java.util.Map;

import kr.spring.commu.vo.CommuFavVO;
import kr.spring.commu.vo.CommuReplyVO;
import kr.spring.commu.vo.CommuReportVO;
import kr.spring.commu.vo.CommuVO;

public interface CommuService {
	//부모글
	public List<CommuVO> selectList(Map<String,Object> map);
	public int selectRowCount (Map<String,Object> map);
	public void insertCommu(CommuVO commu);
	public CommuVO selectCommu(Integer commu_num);
	public void updateHit(Integer commu_num);
	public void updateCommu(CommuVO commu);
	public void deleteCommu(Integer commu_num);
	
	//좋아요
	public CommuFavVO selectFav(CommuFavVO fav);
	public int selectFavCount(Integer commu_num);
	public void insertFav(CommuFavVO fav);
	public void deleteFav(Integer fav_num);
	
	//댓글
	public List<CommuReplyVO> selectListReply (Map<String,Object> map);
	public int selectRowCountReply(Map<String,Object> map);
	public CommuReplyVO selectReply (Integer re_num);
	public void insertReply(CommuReplyVO commuReply);
	public void updateReply(CommuReplyVO commuReply);
	public void deleteReply(Integer re_num);
	
	//신고
	public List<CommuReportVO> selectListReport (Map<String,Object> map);
	public int selectRowCountReort(Map<String,Object> map);
	public CommuReportVO selectReport (Integer repo_num);
	public void insertReport(CommuReportVO commuReport);
	public void deleteReport(Integer repo_num);
	
}
