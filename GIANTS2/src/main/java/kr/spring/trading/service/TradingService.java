package kr.spring.trading.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.trading.vo.TradingMarkVO;
import kr.spring.trading.vo.TradingVO;

public interface TradingService {
	//부모글
	public List<TradingVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertTrading(TradingVO trading);
	public TradingVO selectTrading(Integer trade_num);
	public void updateHit(Integer trade_num);
	public void updateTrading(TradingVO trading);
	public void deleteTrading(Integer trade_num);
	
	//북마크
	public TradingMarkVO selectMark(TradingMarkVO mark);
	public int selectMarkCount(Integer trade_num);
	public void insertMark(TradingMarkVO mark);
	public void deleteMark(Integer mark_num);
	
	//작성자 회원번호 구하기
	public int selectMemNumByTradeNum(Integer trade_num);
	
	//회원별 북마크 목록
	public List<TradingVO> selectTradingBookmarkList(Map<String, Object> map);
	public int selectBookmarkRowCount(Map<String, Object> map);
}