package com.exe.gyp;

import java.net.URLDecoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exe.dao.GypDAO;
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
	
	@RequestMapping(value="/", 
					method = {RequestMethod.GET, RequestMethod.POST})
	public String home() {
		return "home";
	}
	

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
		
		System.out.println("-------debug-------");
		System.out.println("reNum: " + dto.getReNum());
		System.out.println("reType: " + dto.getReType());
		System.out.println("cusId: " + dto.getCusId());
		System.out.println("gymId: " + dto.getGymId());
		System.out.println("reContent: " + dto.getReContent());
		System.out.println("star: " + dto.getStar());
		
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
