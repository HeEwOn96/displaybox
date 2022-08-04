package com.forus.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DisplayLoginVO {

	private String user_id;
	private String user_pw;
	private String user_addr;
	private String consumer_id;
	private int g_seq;
	
}