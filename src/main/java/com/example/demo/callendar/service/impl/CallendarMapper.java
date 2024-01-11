package com.example.demo.callendar.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.callendar.service.CallendarDto;



@Mapper
public interface CallendarMapper {
	
	//전체 조회
	List<CallendarDto> findAll();
	//저장
	int save(Map map);
	
	CallendarDto findOne(Map map);
	int deleteByKey(Map map);
	int updateByKey(Map map);
	
}
