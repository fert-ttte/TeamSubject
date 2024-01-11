package com.example.demo.callendar.service;

import org.apache.ibatis.type.Alias;
import javax.persistence.Column;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("callendarDto")
public class CallendarDto {

	private String no;
	private String title;
	private java.sql.Timestamp start_;
	private java.sql.Timestamp  end_;
	private String alram;
}
/*
{
  "title":"동아리 활동",
  "start_":"2024-01-7  09:20:00",
  "end_":"2024-01-7  09:20:00",#이건 없어도 됨
  "alram":"F"

}
 */