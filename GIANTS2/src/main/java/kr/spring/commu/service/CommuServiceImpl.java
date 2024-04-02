package kr.spring.commu.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.commu.dao.CommuMapper;
import kr.spring.commu.vo.CommuFavVO;
import kr.spring.commu.vo.CommuReplyVO;
import kr.spring.commu.vo.CommuReportVO;
import kr.spring.commu.vo.CommuVO;

@Service
@Transactional
public class CommuServiceImpl implements CommuService{
	@Autowired
	CommuMapper commuMapper;
	
	@Override
	public List<CommuVO> selectList(Map<String, Object> map) {
		
		return commuMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		
		return commuMapper.selectRowCount(map);
	}

	@Override
	public void insertCommu(CommuVO commu) {

		commuMapper.insertCommu(commu);
		
	}

	@Override
	public CommuVO selectCommu(Integer commu_num) {
		
		return commuMapper.selectCommu(commu_num);
	}

	@Override
	public void updateHit(Integer commu_num) {

		commuMapper.updateHit(commu_num);
	}

	@Override
	public void updateCommu(CommuVO commu) {
		
		commuMapper.updateCommu(commu);
	}

	@Override
	public void deleteCommu(Integer commu_num) {
		//부모글 좋아요 삭제
		commuMapper.deleteFavByCommuNum(commu_num);
		//댓글 존재 시 댓글 우선 삭제 후 부모글 삭제
		commuMapper.deleteReplyByCommuNum(commu_num);
		//부모글 삭제
		commuMapper.deleteCommu(commu_num);
		
	}

	@Override
	public CommuFavVO selectFav(CommuFavVO fav) {
		
		return commuMapper.selectFav(fav);
	}

	@Override
	public int selectFavCount(Integer commu_num) {
		
		return commuMapper.selectFavCount(commu_num);
	}

	@Override
	public void insertFav(CommuFavVO fav) {

		commuMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(Integer fav_num) {
		commuMapper.deleteFav(fav_num);
		
	}

	@Override
	public List<CommuReplyVO> selectListReply(Map<String, Object> map) {
		
		return commuMapper.selectListReply(map);
	}

	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		
		return commuMapper.selectRowCountReply(map);
	}

	@Override
	public CommuReplyVO selectReply(Integer re_num) {
		
		return commuMapper.selectReply(re_num);
	}

	@Override
	public void insertReply(CommuReplyVO commuReply) {
		
		commuMapper.insertReply(commuReply);
	}

	@Override
	public void updateReply(CommuReplyVO commuReply) {

		commuMapper.updateReply(commuReply);
	}

	@Override
	public void deleteReply(Integer re_num) {

		commuMapper.deleteReply(re_num);
	}

	@Override
	public List<CommuReportVO> selectListReport(Map<String, Object> map) {
		
		return commuMapper.selectListReport(map);
	}

	@Override
	public int selectRowCountReort(Map<String, Object> map) {
		
		return commuMapper.selectRowCount(map);
	}

	@Override
	public CommuReportVO selectReport(Integer repo_num) {
		
		return commuMapper.selectReport(repo_num);
	}

	@Override
	public void insertReport(CommuReportVO commuReport) {
		
		commuMapper.insertReport(commuReport);
		
	}

	

	@Override
	public void deleteReport(Integer repo_num) {
		
		commuMapper.deleteReport(repo_num);
		
		
	}
}
