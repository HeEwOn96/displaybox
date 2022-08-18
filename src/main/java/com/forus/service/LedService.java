package com.forus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forus.domain.ledVO;
import com.forus.mapper.UserMapper;

@Service
public class LedService {
	@Autowired UserMapper mapper;

	public int UpdateLed(int led_id, int led_status) {
		return mapper.UpdateLed(led_id, led_status);
	}
	
	public List<ledVO> dataLed(){
		return mapper.dataLed();
	}
}
