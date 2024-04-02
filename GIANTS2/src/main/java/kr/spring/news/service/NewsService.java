package kr.spring.news.service;

import java.util.List;
import java.util.Map;

import kr.spring.news.vo.NewsVO;

public interface NewsService {
	public List<NewsVO> selectNewsList(Map<String, Object> map);
	public int selectNewsCount(Map<String, Object> map);
	public void insertNews(NewsVO news);
	public NewsVO selectNews(Integer news_num);
	public void updateHit(Integer news_num);
	public void updateNews(NewsVO news); 
	public void deleteNews(Integer news_num);
	
	public List<NewsVO> selectNewsForMain(NewsVO newsVO);
}
