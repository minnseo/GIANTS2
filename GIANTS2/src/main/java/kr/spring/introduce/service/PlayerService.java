package kr.spring.introduce.service;

import java.util.List;
import java.util.Map;


import kr.spring.introduce.vo.PlayerVO;

public interface PlayerService {
	//선수
	public void insertPlayer(PlayerVO playerVO);
	public int selectRowCount(Map<String,Object> map);
	public List<PlayerVO> selectPlayerList(Map<String,Object> map);
	public PlayerVO selectPlayer(Integer player_num);
	public void updatePlayer(PlayerVO playerVO);
	public void deletePlayer(Integer player_num);
}
