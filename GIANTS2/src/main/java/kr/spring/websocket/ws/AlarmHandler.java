package kr.spring.websocket.ws;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlarmHandler extends TextWebSocketHandler{
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
	/*
	 * 클라이언트가 연결되면 클라이언트와 관련된 WebSocketSession을 users 맵에 저장
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		log.debug(new Date() + " : " + session.getId() + " 연결됨");
		users.put(session.getId(), session);
	}
	
	/*
	 * 클라이언트와의 연결이 종료됨
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		log.debug(new Date() + " : " + session.getId() + " 연결 종료됨" );
		users.remove(session.getId());
	}
	
	/*
	 * 클라이언트가 전송한 메시지를 users 맵에 보관한 전체 WebSocketSession에 다시 전달
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		log.debug(new Date() + " : " + session.getId() + "로부터 메시지 수신 : " + message.getPayload());
		
		for(WebSocketSession s : users.values()) {
			s.sendMessage(message);
			log.debug(new Date() + " : " + s.getId() + "에 메시지 발송 : " + message.getPayload());
		}
	}
	
	@Override												 //exception의 부모, 예외 객체를 받음
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception{
		log.debug(new Date() + " : " + session.getId() + " 예외 발생 : " + exception.getMessage());
	}
}
