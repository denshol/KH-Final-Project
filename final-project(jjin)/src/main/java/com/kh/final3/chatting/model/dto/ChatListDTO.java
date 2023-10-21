package com.kh.final3.chatting.model.dto;

package com.kh.final3.chatting.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
public class ChatListDTO {
	
	private int c_idx; // 채팅룸번호
	private int room_idx; //룸번호
	private String h_userid ; //호스트 아이디
	private String userid ; //게스트 아이디
	private String filename; //저장 파일이름
	private Date create_date; //생성시간
	private String h_name; //호스트 이름
	private String user_name; //게스트 이름
	private int chat_read_user;     
	private int chat_read_host;
	private int chatRoomRead;
	//임의생성
	private String content; //채팅내용
	private String sendTime; //작성시간
	private String senderName; //작성자이름
	private String senderId; //작성자아이디
	private String room_name; //룸이름
	private String photo1;
	


}
