package com.kh.final3.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int boardNo;
	private String boardWriter;
	private String categoryCode;
	private String boardTitle;
	private String boardContent;
	private String createDate;
	private Date modifyDate;
	private int count;
	private String status;
	private String importanceLevel;
	private String deptName;
	private String attachmentNo; // 泥⑤��뙆�씪 �뿬遺�
	private int refUno; // 利먭꺼李얘린�뿬遺�
}
