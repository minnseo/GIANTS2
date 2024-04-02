package kr.spring.news.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.news.dao.NewsMapper;
import kr.spring.news.vo.NewsVO;

@Service
@Transactional
public class NewsServiceImpl implements NewsService{
	
	@Autowired
	NewsMapper newsMapper;
	 
	@Override
	public List<NewsVO> selectNewsList(Map<String, Object> map) {
		return newsMapper.selectNewsList(map);
	}

	@Override
	public int selectNewsCount(Map<String, Object> map) {
		return newsMapper.selectNewsCount(map);
	}

	@Override
	public void insertNews(NewsVO news) {
		newsMapper.insertNews(news);
	}

	@Override
	public NewsVO selectNews(Integer news_num) {
		return newsMapper.selectNews(news_num);
	}

	@Override
	public void updateHit(Integer news_num) {
		newsMapper.updateHit(news_num);
	}

	@Override
	public void updateNews(NewsVO news) {
		newsMapper.updateNews(news); 
	}

	@Override
	public void deleteNews(Integer news_num) {
		newsMapper.deleteNews(news_num);
	}

	@Override
	public List<NewsVO> selectNewsForMain(NewsVO newsVO) {
		// TODO Auto-generated method stub
		return newsMapper.selectNewsForMain(newsVO);
	}

}
