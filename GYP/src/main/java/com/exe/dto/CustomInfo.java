package com.exe.dto;

//세션에 올릴 아이디,패스워드
public class CustomInfo {

	private String sessionId;
	private String sessionpwd;
	private String loginType;
	
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getSessionpwd() {
		return sessionpwd;
	}
	public void setSessionpwd(String sessionpwd) {
		this.sessionpwd = sessionpwd;
	}
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	
	
}
