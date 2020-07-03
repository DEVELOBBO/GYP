package com.exe.gyp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exe.dao.GypDAO;
import com.exe.util.MyUtil;

@Controller
public class gypController {

	@Autowired
	@Qualifier("gypDAO")
	GypDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@RequestMapping(value="/", 
					method = {RequestMethod.GET, RequestMethod.POST})
	public String home() {
		return "home";
	}
	
}
