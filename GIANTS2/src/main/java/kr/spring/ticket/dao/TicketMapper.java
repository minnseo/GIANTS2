package kr.spring.ticket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberDetailVO;
import kr.spring.ticket.vo.GameVO;
import kr.spring.ticket.vo.GradeVO;
import kr.spring.ticket.vo.SeatStatusVO;
import kr.spring.ticket.vo.SeatVO;
import kr.spring.ticket.vo.TicketCheckVO;
import kr.spring.ticket.vo.TicketDetailVO;
import kr.spring.ticket.vo.TicketVO;

@Mapper
public interface TicketMapper {
	/* 경기정보 */
	// 등록
	public void insertGame(GameVO gameVO);
	// 목록
	@Select("SELECT COUNT(*) FROM tgame")
	public int selectRowCount(GameVO gameVO);
	@Select("SELECT * FROM tgame WHERE game_date > SYSDATE-1 ORDER BY game_date ASC")
	public List<GameVO> selectTicketGameList(GameVO gameVO);
	// admin용 경기목록?
	@Select("SELECT * FROM tgame ORDER BY game_date ASC")
	public List<GameVO> selectTicketAdminGameList(GameVO gameVO);
	// 경기번호를 이용해 경기정보 구하기
	@Select("SELECT * FROM tgame WHERE game_num = #{game_num}")
	public GameVO selectGame(Integer game_num); 
	// 수정
	@Update("UPDATE tgame SET game_date = #{game_date}, game_time = #{game_time}, game_team = #{game_team},game_state = #{game_state} WHERE game_num = #{game_num}")
	public void updateGame(GameVO gameVO);
	// 삭제
	public void deleteGame(Integer game_num);
	
	// 경기취소일 경우 예매된 티켓 취소
	@Update("UPDATE ticket SET ticket_status = 2 WHERE game_num = #{game_num}")
	public void updateTicketByGameStatus(Integer game_num);
	
	/* 좌석등급 */
	// 등록
	public void insertGrade(GradeVO gradeVO);
	// 목록
	@Select("SELECT COUNT(*) FROM grade")
	public int selectGradeCount(GradeVO gradeVO);
	@Select("SELECT * FROM grade ORDER BY price_week")
	public List<GradeVO> selectGradeList(GradeVO gradeVO);
	// 상세
	@Select("SELECT * FROM grade WHERE grade_num = #{grade_num}")
	public GradeVO selectGrade(Integer grade_num);
	// 수정
	@Update("UPDATE grade SET title = #{title}, price_week = #{price_week}, price_weekend = #{price_weekend} WHERE grade_num = #{grade_num}")
	public void updateGrade(GradeVO gradeVO);
	// 삭제
	@Delete("DELETE FROM grade WHERE grade_num = #{grade_num}")
	public void deleteGrade(Integer grade_num);
	// 등급별 총 좌석개수
	@Update("UPDATE grade SET quantity = (SELECT SUM(seat_quantity) FROM seat WHERE grade_num = #{grade_num}) WHERE grade_num = #{grade_num}")
	public void updateGradeQuantity(Integer grade_num);
	
	/* 좌석정보 */
	// 등록
	public void insertSeat(SeatVO seatVO);
	// 목록
	@Select("SELECT COUNT(*) FROM seat WHERE grade_num = #{grade_num}")
	public int selectSeatCount(SeatVO seatVO);
	@Select("SELECT * FROM seat WHERE grade_num = #{grade_num} ORDER BY seat_num DESC")
	public List<SeatVO> selectSeatList(SeatVO seatVO);
	// 상세
	@Select("SELECT * FROM seat WHERE seat_num = #{seat_num}")
	public SeatVO selectSeat(Integer seat_num);
	@Select("SELECT * FROM seat WHERE grade_num = #{grade_num}")
	public List<SeatVO> selectSeatByG(Integer grade_num);
	// 수정
	@Update("UPDATE seat SET seat_block = #{seat_block}, seat_row = #{seat_row}, seat_col = #{seat_col}, seat_quantity = #{seat_quantity} WHERE seat_num = #{seat_num}")
	public void updateSeat(SeatVO seatVO);
	// 삭제
	@Delete("DELETE FROM seat WHERE grade_num = #{grade_num}")
	public void deleteSeat(Integer grade_num);
	// 등급별 좌석개수
	@Select("SELECT SUM(seat_quantity) FROM seat WHERE grade_num = #{grade_num}")
	public Integer selectSeatQuantity(Integer grade_num);
	
	@Select("SELECT * FROM member_detail WHERE mem_num = #{mem_num}")
	public MemberDetailVO selectMemberDetail(Integer mem_num);
	
	/* 티켓 결제 */
	@Select("SELECT ticket_check_seq.nextval FROM dual")
	public int selectCheckNum();	// 좌석선택 확인용 번호 생성
	@Insert("INSERT INTO ticket_check (check_num, seat_num, seat_info, game_num, mem_num) VALUES(#{check_num}, #{seat_num}, #{seat_info}, #{game_num}, #{mem_num})")
	public void insertTicketCheck(TicketCheckVO ticketCheckVO);	// 좌석선택정보 저장
	@Select("SELECT * FROM ticket_check WHERE check_num = #{check_num}")
	public List<TicketCheckVO> selectCheckList(Integer check_num);
	@Delete("DELETE FROM ticket_check WHERE mem_num = #{mem_num} AND game_num = #{game_num}")
	public void deleteCheck(Integer mem_num, Integer game_num);
	
	@Select("SELECT seat_status_seq.nextval FROM dual")
	public int selectStatusNum();
	@Insert("INSERT INTO seat_status (status_num, grade_num, seat_num, seat_info, game_num, seat_auth) VALUES(#{status_num}, #{grade_num}, #{seat_num}, #{seat_info}, #{game_num}, #{seat_auth})")
	public void insertSeatStatus(SeatStatusVO seatStatusVO);	// 좌석예매정보 등록
	@Select("SELECT * FROM seat_status WHERE game_num = #{game_num}")
	public List<SeatStatusVO> selectStatusByGame(Integer game_num);
	@Select("SELECT * FROM seat_status WHERE seat_num = #{seat_num} AND seat_auth = 2")
	public List<SeatStatusVO> selectStatusBySeat(Integer seat_num);
	@Select("SELECT count(*) FROM seat_status WHERE game_num = #{game_num} AND seat_num = #{seat_num}")
	public int selectCountBySeatNum(Integer game_num, Integer seat_num);
	@Select("SELECT count(*) FROM seat_status WHERE game_num = #{game_num} AND grade_num = #{grade_num}")
	public int selectCountByGradeNum(Integer game_num, Integer grade_num);
	
	@Select("SELECT count(*) FROM seat_status WHERE seat_num = #{seat_num} AND seat_auth = 2")
	public int selectAdminCountBySeatNum(Integer seat_num);
	@Select("SELECT count(*) FROM seat_status WHERE grade_num = #{grade_num} AND seat_auth = 2")
	public int selectAdminCountByGradeNum(Integer grade_num);
	
	@Select("SELECT * FROM seat_status WHERE status_num = #{status_num}")
	public List<SeatStatusVO> selectSeatInfo(Integer status_num);
	@Select("SELECT * FROM seat_status WHERE seat_info = #{seat_info} AND game_num = #{game_num}")
	public SeatStatusVO selectSeatInfoIsNull(String seat_info, Integer game_num);
	
	@Delete("DELETE FROM seat_status WHERE status_num = #{status_num} AND seat_auth = 2")
	public void deleteAdminStatus(Integer status_num);
	@Delete("DELETE FROM seat_status WHERE status_num = #{status_num} AND seat_auth = 1")
	public void deleteStatus(Integer status_num);	// 주문 취소시 좌석예매 정보 삭제
	@Delete("DELETE FROM seat_status WHERE grade_num = #{grade_num}")
	public void deleteSeatStatusByG(Integer grade_num);
	
	public void insertTicket(TicketVO ticketVO);	// 주문 등록
	@Insert("INSERT INTO ticket_detail (detail_num, ticket_num, seat_info) VALUES(ticket_detail_seq.nextval, #{ticket_num}, #{seat_info})")
	public void insertTicketDetail(TicketDetailVO ticketDetailVO);
	@Select("SELECT * FROM ticket WHERE ticket_num = #{ticket_num}")
	public TicketVO selectTicket(String ticket_num);
	@Select("SELECT * FROM ticket_detail WHERE ticket_num = #{ticket_num}")
	public List<TicketDetailVO> selectSeatInfoByT(String ticket_num);
	@Update("UPDATE ticket set ticket_status = 0, ticket_modify = SYSDATE WHERE ticket_num = #{ticket_num}")
	public void updateTicket(String ticket_num);	// 주문 취소 → ticket 테이블에서 상태만 변경
	
	// QR코드 승인 및 업데이트 처리
	@Update("UPDATE ticket SET order_status=0 WHERE ticket_num = #{ticket_num}")
	public void updateOrderStatus(String ticket_num);
}
