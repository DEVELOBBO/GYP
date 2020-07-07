package com.exe.gyp;

import java.net.URLDecoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exe.dao.GypDAO;
import com.exe.dto.CustomInfo;
import com.exe.dto.CustomerDTO;
import com.exe.dto.GymDTO;
import com.exe.dto.ReviewDTO;
import com.exe.util.MyUtil;

@Controller
public class gypController {

	@Autowired
	@Qualifier("gypDAO")
	GypDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	//home
	@RequestMapping(value="/", 
					method = {RequestMethod.GET, RequestMethod.POST})
	public String home(HttpServletRequest request,HttpSession session) {
		
		//세션에 올라온값 확인
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
				
		//값에 따라 마이페이지 타입을 바꾸기 위해
		request.setAttribute("info", info);
		return "home";
	}
	
	//*******************원도현*******************
	
	//로그인 화면 
	@RequestMapping(value = "/login.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String login() {
		return "login/login";
	}
	
	//로그인시 
	@RequestMapping(value = "/login_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String login_ok(HttpServletRequest request) throws Exception{
		
		HttpSession session = request.getSession(); //세션 생성
		CustomInfo info = new CustomInfo(); //세션값을 저장하기 위해 객체 생성
		
		String sessionId = request.getParameter("sessionId");//input 입력한값 
		String sessionpwd = request.getParameter("sessionpwd");
		
		int result = dao.getDataCount(sessionId);//유저로 로그인하면 result값은 1 gym으로 로그인 하면 0 
		String loginType = null; //customer 인지, gym인지 저장
		
		if(result == 1 ) {// 유저가 로그인
			CustomerDTO dto = dao.getLoginReadData(sessionId);
			loginType = "customer";
			if (dto == null || !dto.getCusPwd().equals(sessionpwd)) { 
				request.setAttribute("message", "아이디 또는 패스워드를 정확히 입력하세요! ");
				return "login/login";
			}
			
		}else if (result == 0){//체육관 로그인 ( 체육관 로그인시 바로 마이페이지 이동)
			GymDTO dto = dao.getGymLoginReadData(sessionId);
			loginType = "gym";
			if (dto == null || !dto.getGymPwd().equals(sessionpwd)) { 
				request.setAttribute("message", "아이디 또는 패스워드를 정확히 입력하세요! ");
				return "login/login";
			}
		}
		
		info.setSessionId(sessionId); //세션에 값 입력
		info.setSessionpwd(sessionpwd);
		info.setLoginType(loginType);//로그인 타입(customer, gym )
		session.setAttribute("customInfo", info); // 세션에 info에 들어가있는정보(userid,username)이 올라간다.
		
		if(loginType=="customer") {
			return "redirect:/";
		}else{
			return "redirect:/gymMyPage.action";
		}
		
	}
	
	
	//유저 로그아웃
	@RequestMapping(value = "/logout.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String logout_ok(HttpServletRequest request,HttpSession session,CustomerDTO dto) throws Exception{
		
		//로그아웃시 세션 제거 
		session.removeAttribute("customInfo"); // customInfo 안에 있는 데이터를 지운다
		session.invalidate(); // customInfo 라는 변수도 지운다.
		return "login/login";
	}
	
	//유저 패스워드 보여주기창
	@RequestMapping(value = "/searchpw.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String searchpw() {
		
		return "login/searchpw";
	}
	
	//유저 패스워드 찾기
	@RequestMapping(value = "/searchpw_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String searchpw_ok(HttpServletRequest request) throws Exception{
		
		String cusId = request.getParameter("cusId");
		String custel = request.getParameter("custel");
		CustomerDTO dto = dao.getLoginReadData(cusId);
		
		if (dto == null || !dto.getCusTel().equals(custel)) { // 아이디가 틀리거나 전화번호가 틀린경우
			request.setAttribute("message", "아이디 또는 전화번호가 일치하지 않습니다"); 
			return "login/searchpw";

		} else if (dto.getCusId().equals(cusId) || dto.getCusTel().equals(custel)) {
			request.setAttribute("message", "비밀번호는 [" + dto.getCusPwd() + "] 입니다");

		}
		return "login/login";
	}
	
	//유저 아이디 찾는 보여주는창 
	@RequestMapping(value = "/searchid.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String searchid() {
		
		return "login/searchid";
	}
	
	//유저 아이디 찾기
	@RequestMapping(value = "/searchid_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String searchid_ok(HttpServletRequest request) throws Exception{
		
		String cusName = request.getParameter("cusName");
		String cusTel = request.getParameter("cusTel");
		
		Map<String, Object> hMap = new HashMap<String,Object>();
		hMap.put("cusName", cusName);
		hMap.put("cusTel", cusTel);
		
		//아이디 찾기는 이름으로 검색하기 때문에 이름으로 검색하는 dao를 하나더 만들어준다
		CustomerDTO dto = dao.getLoginIdReadData(hMap);
		
		if (dto == null || !dto.getCusTel().equals(cusTel)) { // 이름가 틀리거나 전화번호가 틀린경우
			request.setAttribute("message", "이름 또는 전화번호가 일치하지 않습니다"); ////
			return "login/searchid";
			
		} else if (dto.getCusName().equals(cusName) || dto.getCusTel().equals(cusTel)) {
			request.setAttribute("message", "이름는 [" + dto.getCusId() + "] 입니다");
		}
		return "login/login";
	}
	
	//User 마이페이지
	@RequestMapping(value = "/customerMyPage.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String customerMyPage(HttpServletRequest request,HttpSession session) {
		
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		CustomerDTO dto = dao.getReadData(info);//디비에서 불러옴
		
		request.setAttribute("dto", dto);
		return "myPage/customerMyPage";
	}
	
	//GYM 마이페이지
	@RequestMapping(value = "/gymMyPage.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String gymMyPage(HttpServletRequest request,HttpSession session) {
			
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		GymDTO dto = dao.getgymReadData(info);
		
		request.setAttribute("dto", dto);
		return "myPage/gymMyPage";
	}
	
	// 유저 수정창
	@RequestMapping(value = "/customerUpdate.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String customerUpdate(HttpServletRequest request,HttpSession session) {
		
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		CustomerDTO dto = dao.getReadData(info);
		
		request.setAttribute("dto", dto);
		return "myPage/customerUpdate";
	}
	
	// 유저 정보 수정 (비밀번호 변경)
	@RequestMapping(value = "/customerUpdate_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String customerUpdate_ok(HttpServletRequest request,HttpSession session,CustomerDTO dto) {
		
		dao.updateData(dto);
		request.setAttribute("dto", dto);
		
		return "login/test";
	}
	
	// 유저 정보 수정 (삭제)
	@RequestMapping(value = "/customerDeleted_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String customerDeleted_ok(HttpServletRequest request,CustomerDTO dto,HttpSession session) {
		
		dao.deleteData(dto);
		
		//삭제시 세션제거
		session.removeAttribute("customInfo"); // customInfo 안에 있는 데이터를 지운다
		session.invalidate(); // customInfo 라는 변수도 지운다.

		// 임시 회원탈퇴시 로그인창으로 넘어가기 
		return "login/login";
	}
	
	
	
	//*******************김세이*******************
	
	// 체육관 상세 페이지 
	@RequestMapping(value="/gymDetail.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String gymDetail(HttpServletRequest request) throws Exception {
		
		//String cp = request.getContextPath();
		String gymId = request.getParameter("gymId");
		
		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		
		if(searchKey != null)
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		// 트레이너 리스트 
		GymDTO gymDto = dao.getGymData(gymId);
		
		List<String> gymTrainer = Arrays.asList(gymDto.getGymTrainer().split(","));
		List<String> gymTrainerPic = Arrays.asList(gymDto.getGymTrainerPic().split(","));

		// 결제/매장 찜?? 여기 말고.. 
		 
		// 체육관 사진
		List<String> gymPic = Arrays.asList(gymDto.getGymPic().split(","));
		
		// 이용 가능 시설
		List<String> gymFacility = Arrays.asList(gymDto.getGymFacility().split(","));
		
		// 이용 시간 - 평일, 토요일, 주말
		List<String> gymHour = Arrays.asList(gymDto.getGymHour().split(","));
		
		// 체육관 주소 + 지도
		
		// request set
		request.setAttribute("gymDto", gymDto);
		request.setAttribute("gymTrainer", gymTrainer);
		request.setAttribute("gymTrainerPic", gymTrainerPic);
		request.setAttribute("gymPic", gymPic);
		request.setAttribute("gymFacility", gymFacility);
		request.setAttribute("gymHour", gymHour);
		
		return "gymDetail/gymDetail";
	}

		
	// 리뷰 추가 : 체육관 상세페이지 리뷰 추가 (ajax)
	@RequestMapping(value="/reviewCreated.action")
	public String reviewCreated(HttpServletRequest request, ReviewDTO dto) throws Exception {
		int numMax = dao.getReviewNumMax(); //삽입용 전체 리뷰 최댓값
		
		dto.setReNum(numMax+1);
		dto.setReType("gym");
		
		/*System.out.println("-------debug-------");
		System.out.println("reNum: " + dto.getReNum());
		System.out.println("reType: " + dto.getReType());
		System.out.println("cusId: " + dto.getCusId());
		System.out.println("gymId: " + dto.getGymId());
		System.out.println("reContent: " + dto.getReContent());
		System.out.println("star: " + dto.getStar());*/
		
		dao.insertReviewData(dto);
		
		String gymId = dto.getGymId();
		
		//return reviewList(request,gymId);	//리다이렉팅 안하고 메소드로 가야 한다. 왜? ajax이므로 새로고침하면 안된다. 
		//이전에는 리다이렉팅을 통해 페이지 이동이므로 새로고침이 들어갔다. 
		return reviewList(request,gymId);
	}
		
	// 리뷰 리스트 : 체육관 상세페이지 리뷰 리스트 (ajax)
	@RequestMapping(value="/reviewList.action", method={RequestMethod.GET, RequestMethod.POST})
	public String reviewList(HttpServletRequest request, String gymId) throws Exception{
		
		if(gymId==null||gymId.equals("")) {
			gymId = request.getParameter("gymId");
		}
		
		int numPerPage = 3;
		int totalPage = 0;
		int totalDataCount = 0;
		
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null && pageNum!=""){
			currentPage = Integer.parseInt(pageNum);
		} else {
			pageNum = "1";
		}
		
		//전체 데이터 갯수
		totalDataCount = dao.getReviewNum(gymId);
		
		if(totalDataCount!=0) {
			totalPage = myUtil.getPageCount(numPerPage, totalDataCount);
		}
		
		if(currentPage>totalPage) {
			currentPage = totalPage;
		}
		
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("gymId",gymId);
		
		List<ReviewDTO> lists = dao.getReviewList(hMap);
		
		Iterator<ReviewDTO> it = lists.iterator();
		
		while(it.hasNext()) {
			ReviewDTO vo = (ReviewDTO)it.next();
			vo.setReContent(vo.getReContent().replaceAll("\n", "<br/>"));
		}
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage);
		
		request.setAttribute("reviewLists", lists);
		request.setAttribute("pageIndexList",pageIndexList);
		request.setAttribute("totalDataCount",totalDataCount);
		request.setAttribute("pageNum",pageNum);
		
		return "gymDetail/reviewList";
	}
}
