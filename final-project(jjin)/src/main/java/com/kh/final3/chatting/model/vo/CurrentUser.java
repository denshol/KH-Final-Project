package com.kh.final3.chatting.model.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CurrentUser {
	
	private Long currentUserId;
	private String currentUserName;
	private String currentUserEmail;
	
	private Collection<GrantedAuthority> role;

}
