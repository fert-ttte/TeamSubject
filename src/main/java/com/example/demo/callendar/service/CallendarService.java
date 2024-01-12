package com.example.demo.callendar.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface CallendarService<T> {
	//상세보기용
	List<T> selectAll();
	//입력
	int insert(Map map);
	CallendarDto selectOne(Map map);
	int delete(Map map);
	int update(Map map);
}
