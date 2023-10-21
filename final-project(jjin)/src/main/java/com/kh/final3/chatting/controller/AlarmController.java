//package com.kh.final3.chatting.controller;
//
//import org.springframework.messaging.handler.annotation.DestinationVariable;
//import org.springframework.messaging.handler.annotation.MessageMapping;
//import org.springframework.messaging.simp.SimpMessageSendingOperations;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import com.fasterxml.jackson.annotation.JsonFormat;
//
//import lombok.RequiredArgsConstructor;
//
//@Controller
//@RequiredArgsConstructor
//@JsonFormat(pattern)
//public class AlarmController {
//
//	private final SimpMessageSendingOperations messagingTemplate;
//	
//	@GetMapping("/alarm/stomp")
//	public String stompAlarm() {
//		return "/stomp";
//	}
//	
//	@MessageMapping("/{userId}")
//	public void message(@DestinationVariable("userId")Long userId) {
//		messagingTemplate.convertAndSend("/sub/"+userId,"alarm socket connection comoleted");
//	}
//}
