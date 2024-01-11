package com.example.demo.callendar.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.callendar.service.CallendarDto;
import com.example.demo.callendar.service.CallendarService;
@Service
public class CallendarServiceImpl implements CallendarService<CallendarDto> {
	
	//매퍼 인터페이스 주입
	@Autowired
	private CallendarMapper mapper;
	
	@Override
	public List<CallendarDto> selectAll() {
		return mapper.findAll();
	}

	@Override
	public int insert(Map map) {
		
		return mapper.save(map);
	}

	@Override
	public CallendarDto selectOne(Map map) {

		return mapper.findOne(map);
	}
	
	@Override
	public int delete(Map map) {
		// TODO Auto-generated method stub
		return mapper.deleteByKey(map);
	}

	@Override
	public int update(Map map) {
		System.out.println("map"+map);
		return mapper.updateByKey(map);
	}
	
	
	/*

	@Override
	public int update(Object record) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	*/

}
