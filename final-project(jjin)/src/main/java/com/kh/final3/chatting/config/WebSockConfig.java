package com.kh.final3.chatting.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import lombok.extern.slf4j.Slf4j;


	@Slf4j
	@Configuration
	@EnableWebSocketMessageBroker
	public class WebSockConfig implements WebSocketMessageBrokerConfigurer {

		
		
	    //private final StompHandler stompHandler;
		
//		private TaskScheduler messageBrokerTaskScheduler;
//		@Autowired
//		public void setMessageBrokerTaskScheduler(@Lazy TaskScheduler taskScheduler) {
//			this.messageBrokerTaskScheduler = taskScheduler;
//		}

	    @Override
	    public void configureMessageBroker(MessageBrokerRegistry config) {
	    	log.info("configureMessageBroker 실행 "+config);
	    	
	        config.enableSimpleBroker("/getter","/one"); //subscribe
	              
	        config.setApplicationDestinationPrefixes("/setter"); //publish
	    }

	    @Override
	    public void registerStompEndpoints(StompEndpointRegistry registry) {
	    	log.info("registerstompendpoints 실행"+registry);
	        registry.addEndpoint("/ws-stomp")
	        .setAllowedOrigins("*")
	                .withSockJS()
	                .setHeartbeatTime(60_000); // sock.js를 통하여 낮은 버전의 브라우저에서도 websocket이 동작할수 있게 합니다.
	    }

	    // http 세션과 websocket 세션이 다르기 때문에 서로의 데이터에 접근할수 없어 인터센터 추가
	    ///차단
//	    @Override
//	    public void configureClientInboundChannel(ChannelRegistration registration) {
//	        registration.interceptors(stompHandler);
//	    }
	}

