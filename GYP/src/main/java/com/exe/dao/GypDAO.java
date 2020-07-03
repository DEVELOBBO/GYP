package com.exe.dao;

import org.mybatis.spring.SqlSessionTemplate;

public class GypDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate; 
	}
	
	

}
