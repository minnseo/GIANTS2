package kr.spring.ticket.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.vo.MemberDetailVO;
import kr.spring.ticket.dao.TicketMapper;
import kr.spring.ticket.vo.GameVO;
import kr.spring.ticket.vo.GradeVO;
import kr.spring.ticket.vo.SeatStatusVO;
import kr.spring.ticket.vo.SeatVO;
import kr.spring.ticket.vo.TicketCheckVO;
import kr.spring.ticket.vo.TicketDetailVO;
import kr.spring.ticket.vo.TicketVO;

@Service
@Transactional
public class TicketServiceImpl implements TicketService { 
	@Autowired
	TicketMapper ticketMapper;
	
	/* GRADE */	
	@Override
	public void insertGrade(GradeVO gradeVO) { ticketMapper.insertGrade(gradeVO); }
	
	@Override
	public int selectGradeCount(GradeVO gradeVO) { return ticketMapper.selectGradeCount(gradeVO); }

	@Override
	public List<GradeVO> selectGradeList(GradeVO gradeVO) {return ticketMapper.selectGradeList(gradeVO);}
	
	@Override
	public GradeVO selectGrade(Integer grade_num) { return ticketMapper.selectGrade(grade_num); }
	
	@Override
	public void updateGrade(GradeVO gradeVO) { ticketMapper.updateGrade(gradeVO); }
	
	@Override
	public void deleteGrade(Integer grade_num) {
		ticketMapper.deleteSeat(grade_num);
		ticketMapper.deleteGrade(grade_num);
	}
	
	@Override
	public void updateGradeQuantity(Integer grade_num) { ticketMapper.updateGradeQuantity(grade_num); }
	
	/* SEAT */
	@Override
	public void insertSeat(SeatVO seatVO) { ticketMapper.insertSeat(seatVO); }
	
	@Override
	public int selectSeatCount(SeatVO seatVO) { return ticketMapper.selectSeatCount(seatVO); }

	@Override
	public List<SeatVO> selectSeatList(SeatVO seatVO) { return ticketMapper.selectSeatList(seatVO); }
	
	@Override
	public SeatVO selectSeat(Integer seat_num) { return ticketMapper.selectSeat(seat_num); }
	
	@Override
	public List<SeatVO> selectSeatByG(Integer grade_num) { return ticketMapper.selectSeatByG(grade_num); }
	
	@Override
	public void updateSeat(SeatVO seatVO) { ticketMapper.updateSeat(seatVO); }
	
	@Override
	public void deleteSeat(Integer grade_num) { ticketMapper.deleteSeat(grade_num); }
	
	@Override
	public Integer selectSeatQuantity(Integer grade_num) { return ticketMapper.selectSeatQuantity(grade_num); }
	
	/* GAME */
	@Override
	public void insertGame(GameVO gameVO) { ticketMapper.insertGame(gameVO); }

	@Override
	public int selectRowCount(GameVO gameVO) { return ticketMapper.selectRowCount(gameVO); }

	@Override
	public List<GameVO> selectTicketGameList(GameVO gameVO) { return ticketMapper.selectTicketGameList(gameVO); }
	
	@Override
	public List<GameVO> selectTicketAdminGameList(GameVO gameVO) { return ticketMapper.selectTicketAdminGameList(gameVO); }

	@Override
	public GameVO selectGame(Integer game_num) { return ticketMapper.selectGame(game_num); }

	@Override
	public void updateGame(GameVO gameVO) { ticketMapper.updateGame(gameVO); }

	@Override
	public MemberDetailVO selectMemberDetail(Integer mem_num) { return ticketMapper.selectMemberDetail(mem_num); }
	
	@Override
	public void updateTicketByGameStatus(Integer game_num) { ticketMapper.updateTicketByGameStatus(game_num); }

	/* Ticket */
	@Override
	public int selectCheckNum() { return ticketMapper.selectCheckNum(); }
	
	@Override
	public void insertTicketCheck(TicketCheckVO ticketCheckVO) { ticketMapper.insertTicketCheck(ticketCheckVO); }
	
	@Override
	public List<TicketCheckVO> selectCheckList(Integer check_num) { return ticketMapper.selectCheckList(check_num); }
	
	@Override
	public void deleteCheck(Integer mem_num, Integer game_num) { ticketMapper.deleteCheck(mem_num, game_num); }
	
	@Override
	public int selectStatusNum() { return ticketMapper.selectStatusNum(); }
	
	@Override
	public void insertSeatStatus(SeatStatusVO seatStatusVO) { ticketMapper.insertSeatStatus(seatStatusVO); }
	
	@Override
	public List<SeatStatusVO> selectStatusByGame(Integer game_num) { return ticketMapper.selectStatusByGame(game_num); }
	
	@Override
	public List<SeatStatusVO> selectStatusBySeat(Integer seat_num) { return ticketMapper.selectStatusBySeat(seat_num); }
	
	@Override
	public int selectCountBySeatNum(Integer game_num, Integer seat_num) { return ticketMapper.selectCountBySeatNum(game_num, seat_num); }

	@Override
	public int selectCountByGradeNum(Integer game_num, Integer grade_num) { return ticketMapper.selectCountByGradeNum(game_num, grade_num); }
	
	@Override
	public int selectAdminCountBySeatNum(Integer seat_num) { return ticketMapper.selectAdminCountBySeatNum(seat_num); }

	@Override
	public int selectAdminCountByGradeNum(Integer grade_num) { return ticketMapper.selectAdminCountByGradeNum(grade_num); }
	
	@Override
	public List<SeatStatusVO> selectSeatInfo(Integer status_num) { return ticketMapper.selectSeatInfo(status_num); }
	
	@Override
	public SeatStatusVO selectSeatInfoIsNull(String seat_info, Integer game_num) { return ticketMapper.selectSeatInfoIsNull(seat_info, game_num); }
	
	@Override
	public void deleteAdminStatus(Integer status_num) { ticketMapper.deleteAdminStatus(status_num); }
	
	@Override
	public void deleteStatus(Integer status_num) { ticketMapper.deleteStatus(status_num); }
	
	@Override
	public void deleteSeatStatusByG(Integer grade_num) { ticketMapper.deleteSeatStatusByG(grade_num); }
	
	@Override
	public void insertTicket(TicketVO ticket) { ticketMapper.insertTicket(ticket); }
	
	@Override
	public void insertTicketDetail(TicketDetailVO ticketDetailVO) { ticketMapper.insertTicketDetail(ticketDetailVO); }

	@Override
	public TicketVO selectTicket(String ticket_num) { return ticketMapper.selectTicket(ticket_num); }
	
	@Override
	public List<TicketDetailVO> selectSeatInfoByT(String ticket_num) { return ticketMapper.selectSeatInfoByT(ticket_num); }
	
	@Override
	public void updateTicket(String ticket_num) { ticketMapper.updateTicket(ticket_num); }

	@Override
	public void updateOrderStatus(String ticket_num) { ticketMapper.updateOrderStatus(ticket_num); }

}
 