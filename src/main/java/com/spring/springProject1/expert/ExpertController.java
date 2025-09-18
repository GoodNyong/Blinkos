package com.spring.springProject1.expert;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.springProject1.user.UserService;
import com.spring.springProject1.user.UserVo;

@Controller
@RequestMapping("/expert")
public class ExpertController {

	private static final Logger logger = LoggerFactory.getLogger(ExpertController.class);

//	@Autowired
//	private ExpertService expertService;

	@Autowired
	private UserService userService;

	// 피드백 요청 페이지 호출
	@GetMapping("/feedbackRequest")
	public String feedbackRequestGet(HttpSession session, RedirectAttributes ra, Model model) {
		Integer userId = (Integer) session.getAttribute("loginUser");
		UserVo user = userService.getUserByUser_id(userId);
		if (user == null) {
			ra.addFlashAttribute("message", "로그인이 필요합니다.");
			ra.addFlashAttribute("url", "/");
			return "redirect:/message/error";
		}
		
//		List<TagVo> specialtyTagList = expertService.getSpecialtyTags();
//		List<ExpertVo> expertList = expertService.getExpertListForDomain("all"); // 전체 리스트 초기 표시
//		
//		model.addAttribute("specialtyTagList", specialtyTagList);
//		model.addAttribute("expertList", expertList);
		model.addAttribute("user_id", userId);
		
		return "expert/feedbackRequest";
	}


}
