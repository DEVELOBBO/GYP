package com.exe.gyp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.exe.dao.GypDAO;
import com.exe.dto.BookDTO;
import com.exe.dto.CustomInfo;
import com.exe.dto.CustomerDTO;
import com.exe.dto.GymDTO;
import com.exe.dto.JjimDTO;
import com.exe.dto.ReviewDTO;
import com.exe.util.MyUtil;
import com.exe.util.MyUtil_Map;
import com.exe.dto.NoticeDTO;
import com.exe.dto.ProductDTO;
import com.exe.dto.QnaDTO;

@Controller
public class gypController {

	@Autowired
	@Qualifier("gypDAO")
	GypDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@Autowired
	MyUtil_Map myUtilMap;
	
	//*******************최보경*******************
	
	//home
	@RequestMapping(value="/",method = {RequestMethod.GET, RequestMethod.POST})
	public String home(HttpServletRequest request,HttpSession session) {
		
		//세션에 올라온값 받기
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		
		//체육관 추천 리스트 선언 ------------------------------------------
		List<GymDTO> gymRecommendLists = null;
		
		//로그인되어 있지 않으면 "강남구" 리스트 추천
		if(info==null) {
			gymRecommendLists = dao.getGymRecommendDefault();
		
		}else if(info!=null) {//로그인 되어 있으면 "회원주소 주변" 리스트
			String customerAddr = dao.getCusAddr(info.getSessionId()); //회원주소 추출
			
			//"구"를 자름
			customerAddr = customerAddr.substring(customerAddr.indexOf("구")-2, customerAddr.indexOf("구")+1); 
			//해당 "구"의 체육관 리스트
			gymRecommendLists = dao.getGymRecommend(customerAddr);
			//체육관 리스트가 널인 경우, 기본 리스트로 대체
			if(gymRecommendLists == null) {
				gymRecommendLists = dao.getGymRecommendDefault();
			}
		}
		
		//확장for문, 하나씩 꺼내서 글자길이 수정
		for(GymDTO show : gymRecommendLists) {
			
			int start = show.getGymName().indexOf("(");
			
			if(start>0) { //괄호가 존재하면
				show.setGymName(show.getGymName().substring(0, start)); //괄호부터 끝까지 자르고 다시 set
			}
			if(show.getGymProgram().length() > 13) { //프로그램 길면 자르기
				show.setGymProgram(show.getGymProgram().substring(0, 13) + " ...");
			}
		}

		//상품 추천 리스트 선언 ------------------------------------------
		List<ProductDTO> productRecommendLists = null;
		String productType = null;
		String gymType = null;
		
		if(info==null) {//로그인 되어있지 않으면 "조회순" 리스트 추천
			productRecommendLists = dao.getProductRecommendDefault();
			
		}else if(info!=null) {//로그인 되어 있으면
			
			//최신 예약한 체육관 타입 추출
			gymType = dao.getCusRecentBookType(info.getSessionId());
			
			System.out.println(gymType + "짐타입");
			
			//최신 예약한 체육관 타입이 존재하면
			if(gymType != null) {
				
				
				
				System.out.println(gymType + "짐타입");
				
				if(gymType.equals("헬스")) {
					productType = "H";
				}else if(gymType.equals("필라테스")) {
					productType = "P";
				}else if(gymType.equals("요가")) {
					productType = "Y";
				}
				//producId의 첫글자가 같은것만 디비에서 추출 (조회순)
				productRecommendLists = dao.getProductRecommend(productType);

			//최신 예약이 없으면 default 리스트 추출
			}else if(gymType==null || gymType.equals("")) {
				productRecommendLists = dao.getProductRecommendDefault();
			}
		}	
			
		request.setAttribute("info", info);
		request.setAttribute("gymRecommendLists", gymRecommendLists);
		request.setAttribute("productRecommendLists", productRecommendLists);
		return "home";
	}
	
	//이용방법
	@RequestMapping(value="/howToUse.action",method = {RequestMethod.GET, RequestMethod.POST})
	public String howToUse(HttpServletRequest request) {
		
		return "howToUse/howToUse";
	}
	
	//*******************원도현*******************
	
	//로그인 화면 
	@RequestMapping(value = "/login.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String login() {
		return "login/login";
	}
	
	//로그인시
	@RequestMapping(value = "/login_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String login_ok(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		HttpSession session = request.getSession(); //세션 생성
		CustomInfo info = new CustomInfo(); //세션값을 저장하기 위해 객체 생성
		String history = request.getParameter("history"); //로그인 이전 페이지 기록
		history = history.substring(history.lastIndexOf("/"), history.length()); //주소의 마지막 슬래시 추출
		
		//회원가입 후, 로그인창으로 이동했을때, 로그인하고 이전페이지(회원가입 등)으로 돌아가기 방지
		if(history.equals("/createCustomer.action") || history.equals("/login.action")) {
			history = "/";
		}
		
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
		info.setLoginType(loginType);//로그인 타입(customer, gym )
		session.setAttribute("customInfo", info); // 세션에 info에 들어가있는정보(userid,username)이 올라간다.
		
		if(loginType=="customer") {
	        
			//관리자 로그인
			if(sessionId.equals("admin") || info.getSessionId().equals("admin")) {
				return "redirect:/adminHome.action";
			}
			return "redirect:" + history; //로그인 성공

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
		return "redirect:/";
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
	
	// User 마이페이지
	@RequestMapping(value = "/customerMyPage.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String customerMyPage(HttpServletRequest request, HttpSession session) {

		CustomInfo info = (CustomInfo) session.getAttribute("customInfo");

		// 유저정보
		CustomerDTO cusdto = dao.getReadData(info);

		// 리뷰 아이디값 검색하기 위해
		String reviewId = info.getSessionId();
		// 찜 아이디값 검색하기 위해
		String jjimId = info.getSessionId();
		// 예약 아이디값 검색하기 위해
		String bookId = info.getSessionId();

		// 리뷰리스트
		List<ReviewDTO> reviewlists = dao.reviewgetList(reviewId);
		// 찜리스트
		List<JjimDTO> jjimlists = dao.jjimgetList(jjimId);
		// 예약 리스트
		List<BookDTO> booklists = dao.bookgetList(bookId);

		request.setAttribute("booklists", booklists);
		request.setAttribute("reviewlists", reviewlists);
		request.setAttribute("jjimlists", jjimlists);
		request.setAttribute("cusdto", cusdto);

		return "myPage/customerMyPage";
	}
	
	// GYM 마이페이지
	@RequestMapping(value = "/gymMyPage.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String gymMyPage(HttpServletRequest request, HttpSession session) throws ParseException {

		CustomInfo info = (CustomInfo) session.getAttribute("customInfo");
		
		// 리뷰 아이디값 검색하기 위해
		String reviewId = info.getSessionId();
		// 예약 아이디값 검색하기 위해
		String bookId = info.getSessionId();
		// 체육관 아이디
		String gymId = info.getSessionId();
		//넘어오는값
		String strYear = request.getParameter("year");
		//넘어오는값
		String strMonth = request.getParameter("month");

		
		//캘린더 사용
		Calendar cal = Calendar.getInstance();
		//현재 년도
		int year = cal.get(Calendar.YEAR);
		//현재 월
		int month = cal.get(Calendar.MONTH) + 1;

		
		//넘어오는 값이 없을 경우에, 현재 날짜 넣어줌
		if (strYear == null || strYear.equals(""))
			strYear = Integer.toString(year);
		if (strMonth == null || strMonth.equals(""))
			strMonth = Integer.toString(month);
		
		//숫자로 변환
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
			

		//book타입
		String type = "true";

		//범위 검색하기위한 변수 생성
		String beforemonthdate = "";
		String aftermonthdate = "";

		//달이 7이렇게 넘어오면 안되므로 07 이렇게 넘어와야 하므로 해준 조건식
		if (strMonth.length() == 2) {
			beforemonthdate = year + "-" + (month-1);
		} else if (strMonth.length() == 1) {
			beforemonthdate = year + "-0" + (month-1);
		}
		if (strMonth.length() == 2) {
			aftermonthdate = year + "-" + month;
		} else if (strMonth.length() == 1) {
			aftermonthdate = year + "-0" + month;
		}

		// 체육관 정보
		GymDTO gymdto = dao.getgymReadData(info);

		//데이터 넘겨주기
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("gymId", gymId);
		hMap.put("beforemonthdate", beforemonthdate);
		hMap.put("aftermonthdate", aftermonthdate);
		hMap.put("type", type);// 타입 값 검색하기위해

		// 예약 데이터 개수
		int bookdataCount = dao.bookgetDataCount(hMap);

		// 예약 리스트
		List<BookDTO> gymbooklists = dao.gymbookgetList(bookId);
		// 리뷰리스트
		List<ReviewDTO> gymreviewlists = dao.gymreviewgetList(reviewId);

		////////////////////////////////////////////////////////////////////////

		// 오늘 날짜 구하기
		// 이전버튼키(◀)
		int preYear = year;
		int preMonth = month - 1;
		if (preMonth < 1) {
			preYear = year - 1;
			preMonth = 12;
		}
		// 다음버튼키(▶)
		int nextYear = year;
		int nextMonth = month + 1;
		if (nextMonth > 12) {
			nextYear = year + 1;
			nextMonth = 1;
		}

		////////////////////////////////////////////////////////////////////////

		request.setAttribute("gymbooklists", gymbooklists);
		request.setAttribute("gymreviewlists", gymreviewlists);
		request.setAttribute("gymdto", gymdto);
		request.setAttribute("bookdataCount", bookdataCount);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("preMonth", preMonth);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("preYear", preYear);
		request.setAttribute("nextYear", nextYear);

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
	public String customerUpdate_ok(HttpServletRequest request,HttpSession session,
			CustomerDTO dto, HttpServletResponse response) throws IOException {
		
		dao.updateData(dto);
		request.setAttribute("dto", dto);
		
		return "login/test";
	}
	
	// 유저 정보 수정 (삭제)
	@RequestMapping(value = "/customerDeleted_ok.action" , method = {RequestMethod.GET,RequestMethod.POST})
	public String customerDeleted_ok(HttpServletRequest request,CustomerDTO dto,
			HttpSession session, HttpServletResponse response) throws IOException {
		
		dao.deleteData(dto);
		
		//삭제시 세션제거
		session.removeAttribute("customInfo"); // customInfo 안에 있는 데이터를 지운다
		session.invalidate(); // customInfo 라는 변수도 지운다.
		
		// 임시 회원탈퇴시 로그인창으로 넘어가기 
		return "login/login";
	}
	
	// 체육관 수정창
	@RequestMapping(value = "/gymUpdate.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String gymUpdate(HttpServletRequest request, HttpSession session) {
		// 세션에 올라온값
		CustomInfo info = (CustomInfo) session.getAttribute("customInfo");
		
		GymDTO gymdto = dao.getgymReadData(info);
		request.setAttribute("gymdto", gymdto);
		return "myPage/gymUpdate";
	}

	// 체육관 정보 수정 (비밀번호 변경)
	@RequestMapping(value = "/gymUpdate_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String gymUpdate_ok(HttpServletRequest request, HttpSession session, GymDTO gymdto) {
		dao.gymupdateData(gymdto);
		
		//캘린더 사용
		Calendar cal = Calendar.getInstance();

		//현재 년도
		int nowYear = cal.get(Calendar.YEAR);
		//현재 월
		int nowMonth = cal.get(Calendar.MONTH) + 1;
		
		request.setAttribute("gymdto", gymdto);
		return "redirect:/gymMyPage.action?year="+nowYear+"&month="+nowMonth;
	}
	
	// 체육관 정보 수정 (삭제)
	@RequestMapping(value = "/gymDeleted_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String gymDeleted_ok(HttpServletRequest request, GymDTO dto, HttpSession session) {
		dao.gymdeleteData(dto);
		// 삭제시 세션제거
		session.removeAttribute("customInfo"); // customInfo 안에 있는 데이터를 지운다
		session.invalidate(); // customInfo 라는 변수도 지운다.
		// 임시 회원탈퇴시 로그인창으로 넘어가기
		return "login/login";
	}
	
	
	// 리뷰 삭제
	@RequestMapping(value = "/reviewDelete.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String reviewDelete(HttpServletRequest request, HttpSession session) {
		int reNum = Integer.parseInt(request.getParameter("reNum"));
		dao.reviewdeleteData(reNum);
		return "redirect:/customerMyPage.action";
	}

	// 찜 삭제
	@RequestMapping(value = "/jjimDelete.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String jjimDelete(HttpServletRequest request, HttpSession session) {
		String gymId = request.getParameter("gymId");
		dao.jjimdeleteData(gymId);
		return "redirect:/customerMyPage.action";
	}

	// 예약 삭제
	@RequestMapping(value = "/bookDelete.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String bookDelete(HttpServletRequest request, HttpSession session) {
		int bookNum = Integer.parseInt(request.getParameter("bookNum"));
		dao.bookdeleteData(bookNum);
		return "redirect:/gymMyPage.action";
	}
	
	
	//*******************김세이*******************
	
	// 체육관 상세 페이지 
	@RequestMapping(value="/gymDetail.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String gymDetail(HttpServletRequest request, HttpSession session) throws Exception {
		//세션에 올라온값 확인
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		String cusId = null;
		if(info!=null) {
			request.setAttribute("info", info);
			cusId = info.getSessionId();
			//예약시 사용할 사용자 잔여 pass 정보
			int cusPassLeft = dao.getCusPassLeft(cusId);
			request.setAttribute("cusPassLeft", cusPassLeft);
		}
		
		String gymId = request.getParameter("gymId");
		/*
		 * String searchKey = request.getParameter("searchKey"); 
		 * String searchValue = request.getParameter("searchValue");
		 * 
		 * if(searchKey != null)
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		 */
		
		// 체육관 정보
		GymDTO gymDto = dao.getGymData(gymId);
		
		List<String> gymTrainer = Arrays.asList(gymDto.getGymTrainer().split(","));
		List<String> gymTrainerPic = Arrays.asList(gymDto.getGymTrainerPic().split(","));
		
		/*  
		 * 리뷰 작성 : 회원 세션에 cusId가 올라가있으면서,
		 *  해당 체육관의 Book 목록에 cusId가 있으면서,
		 *  회원이 등록한 리뷰의 수가 book수보다 작을때 입력창 보이게 하기
		 */
		
		// 관련 인기 상품 뿌리기
		List<ProductDTO> productLists = null;
		
		if(gymDto.getGymType().equals("요가")) {
			// productId의 첫글자가 'Y'인 상품 중, productHit가 가장 높은 3개 상품
			// 클릭시 상품 상세 페이지로, 
			// 더보기 링크 클릭시 조건 가지고 검색결과/카테고리 페이지로 
			
			productLists = dao.getProductListForGym("Y");
		} else if (gymDto.getGymType().equals("헬스")){
			productLists = dao.getProductListForGym("H");
		} else if (gymDto.getGymType().equals("필라테스")){
			productLists = dao.getProductListForGym("P");
		} else {
			System.out.println("ERR) NO SUCH GYM TYPE EXISTS");
			return "redirect:/gyp/";
		}

		// 이용 시간 - 평일, 토요일, 주말
		List<String> gymHour = Arrays.asList(gymDto.getGymHour().split(","));
		
		// 예약 시간 뿌리기
		for (int i = 0; i < 3; i++) {
			ArrayList<String> optionTimes = new ArrayList<String>();
			
			int startTime = Integer.parseInt(gymHour.get(i).substring(0,2));
			int endTime = Integer.parseInt(gymHour.get(i).substring(8,10));
			
			for (int j = startTime; j < endTime; j++) {
				String time = j+":00~"+(j+1)+":00";
				optionTimes.add(time);
			}
			request.setAttribute("optionTimes"+i, optionTimes);
		}
		
		// 찜 여부 확인
		if(info!=null) {
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("gymId",gymId);
			hMap.put("cusId", cusId);
			
			int whetherJjim = dao.countJjimData(hMap);
			//System.out.println(whetherJjim);
			request.setAttribute("whetherJjim", whetherJjim);
		}
		 
		// 체육관 사진
		List<String> gymPic = Arrays.asList(gymDto.getGymPic().split(","));
		
		// 이용 가능 시설
		List<String> gymFacility = Arrays.asList(gymDto.getGymFacility().split(","));
		
		// request set
		request.setAttribute("productLists", productLists);
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
	public String reviewCreated(HttpServletRequest request, ReviewDTO dto, HttpSession session) throws Exception {
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		if(info!=null) {
			request.setAttribute("info", info);
		}
		int numMax = dao.getReviewNumMax(); //삽입용 전체 리뷰 최댓값
		
		dto.setReNum(numMax+1);
		dto.setReType("gym");
		dao.insertReviewData(dto);
		
		String gymId = dto.getGymId();
		
		//return reviewList(request,gymId);	//리다이렉팅 안하고 메소드로 가야 한다. 왜? ajax이므로 새로고침하면 안된다. 
		//이전에는 리다이렉팅을 통해 페이지 이동이므로 새로고침이 들어갔다. 
		return reviewList(request,gymId,session);
	}
		
	// 리뷰 리스트 : 체육관 상세페이지 리뷰 리스트 (ajax)
	@RequestMapping(value="/reviewList.action", method={RequestMethod.GET, RequestMethod.POST})
	public String reviewList(HttpServletRequest request, String gymId,HttpSession session) throws Exception{
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		if(info!=null) {
			request.setAttribute("info", info);
		}
		
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
		//전체 평점 평균
		int starAvg = dao.getAvgReview(gymId);
		
		while(it.hasNext()) {
			ReviewDTO vo = (ReviewDTO)it.next();
			vo.setReContent(vo.getReContent().replaceAll("\n", "<br/>"));
		}
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage);
		
		if(info!=null) {
			request.setAttribute("info", info);
			String cusInfo = info.getSessionId();

			//Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("cusId", cusInfo);
			hMap.put("gymId", gymId);
			
			int timesCusBookedGym = dao.getTimesCusBookedGym(hMap);
			request.setAttribute("timesCusBookedGym", timesCusBookedGym);
			
			int timesCusReviewedGym = dao.getTimesCusReviewedGym(hMap);
			request.setAttribute("timesCusReviewedGym", timesCusReviewedGym);
		}
		
		request.setAttribute("starAvg", starAvg);
		request.setAttribute("reviewLists", lists);
		request.setAttribute("pageIndexList",pageIndexList);
		request.setAttribute("totalDataCount",totalDataCount);
		request.setAttribute("pageNum",pageNum);
		
		return "gymDetail/reviewList";
	}

	// 리뷰 삭제 : 체육관 상세페이지 리뷰 삭제 (ajax)
	@RequestMapping(value="/reviewDeleted.action")
	public String reviewDeleted(HttpServletRequest request, ReviewDTO dto,HttpSession session) throws Exception {
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		if(info!=null) {
			request.setAttribute("info", info);
		}
		
		String gymId = dto.getGymId();
		int reNum = dto.getReNum();
		
		//System.out.println("gymId:reviewNum =" + gymId + ":" + reNum);
		
		dao.deleteReviewData(reNum);
		
		return reviewList(request,gymId,session);
	}

	// 체육관 예약 : 체육관 상세페이지에서 예약하기 
	@RequestMapping(value="/gymBook.action")
	public String gymBook(HttpServletRequest request, HttpServletResponse response,
			BookDTO dto,HttpSession session) throws IOException {
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		if(info==null) {//돌발적 로그아웃 대비
			return "redirect:/login.action";
		}
		//사용자 잔여 pass 가져오기
		String cusId = info.getSessionId();
		int cusPassLeft = dao.getCusPassLeft(cusId);
		// 체육관 정보
		GymDTO gymDto = dao.getGymData(dto.getGymId());
			
		String datePick = request.getParameter("datePick");
		String bookHourWd = request.getParameter("bookHourWd");
		String bookHourSat = request.getParameter("bookHourSat");
		String bookHourSun = request.getParameter("bookHourSun");
		String bookHour = "";
		
		if(bookHourWd!=null) {
			bookHour = datePick + "," + bookHourWd;
		}
		if(bookHourSat!=null) {
			bookHour = datePick + "," + bookHourSat;
		}
		if(bookHourSun!=null) {
			bookHour = datePick + "," + bookHourSun;
		}
		
		
		int numMax = dao.getBookNumMax(); //삽입용 전체 예약 최댓값
		
		dto.setBookNum(numMax + 1);
		dto.setCusId(info.getSessionId());
		dto.setBookHour(bookHour);
		
		// 중복 확인
		// gymId와 bookHour gymTrainerPick bookType bookOk가 일치하면 중복이라 간주하고 예약 취소하기
		int checkDuplicateBook = dao.checkDuplicateBook(dto);
		
		if(checkDuplicateBook>0) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('이미 예약된 시간입니다. 다른 시간을 선택해주세요');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		//사용자 pass 수 차감하기
		if(cusPassLeft<gymDto.getGymPass()) {
			//alert후 상세페이지로 돌아가기
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잔여 pass 수가 부족합니다!');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		//사용자 pass수 차감하여 update하기
		cusPassLeft = cusPassLeft - gymDto.getGymPass();
		
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("cusId",cusId);
		hMap.put("cusPass",cusPassLeft);
		
		dao.updateCusPass(hMap);
		
		dao.insertBookData(dto);
		
		return "redirect:/gymBook_ok.action";
	}
	
	// 체육관 예약 완료
	@RequestMapping(value="/gymBook_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String gymBook_ok(HttpServletRequest request, BookDTO dto,HttpSession session) {
		return "gymDetail/gymBook_ok";
	}

	// 체육관 찜하기
	@RequestMapping(value="/gymJjim.action")
	public String gymJjim(HttpServletRequest request, JjimDTO dto,HttpSession session) throws Exception{
			
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			if(info==null) {//돌발적 로그아웃 대비
				return "redirect:/login.action";
			}
			
			String cusId = info.getSessionId();
			
			System.out.println("cusId" + cusId);
			
			String gymId = request.getParameter("gymId");
			System.out.println("gymId" + gymId);
			
			int whetherJjim = Integer.parseInt(request.getParameter("whetherJjim"));
			//int whetherJjim = Integer.parseInt(request.getAttribute("whetherJjim"));
			
			System.out.println("whetherJjim: " + whetherJjim);
			// 찜 추가하기
			if(whetherJjim==0) {
				
				dto.setCusId(cusId);
				dto.setGymId(gymId);
				
				dao.insertJjimData(dto);
				
			} else {
				
				dao.deleteJjimData(gymId);
				
			}
			
			return "redirect:/gymDetail.action?gymId="+gymId;
		}
	
	//*******************서예지*******************
	//-------------------notice-------------------
	
	@RequestMapping(value="/noticeList.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeList(HttpServletRequest request,HttpSession session) throws Exception{
		
		String cp = request.getContextPath();
		session = request.getSession();
		String pageNum = request.getParameter("pageNum");
		int currentPage = 1;
		
		//페이징처리
		if(pageNum == null) {
			pageNum = (String)session.getAttribute("pageNum");
		}
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		int dataCount = dao.getNoticeDataCount();
		int numPerPage = 10; //한 페이지에 10개
	
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		//한 페이지에 뿌릴 리스트 가져옴
		List<NoticeDTO> lists = dao.getNoticeList(start, end); 
		
		//listNum
		int n = 0;
		int listNum = 0;
		Iterator<NoticeDTO> it = lists.iterator();
		while(it.hasNext()) {
			NoticeDTO data = (NoticeDTO)it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}
		
		String listUrl = cp + "/noticeList.action";
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		String articleUrl = cp + "/noticeArticle.action?pageNum=" + currentPage;
		
		request.setAttribute("lists", lists);
		request.setAttribute("pageIndexList",pageIndexList);
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("dataCount",dataCount);
		request.setAttribute("articleUrl",articleUrl);
		
		return "notice/noticeList";
	}
	
	//공지사항 등록 페이지로 가기
	@RequestMapping(value="/noticeCreated.action",method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView noticeCreated(HttpServletRequest request,NoticeDTO dto,
			ProductDTO dto1,HttpSession session) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("notice/noticeCreated");
		request.setAttribute("dto", dto);
		request.setAttribute("mode", "insert");
		return mav;
	}
	
	//공지사항 등록 삽입
	@RequestMapping(value="/noticeCreated_ok.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeCreated_ok(HttpServletRequest request,NoticeDTO dto, HttpSession session) throws Exception{
		
		int noticeNumMax = dao.getNoticeMaxNum();
		dto.setNotiNum(noticeNumMax + 1); 
		dao.insertNotice(dto);
		return "redirect:/noticeList.action";
	}	
	
	//공지사항 게시글
	@RequestMapping(value="/noticeArticle.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeArticle(HttpServletRequest request) throws Exception{
		
		String cp = request.getContextPath();
		
		//넘어오는 값 받아옴
		int notiNum = Integer.parseInt(request.getParameter("notiNum"));
		String pageNum = request.getParameter("pageNum");
		
		//notiNum으로 게시글 DTO 가져옴
		NoticeDTO dto = (NoticeDTO)dao.getNoticeReadData(notiNum);
		
		if(dto == null) {
			return "redirect:/noticeList.action";
		}
		
		//줄바꿈 변형
		dto.setNotiContent(dto.getNotiContent().replaceAll("\r\n", "<br/>"));
		
		//이전글
		NoticeDTO preReadData = (NoticeDTO)dao.getNoticePreReadData(notiNum);
		int preNotiNum = 0;
		String preNotiTitle = "";
		if(preReadData!=null) {
			preNotiNum = preReadData.getNotiNum();
			preNotiTitle = preReadData.getNotiTitle();
		}
		
		//다음글
		NoticeDTO nextReadData = (NoticeDTO)dao.getNoticeNextReadData(notiNum);
		int nextNotiNum = 0;
		String nextNotiTitle = "";
		if(nextReadData!=null) {
			nextNotiNum = nextReadData.getNotiNum();
			nextNotiTitle = nextReadData.getNotiTitle();
		}
		
		String params = "pageNum="+pageNum;
		
		request.setAttribute("dto", dto);
		request.setAttribute("preNotiNum", preNotiNum);
		request.setAttribute("preNotiTitle", preNotiTitle);
		request.setAttribute("nextNotiNum", nextNotiNum);
		request.setAttribute("nextNotiTitle", nextNotiTitle);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("params", params);
		
		return "notice/noticeArticle";
	}
	
	//공지사항 수정페이지로 이동
	@RequestMapping(value="/noticeUpdated.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeUpdate(HttpServletRequest request) throws Exception{
		
		//넘어오는 값 받음
		int notiNum = Integer.parseInt(request.getParameter("notiNum"));
		String pageNum = request.getParameter("pageNum");
		
		//디비에서 수정할 notice객체 받아옴
		NoticeDTO dto = (NoticeDTO)dao.getNoticeReadData(notiNum);
		if(dto==null) {
			return "redirect:/noticeList.action?pageNum=" + pageNum;
		}
		request.setAttribute("mode", "update");
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("dto", dto);
		
		return "notice/noticeCreated";
	}
	
	//공지사항 수정 처리
	@RequestMapping(value="/noticeUpdated_ok.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeUpdated_ok(NoticeDTO dto,HttpServletRequest request,HttpSession session) throws Exception{
		
		//넘어오는 값
		String pageNum = request.getParameter("pageNum");
		//수정
		dao.updateNoticeData(dto);
		
		return "redirect:/noticeList.action?pageNum="+pageNum;
	}	
	
	//공지사항 삭제
	@RequestMapping(value="/noticeDeleted.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String noticeDeleted(HttpServletRequest request) throws Exception{

		//넘어오는 값
		String pageNum = request.getParameter("pageNum");
		int notiNum = Integer.parseInt(request.getParameter("notiNum"));
		//삭제
		dao.deleteNoticeData(notiNum);
		
		return "redirect:/noticeList.action?pageNum="+pageNum;
	}	
		
	//-------------------qna-------------------
	
	//질문게시판 리스트
	@RequestMapping(value="/qnaList.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaList(HttpServletRequest request,HttpSession session) throws Exception{
		
		String cp = request.getContextPath();
		//넘어오는값
		String pageNum = request.getParameter("pageNum");
		String searchValue = request.getParameter("searchValue");
		String searchKey = "qnaType";
		
		//검색
		if(searchValue == null) {
			searchValue = "";
		}else if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue,"UTF-8");
		}
		
		//페이징
		int currentPage = 1;
		int numPerPage = 3;
		
		int dataCount = dao.getQnaDataCount(searchKey,searchValue);
		
		if(pageNum != null)
			currentPage = Integer.parseInt(pageNum);
	
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		//검색 + 한페이지에 뿌릴 qna객체 리스트
		List<QnaDTO> lists = dao.getQnaList(start, end,searchKey,searchValue);
		
		int n=0;
		int listNum=0;
		Iterator<QnaDTO> it = lists.iterator();
		while(it.hasNext()) {
			QnaDTO data = (QnaDTO)it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}
		
		String params = "";
		String listUrl = "";
		String articleUrl = "";
		
		if(!searchValue.equals("")) {
			searchValue = URLEncoder.encode(searchValue,"UTF-8");
			params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
		}
		
		if(params.equals("")) {
			listUrl = cp + "/qnaList.action";
			articleUrl = cp + "/qnaArticle.action?pageNum=" + currentPage;
		}else {
			listUrl = cp + "/qnaList.action?" + params;
			articleUrl = cp + "/qnaArticle.action?pageNum=" + currentPage + "&" + params;
		}
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("lists", lists);
		request.setAttribute("pageIndexList",pageIndexList);
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("dataCount",dataCount);
		request.setAttribute("articleUrl",articleUrl);
		
		return "qna/qnaList";
	}
	
	//질문게시판 작성 페이지로 이동
	@RequestMapping(value="/qnaCreated.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaCreated(HttpServletRequest request,QnaDTO dto,
			HttpSession session) throws Exception{

		String cusId = session.getId();//세션에서 cusId를 불러온다.
		request.setAttribute("mode", "insert");
		request.setAttribute("dto", dto);
		session.setAttribute("cusId", cusId);//cusId를 보낸다.
		return "qna/qnaCreated";
		
		/*ModelAndView mav = new ModelAndView();
		mav.setViewName("/qna/qnaCreated");
		request.setAttribute("dto", dto);
		request.setAttribute("mode", "insert");
		return mav;*/
		
	}
	
	//질문게시판 작성 삽입 처리
	@RequestMapping(value="/qnaCreated_ok.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaCreated_ok(HttpServletRequest request,QnaDTO dto) throws Exception{
		
		int qnaNumMax = dao.getQnaMaxNum();
		dto.setQnaNum(qnaNumMax + 1);
		dao.insertQna(dto);
		return "redirect:/qnaList.action";
		
	}	
	
	//질문게시글 페이지로 이동
	@RequestMapping(value="/qnaArticle.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaArticle(HttpServletRequest request,QnaDTO dto) throws Exception{
		
		int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
		String pageNum = request.getParameter("pageNum");
		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		
		if(searchValue==null) {
			searchKey = "qnaType";
			searchValue = "";
		}
		
		//검색값 인코딩
		if(request.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue,"UTF-8");
		}
		
		//qna 객체 가져오기
		dto = (QnaDTO)dao.getQnaReadData(qnaNum);
		if(dto == null) {
			return "redirect:/qnaList.action";
		}
		
		//줄바꿈
		dto.setQnaContent(dto.getQnaContent().replaceAll("\r\n", "<br/>"));
		
		//이전글
		QnaDTO preReadData = (QnaDTO)dao.getQnaPreReadData(qnaNum,searchKey,searchValue);
		int preQnaNum = 0;
		String preQnaTitle = "";
		if(preReadData!=null) {
			preQnaNum = preReadData.getQnaNum();
			preQnaTitle = preReadData.getQnaTitle();
		}
		
		//다음글
		QnaDTO nextReadData = (QnaDTO)dao.getQnaNextReadData(qnaNum,searchKey,searchValue);
		int nextQnaNum = 0;
		String nextQnaTitle = "";
		if(nextReadData!=null) {
			nextQnaNum = nextReadData.getQnaNum();
			nextQnaTitle = nextReadData.getQnaTitle();
		}
		
		//파람 생성
		String params = "pageNum=" +pageNum;
		if(!searchValue.equals("")) {
			searchValue = URLEncoder.encode(searchValue,"UTF-8");
			params += "&searchKey=" + searchKey + "&searchValue=" + searchValue; 
		}
		
		request.setAttribute("dto", dto);
		request.setAttribute("preQnaNum", preQnaNum);
		request.setAttribute("preQnaTitle", preQnaTitle);
		request.setAttribute("nextQnaNum", nextQnaNum);
		request.setAttribute("nextQnaTitle", nextQnaTitle);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("params", params);
		
		return "qna/qnaArticle";
	}
	
	//질문게시판 수정페이지로 이동
	@RequestMapping(value="/qnaUpdated.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaUpdate(HttpServletRequest request,QnaDTO dto) throws Exception{

		//넘어오는 값
		int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
		String pageNum = request.getParameter("pageNum");
		
		//수정할 객체 가져옴
		dto = (QnaDTO)dao.getQnaReadData(qnaNum);
		if(dto==null) {
			return "redirect:/qnaList.action?pageNum=" + pageNum;
		}
		request.setAttribute("mode", "update");
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("dto", dto);
		
		return "qna/qnaCreated";
	}
	
	//질문게시판 수정 처리
	@RequestMapping(value="/qnaUpdated_ok.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaUpdated_ok(QnaDTO dto,HttpServletRequest request,HttpSession session) throws Exception{

		String pageNum = request.getParameter("pageNum");
		dao.updateQnaData(dto);
		return "redirect:/qnaList.action?pageNum="+pageNum;
	}	
	
	//질문게시판 삭제
	@RequestMapping(value="/qnaDeleted.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaDeleted(HttpServletRequest request) throws Exception{

		String pageNum = request.getParameter("pageNum");
		int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
		dao.deleteQnaData(qnaNum);
		return "redirect:/qnaList.action?pageNum="+pageNum;
	}	
	
	//질문게시판 답글쓰기
	@RequestMapping(value="/qnaReply.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String qnaReply(HttpServletRequest request,QnaDTO dto) throws Exception{
		
		//넘어오는값
		String pageNum = request.getParameter("pageNum");
		int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
		
		//따로 넘어오지 않으면, qnaNum으로 디비에서 가져온다
		if(dto==null || dto.getMode()==null || dto.getMode().equals("")) {
			
			dto = (QnaDTO)dao.getQnaReadData(qnaNum);
			
			String temp = "\r\n\r\n----------------------------------------\r\n\r\n";
			temp += "[답변]\r\n";
			
			//답변 데이터 읽어옴 " 부모 데이터 밑줄 후 답변
			dto.setQnaTitle("[답변]" + dto.getQnaTitle());
			dto.setQnaContent(dto.getQnaContent() + temp);
				
			return "redirect:/qnaCreated.action?pageNum="+pageNum; //created.jsp창으로 넘어감
		}	
		
		//--------------답변처리---------------
		//orderNo 변경
		String qnaGroupNum = request.getParameter("qnaGroupNum");
		String qnaOrderNo = request.getParameter("qnaOrderNo");
		dao.orderNoUpdate(qnaGroupNum,qnaOrderNo);
				
		//답변 입력
		int maxNum = dao.getQnaMaxNum();
		dto.setQnaNum(maxNum + 1);
		dto.setQnaDepth(dto.getQnaDepth()+1);
		dto.setQnaOrderNo(dto.getQnaOrderNo() + 1); //자신의 orderNo 업데이트
		dao.insertQna(dto);
				
		return "redirect:/qnaList.action?pageNum="+pageNum;
	}

	//*******************채종완*******************
	
	//회원가입 유형 2가지 중 선택하는 페이지로 이동
	@RequestMapping(value = "/create.action")
	public String create() {
		return "create/create";
	}
	
	//개인 회원가입 페이지로 이동
	@RequestMapping(value = "/createCustomer.action")
	public ModelAndView createCustomer() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("create/createCustomer");
		return mav;
	}
	
	//개인 회원가입 완료 (삽입)
	//@ResponseBody
	@RequestMapping(value = "/createCustomer_ok.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String createCustomer_ok(HttpServletRequest request,CustomerDTO dto,
			HttpServletResponse response) throws Exception{
		
		dao.cusCreated(dto);
		return "redirect:/login.action";
	}
	
	//체육관 회원가입 페이지로 이동
	@RequestMapping(value = "/createGym.action")
	public ModelAndView createGym() {
		ModelAndView mav = new ModelAndView();
 		mav.setViewName("create/createGym");
 		return mav;
	}
	
	//체육관 회원가입 완료 (삽입 + 파일업로드)
	//체육관 회원가입 완료 후 처리
	@RequestMapping(value = "/createGym_ok.action",method = {RequestMethod.GET,RequestMethod.POST})
	public String createGym_ok(HttpServletRequest request,GymDTO dto, HttpServletResponse response,
			String hidden1, MultipartHttpServletRequest multiReq, String str)throws Exception{
		
		//경로생성	
		String path = multiReq.getSession().getServletContext().getRealPath("/resources/img/gymTrainerPic/");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdir();//경로 체크 후, 없으면 생성
		}
		
		//---------트레이너 이름 합치기---------
		String gymTrainer1 = request.getParameter("gymTrainer1");
		String gymTrainer2 = request.getParameter("gymTrainer2");
		String gymTrainer3 = request.getParameter("gymTrainer3");
		String gymTrainer4 = request.getParameter("gymTrainer4");
		String gymTrainer = "";
		
		if(gymTrainer1!=null) {
			gymTrainer += gymTrainer1 + ",";
		}
		if(gymTrainer2!=null) {
			gymTrainer += gymTrainer2 + ",";
		}
		if(gymTrainer3!=null) {
			gymTrainer += gymTrainer3 + ",";
		}
		if(gymTrainer4!=null) {
			gymTrainer += gymTrainer4;
		}
		
		//마지막글자
		String lastWord = gymTrainer.substring(gymTrainer.length()-1, gymTrainer.length());
		
		//마지막 쉼표면, 쉼표 빼고 dto에 setting
		while(lastWord.equals(",")) {
			gymTrainer = gymTrainer.substring(0, gymTrainer.length()-1);
			lastWord = gymTrainer.substring(gymTrainer.length()-1, gymTrainer.length());//마지막 글자 다시 세팅
		}
		dto.setGymTrainer(gymTrainer);

		//---------트레이너 파일 합치기---------

		//파일 리스트 생성
		Iterator<String> files = multiReq.getFileNames();
		MultipartFile mfile = multiReq.getFile(files.next());
		
		//파일 용량 없음 검사
		if(mfile == null || mfile.getSize() <= 0) {
			System.out.println("파일용량 x"); //v파일 alert
			return "redirect:/";
		}
		
		//html의 upload 가져와서 파일 리스트 생성
		List<MultipartFile> fileList = multiReq.getFiles("upload");
		String gymTrainerPic = "";
		String newFileName = ""; 
		
		//확장 for문으로 하나씩 처리
		for (MultipartFile fileShowOne : fileList) {
			try {
				if(!fileShowOne.getOriginalFilename().equals("")) { //파일 이름이 null이 아니면
					
					//로컬저장용 이름 생성
					newFileName = dto.getGymId() + "-" + fileShowOne.getOriginalFilename();
					
					//DB저장용 파일이름 합침 (아이디로 사진명 중복되지 않게) (예) suzi-트레이너1.jpg
					gymTrainerPic += newFileName + ",";
					
					//fs 생성 및 저장
					FileOutputStream fs = new FileOutputStream(path + newFileName); 
					fs.write(fileShowOne.getBytes());
					fs.close();
				}
			} catch (Exception e) {
				e.toString();
			}
		}
		
		//마지막글자
		lastWord = gymTrainerPic.substring(gymTrainerPic.length()-1, gymTrainerPic.length());
				
		//마지막 쉼표면, 쉼표 빼고 dto에 setting
		while(lastWord.equals(",")) {
			gymTrainerPic = gymTrainerPic.substring(0, gymTrainerPic.length()-1);
			lastWord = gymTrainerPic.substring(gymTrainerPic.length()-1, gymTrainerPic.length());//마지막 글자 다시 세팅
		}
		dto.setGymTrainerPic(gymTrainerPic);

		
		//디비 삽입
		dao.gymCreated(dto);
        
 		return "redirect:/login.action";
			 	
	}

	
	//*******************경기민*******************
	
	//제휴시설 찾기로 이동
	@RequestMapping(value = "/map.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String map(HttpServletRequest req) throws Exception {
		String sessionId = "";
		String cusAddrGoo = "";
		HttpSession httpSession = req.getSession(true);		
		if(httpSession.getAttribute("sessionId")!=null) {
			sessionId = (String)httpSession.getAttribute("sessionId");
			CustomerDTO dto = dao.getCustomerGoo(sessionId);
			cusAddrGoo = dto.getCusAddr();
		}
		String searchKey = "gymName";
		String searchValue = "";
		if(req.getParameter("searchKey")!=null) {
			searchKey = req.getParameter("searchKey");
		}
		if(req.getParameter("searchValue")!=null) {
			searchValue = req.getParameter("searchValue");
		}
		List<GymDTO> lists = dao.getMapList(1, 10000, searchKey, searchValue);
		req.setAttribute("lists", lists);
		req.setAttribute("tempSearchKey", searchKey);
		req.setAttribute("tempSearchValue", searchValue);
		req.setAttribute("mode", "print");
		req.setAttribute("sessionId", sessionId);
		req.setAttribute("cusAddrGoo", cusAddrGoo);
		
		return "map/map";
	}

	//페이징 처리 + 제휴시설 리스트 가져오기
	@RequestMapping(value = "/mapSearchList.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String mapSearchList(HttpServletRequest req) throws Exception {
		
		String cp = req.getContextPath();

		String searchGymAddr = req.getParameter("searchGymAddr");
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;

		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		} else {
			pageNum = "1";
		}
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if (searchKey == null) {
			searchKey = "gymName";
			searchValue = "";
		} else {
			if (req.getMethod().equalsIgnoreCase("GET")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
				searchGymAddr = URLDecoder.decode(searchGymAddr, "UTF-8");
			}
		}
		
		// 검색한 조건의 데이터 갯수
		int dataCount = dao.getMapDataCount(searchKey, searchValue);

		// 페이징
		int numPerPage = 5;
		int totalPage = myUtilMap.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage) {
			currentPage = totalPage;
		}
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		
		List<GymDTO> lists = dao.getMapList(start, end, searchKey, searchValue);
		Iterator<GymDTO> iterator = lists.iterator();
		while (iterator.hasNext()) {
			GymDTO dto = iterator.next();
			String[] hour = dto.getGymHour().split(",");
			String open = "평일 : " + hour[0] + ", 토요일 :" + hour[1] + ", 일요일 : " + hour[2];
			dto.setGymHour(open);
		}
		// URL
		String param = "";
		if (!searchValue.equals("")) {
			param = "searchKey=" + searchKey;
			param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}

		String ajaxPageIndexList = myUtilMap.ajaxPageIndexList(currentPage, totalPage, searchKey, searchValue);
		//
		String searchGymAddrUrl = cp + "/map.action?searchGymAddr=";
		
		
		req.setAttribute("searchGymAddr", searchGymAddr);
		req.setAttribute("lists", lists);
		req.setAttribute("ajaxPageIndexList", ajaxPageIndexList);
		req.setAttribute("param", param);
		req.setAttribute("searchGymAddrUrl", searchGymAddrUrl);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("searchValue", searchValue);
		
		return "map/mapList";

	}
	
	//지도만 불러오기 (리다이렉트) (첫화면)
	@RequestMapping(value = "/mapReload.action", method = {RequestMethod.GET})
	public String mapReload() throws Exception {
		return "redirect:map.action";
	}
	
	//지도만 불러오기 (뷰로 이동) (검색결과가 있을때)
	@RequestMapping(value = "/mapReload.action", method = {RequestMethod.POST })
	public String mapReload(HttpServletRequest req) throws Exception {
		String sessionId = "";
		HttpSession httpSession = req.getSession(true);		
		if(httpSession.getAttribute("sessionId")!=null) {
			sessionId = (String)httpSession.getAttribute("sessionId");
		}
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchValue.equals("")) {
			searchKey = "gymName";
		}
		List<GymDTO> lists = dao.getMapList(1, 10000, searchKey, searchValue);
		
		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchValue", searchValue);
		req.setAttribute("sessionId", sessionId);
		req.setAttribute("lists", lists);
		req.setAttribute("tempSearchKey", searchKey);
		req.setAttribute("tempSearchValue", searchValue);
		req.setAttribute("mode", "map");
		
		return "map/map";

	}
	
	//검색어 제시 (자동완성)
	@RequestMapping(value = "/map_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String map_ok(HttpServletRequest req) throws Exception {

		String cp = req.getContextPath();
		String[] gymName = null;
		String[] gymAddr = null;
		String[] gymType = null;

		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		if (searchKey.equals("gymName")) {
			List<GymDTO> lists = dao.getSearchName(1, 5, searchValue);
			gymName = new String[lists.size()];
			int n = 0;
			Iterator<GymDTO> iterator = lists.iterator();
			while (iterator.hasNext()) {
				GymDTO dto = iterator.next();
				gymName[n] = dto.getGymName();
				n++;
			}
			req.setAttribute("gymName", gymName);
		} else if (searchKey.equals("gymAddr")) {
			List<GymDTO> lists = dao.getSearchGoo(1, 5, searchValue);
			gymAddr = new String[lists.size()];
			int n = 0;
			Iterator<GymDTO> iterator = lists.iterator();
			while (iterator.hasNext()) {
				GymDTO dto = iterator.next();
				gymAddr[n] = dto.getGymAddr();
				n++;
			}
			req.setAttribute("gymAddr", gymAddr);
		} else if (searchKey.equals("gymType")) {
			List<GymDTO> lists = dao.getSearchType(1, 5, searchValue);
			gymType = new String[lists.size()];
			int n = 0;
			Iterator<GymDTO> iterator = lists.iterator();
			while (iterator.hasNext()) {
				GymDTO dto = iterator.next();
				gymType[n] = dto.getGymType();
				n++;
			}
			req.setAttribute("gymType", gymType);
		}

		return "map/map_ok";
	}

	
	//*******************최원식*******************
	
	//관리자 페이지로 이동
	@RequestMapping(value = "/adminHome.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String adminHome(HttpServletRequest request, HttpSession session) {
		
		//세션에 올라온값 받기
		CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
		System.out.println(info.getSessionId());
		request.setAttribute("info", info);
		return "admin/adminHome";
	}
	
	//체육관(매장) 리스트
	@RequestMapping(value = "/adminGymList.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String gymList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String cp = request.getContextPath();

		String pageNum = request.getParameter("pageNum");
		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");

		if (searchKey == null) {//아무것도 없이 검색만 눌럿을떄
			searchKey = "gymName";
			searchValue = "";

		} else {
			if (request.getMethod().equalsIgnoreCase("GET"))
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		//페이징처리
		int dataCount = dao.gymGetDataCount(searchKey, searchValue);
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		//사진컬럼 ,구분 배열처리
		List<GymDTO> lists =
				dao.gymGetList(start, end, searchKey, searchValue);
		
		Iterator<GymDTO> itrT = lists.iterator();
		GymDTO dto;
		
		while( itrT.hasNext() ) {
			dto = itrT.next();
			
			dto.setGymTrainerAry(dto.getGymTrainer().split(",")); 
			dto.setGymTrainerPicAry(dto.getGymTrainerPic().split(","));
			dto.setGymPicAry(dto.getGymPic().split(","));
			dto.setGymFacilityAry(dto.getGymFacility().split(","));
			
		}
		
		List<GymDTO> falselists =
				dao.gymGetFalseList();
		
		Iterator<GymDTO> itr = falselists.iterator();
		
		//GymDTO dto;
		
		while( itr.hasNext() ) {
			dto = itr.next();
			
			dto.setGymTrainerAry(dto.getGymTrainer().split(",")); 
			dto.setGymTrainerPicAry(dto.getGymTrainerPic().split(","));
			dto.setGymPicAry(dto.getGymPic().split(","));
			dto.setGymFacilityAry(dto.getGymFacility().split(","));
			
		}
		
		//param 생성
		String param = "";
		if (!searchValue.equals("")) {

			param = "searchKey=" + searchKey;
			param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

		}

		String listUrl = cp + "/adminGymList.action";

		if (!param.equals("")) {
			listUrl = listUrl + "?" + param;
		}

		String pageIndexList =

				myUtil.pageIndexList(currentPage, totalPage, listUrl);

		//이미지
		cp = cp + "/resources/img/test";
		String imgPath = cp;

		//request set
		request.setAttribute("lists", lists);
		request.setAttribute("falselists", falselists);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("imgPath", imgPath);
		return "admin/adminGymList";

	}

	//체육관 gymOk false -> true
	@RequestMapping(value = "/adminGymUpdated_ok.action",
			method = { RequestMethod.GET, RequestMethod.POST})
	public String adminGymUpdated_ok(GymDTO dto ,HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pageNum = request.getParameter("pageNum");
		String gymId = request.getParameter("gymId");
		
		dao.gymUpdateData(dto);

		return "redirect:/adminGymList.action";

	}

	//매장 리스트 삭제 gymOk false 거절용
	@RequestMapping(value = "/adminGymDeleted.action",
			method = { RequestMethod.GET, RequestMethod.POST })
	public String gymDeleted(HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String pageNum = request.getParameter("pageNum");
		String str = request.getParameter("gymId");

		dao.gymDeleteData(str);

		return "redirect:/adminGymList.action";

	}

	//회원 리스트
	@RequestMapping(value = "/adminCustomerList.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String customerList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String cp = request.getContextPath();
		String pageNum = request.getParameter("pageNum");
		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");

		if (searchKey == null) {//아무것도 없이 검색만 눌럿을떄
			searchKey = "cusId";
			searchValue = "";

		} else {
			if (request.getMethod().equalsIgnoreCase("GET"))
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		//페이징 처리
		int dataCount = dao.customerGetDataCount(searchKey, searchValue);
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<CustomerDTO> lists =

				dao.customerGetList(start, end, searchKey, searchValue);

		//파람 생성
		String param = "";
		if (!searchValue.equals("")) {

			param = "searchKey=" + searchKey;
			param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

		}

		String listUrl = cp + "/adminCustomerList.action";

		if (!param.equals("")) {
			listUrl = listUrl + "?" + param;
		}

		String pageIndexList =

				myUtil.pageIndexList(currentPage, totalPage, listUrl);

		//request set
		request.setAttribute("lists", lists);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("pageNum", pageNum);

		return "admin/adminCustomerList";

	}

	//상품 입력
	@RequestMapping(value = "/adminProductCreated.action")
	public ModelAndView productCreated() {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminProductCreated");

		return mav;

	}

	@RequestMapping(value = "/adminProductCreated_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String created_ok(ProductDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {

		dao.productInsertData(dto);

		return "redirect:/adminProductList.action";

	}

	//상품 리스트
	@RequestMapping(value = "/adminProductList.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String productList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String cp = request.getContextPath();
		String pageNum = request.getParameter("pageNum");
		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");

		if (searchValue == null) {//아무것도 없이 검색만 눌럿을떄
			searchKey = "productId";
			searchValue = "";

		} else {

			if (request.getMethod().equalsIgnoreCase("GET"))
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		//페이징 처리
		int dataCount = dao.productGetDataCount(searchKey, searchValue);
		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ProductDTO> lists =

				dao.productGetList(start, end, searchKey, searchValue);

		//파람 생성
		String param = "";
		if (!searchValue.equals("")) {

			param = "searchKey=" + searchKey;
			param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

		}

		String listUrl = cp + "/adminProductList.action";

		if (!param.equals("")) {
			listUrl = listUrl + "?" + param;
		}

		String pageIndexList =

				myUtil.pageIndexList(currentPage, totalPage, listUrl);

		//이미지
		cp = cp + "/resources/img/test";
		String imgPath = cp;

		//request set
		request.setAttribute("lists", lists);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("imgPath", imgPath);

		return "admin/adminProductList";

	}

	//상품 내용 productArticle
	@RequestMapping(value = "/adminProductArticle.action",
			method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView productArticle(HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String cp = request.getContextPath();

		String str = request.getParameter("productId");

		String pageNum = request.getParameter("pageNum");

		ProductDTO dto = dao.productGetReadData(str);

		if (dto == null) {
			//return "redirect:/list.action";
		}

		String param = "pageNum=" + pageNum;

		ModelAndView mav = new ModelAndView();

		//View
		mav.setViewName("admin/adminProductArticle");

		//이미지
		cp = cp + "/resources/img/test";
		String imgPath = cp;

		//Model
		mav.addObject("dto", dto);
		mav.addObject("params", param);
		mav.addObject("pageNum", pageNum);
		mav.addObject("imgPath", imgPath);

		return mav;

	}

	//상품 수정 입력
	@RequestMapping(value = "/adminProductUpdated.action",
			method = { RequestMethod.GET, RequestMethod.POST })

	public String productUpdated(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String cp = request.getContextPath();
		String productId = request.getParameter("productId");
		String pageNum = request.getParameter("pageNum");

		ProductDTO dto = dao.productGetReadData(productId);

		if (dto == null) {

			return "redirect:/adminProductList.action";

		}

		request.setAttribute("dto", dto);
		request.setAttribute("pageNum", pageNum);

		return "admin/adminProductUpdated";

	}

	//상품 수정 반영
	@RequestMapping(value = "/adminProductUpdated_ok.action",		//productUpdated_ok.action
			method = { RequestMethod.GET, RequestMethod.POST })

	public String productUpdated_ok(ProductDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {

			String pageNum = request.getParameter("pageNum");

			dao.productUpdateData(dto);

			return "redirect:/adminProductList.action";

		}

}



























