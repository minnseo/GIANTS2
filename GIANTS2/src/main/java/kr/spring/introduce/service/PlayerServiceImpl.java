package kr.spring.introduce.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.introduce.dao.PlayerMapper;
import kr.spring.introduce.vo.PlayerVO;

@Service
@Transactional
public class PlayerServiceImpl implements PlayerService{
	
	@Autowired
	private PlayerMapper playerMapper;
	
	@Override
	public void insertPlayer(PlayerVO playerVO) {
		
		playerMapper.insertPlayer(playerVO);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		
		return playerMapper.selectRowCount(map);
	}

	@Override
	public List<PlayerVO> selectPlayerList(Map<String, Object> map) {
		
		return playerMapper.selectPlayerList(map);
	}



	@Override
	public PlayerVO selectPlayer(Integer player_num) {
		
		return playerMapper.selectPlayer(player_num);
	}

	@Override
	public void updatePlayer(PlayerVO playerVO) {
		
		playerMapper.updatePlayer(playerVO);
	}

	@Override
	public void deletePlayer(Integer player_num) {
		
		playerMapper.deletePlayer(player_num);
	}

}
