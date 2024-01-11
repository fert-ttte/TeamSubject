package com.example.demo.callendar.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

//제너릭 인터페이스
//메소드명은 업무처리 로직에 적합한 이름으로 하자
//메소드의 인자타입은 매퍼 인터페이스의 메소드와 일치시키자
public interface CallendarService<T> {
	//상세보기용
	List<T> selectAll();
	//입력
	int insert(Map map);
	//int update(T record);
	//int delete(T record);
	CallendarDto selectOne(Map map);
	int delete(Map map);
	int update(Map map);
}
