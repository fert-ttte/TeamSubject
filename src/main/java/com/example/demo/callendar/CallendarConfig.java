package com.example.demo.callendar;

import java.io.IOException;

import javax.sql.DataSource;


import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.Alias;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(value = {"com.example.demo.callendar.service.impl"},sqlSessionFactoryRef ="sqlSessionFactory" )
public class CallendarConfig {
	private final ApplicationContext applicationContext;
	public CallendarConfig(ApplicationContext applicationContext) {
		this.applicationContext=applicationContext;
	}
	
	@Bean
	SqlSessionFactory sqlSessionFactory(DataSource dataSource) {
		SqlSessionFactory factory=null;
		try {
			SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
			factoryBean.setDataSource(dataSource);
			factoryBean.setTypeAliasesPackage("com.example.demo");
			factoryBean.setMapperLocations(applicationContext.getResources("classpath:mybatis/mapper/*.xml"));
			//SqlSessionFactoryBean의 getObject()로 SqlSessionFactory객체 얻기
			factory=factoryBean.getObject();
		
		}
		catch(Exception e) {e.printStackTrace();}
		return factory;
	}/////////////////
	@Bean
	SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
	
}
