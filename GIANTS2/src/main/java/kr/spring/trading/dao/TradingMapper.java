package kr.spring.trading.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.trading.vo.TradingMarkVO;
import kr.spring.trading.vo.TradingVO;

@Mapper //mybatis가 객체 생성할 수 있게끔 함
public interface TradingMapper {
	//부모글
	public List<TradingVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertTrading(TradingVO trading);
	public TradingVO selectTrading(Integer trade_num);
	@Update("UPDATE trading SET trade_hit=trade_hit+1 WHERE trade_num=#{trade_num}")
	public void updateHit(Integer trade_num);
	//@Update("UPDATE trading SET trade_title=#{trade_title}, trade_content=#{trade_content}, trade_price=#{trade_price}, trade_photo=#{trade_photo}, trade_photoname=#{trade_photoname}, trade_ip=#{trade_ip}, trade_status=#{trade_status}, trade_modifydate=SYSDATE WHERE trade_num=#{trade_num}")
	public void updateTrading(TradingVO trading);
	@Delete("DELETE FROM trading WHERE trade_num=#{trade_num}")
	public void deleteTrading(Integer trade_num);
	
	//북마크
	@Select("SELECT * FROM bookmark WHERE trade_num=#{trade_num} AND mem_num=#{mem_num}")
	public TradingMarkVO selectMark(TradingMarkVO mark);
	@Select("SELECT COUNT(*) FROM bookmark WHERE trade_num=#{trade_num}")
	public int selectMarkCount(Integer trade_num);
	@Insert("INSERT INTO bookmark (mark_num, trade_num, mem_num) VALUES (bookmark_seq.nextval, #{trade_num}, #{mem_num})")
	public void insertMark(TradingMarkVO fav);
	@Delete("DELETE FROM bookmark WHERE mark_num=#{mark_num}")
	public void deleteMark(Integer mark_num);
	@Delete("DELETE FROM bookmark WHERE trade_num=#{trade_num}")
	public void deleteMarkByTradeNum(Integer trade_num);
	
	//작성자 회원번호 구하기
	@Select("SELECT mem_num FROM trading WHERE trade_num=#{trade_num}")
	//@Select("SELECT mem_num, mem_id FROM trading t JOIN member_detail d ON t.mem_num = d.mem_num WHERE trade_num=#{trade_num}")
	public int selectMemNumByTradeNum(Integer trade_num);
	
	//채팅
	@Delete("DELETE FROM chat_read WHERE chatroom_num IN (SELECT chatroom_num FROM chatroom WHERE trade_num=#{trade_num})")
	public void deleteChatReadByTradeNum(Integer trade_num);
	@Delete("DELETE FROM chat WHERE chatroom_num IN (SELECT chatroom_num FROM chatroom WHERE trade_num=#{trade_num})")
	public void deleteChatByTradeNum(Integer trade_num);
	@Delete("DELETE FROM chatroom WHERE trade_num=#{trade_num}")
	public void deleteChatRoomByTradeNum(Integer trade_num);
	
	//회원별 북마크 목록
	public List<TradingVO> selectTradingBookmarkList(Map<String, Object> map);
	public int selectBookmarkRowCount(Map<String, Object> map);
} 
