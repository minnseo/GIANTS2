package kr.spring.introduce.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.introduce.vo.PlayerVO;


@Mapper
public interface PlayerMapper {
	//선수
	public void insertPlayer(PlayerVO playerVO);
	public int selectRowCount(Map<String,Object> map);
	public List<PlayerVO> selectPlayerList(Map<String,Object> map);
	@Select("SELECT * FROM player WHERE player_num=#{player_num}")
	public PlayerVO selectPlayer(Integer player_num);
	
	@Update("UPDATE player SET player_name = #{player_name},\n"
			+ "				player_backnumber = #{player_backnumber},\n"
			+ "				player_position = #{player_position},\n"
			+ "				player_birthday = #{player_birthday},\n"
			+ "				player_height = #{player_height},\n"
			+ "				player_weight = #{player_weight},\n"
			+ "				player_toway = #{player_toway},\n"
			+ "				player_join = #{player_join},\n"
			+ "				player_career = #{player_career} WHERE player_num=#{player_num}")
	public void updatePlayer(PlayerVO player);
	
	@Delete("DELETE FROM player WHERE player_num=#{player_num}")
	public void deletePlayer(Integer player_num);
}
