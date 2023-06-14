package com.sbs.dagachi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.dagachi.service.AttendenceService;
import com.sbs.dagachi.service.MemberService;
import com.sbs.dagachi.service.VacationService;
import com.sbs.dagachi.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/common")
public class UsrCommonController {

	@Autowired
	private MemberService memberService;
	
	private AttendenceService attendenceService;
	
	private VacationService vacationService;

	public UsrCommonController(MemberService memberService,AttendenceService attendenceService,VacationService vacationService) {
		this.memberService = memberService;
		this.attendenceService = attendenceService;
		this.vacationService = vacationService;

	}

	@GetMapping("/login")
	public void login() {
	}

	@PostMapping("/dologin")
	public String dologin(HttpSession session, String member_id, String member_pwd, HttpServletRequest request ,Integer attendence_month_vacation_cnt, Integer attendence_year_vacation_cnt, String attendence_regDate,String member_department,String member_team ) {
		String url = "";
		String msg = "";
		int result = memberService.login(member_id, member_pwd);

		if (result == 0) {
			url = "redirect:../usr/home/main";
			Member loginUser = memberService.getMemberById(member_id);
			session.setAttribute("loginUser", loginUser);
			loginUser.setMember_status(1);
			
			Integer year = vacationService.getTotalYear(loginUser.getMember_id());
	        Integer month = vacationService.getTotalMonth(loginUser.getMember_id());

	        
	        member_department = String.valueOf(loginUser.getMember_department());
	        member_team = String.valueOf(loginUser.getMember_team());
	      
	        if (attendence_month_vacation_cnt != null) {
	            month = attendence_month_vacation_cnt;
	        }
	        if (attendence_year_vacation_cnt != null) {
	            year = attendence_year_vacation_cnt;
	        }

	        
	        attendenceService.attendenceInsert(loginUser.getMember_id(), loginUser.getMember_status(), month, year,
	                attendence_regDate, member_department, member_team);

	        System.out.println("@@@@@@@@@" + loginUser.getMember_id() + loginUser.getMember_status() + month + year
	                + attendence_regDate + loginUser.getMember_department() + loginUser.getMember_team());

		} else if (result == 1) {
			url = "../jsp/common/login";
			msg = "비밀번호가 일치하지 않습니다.";
			request.setAttribute("msg", msg);

		} else if (result == 2) {
			url = "../jsp/common/login";
			msg = "일치하는 아이디가 없습니다.";
			request.setAttribute("msg", msg);
		} else {
			url = "../jsp/common/login";
			msg = "에러";
			request.setAttribute("msg", msg);
		}

		return url;
	}
	@GetMapping("/logout")
	public String logout(HttpSession session,
	                     @RequestParam(value="attendence_member", required=false) String attendence_member,
	                     @RequestParam(defaultValue = "2") int member_status,
	                     @RequestParam(value="member_department", required=false) String member_department,
	                     @RequestParam(value="member_team", required=false) String member_team,
	                     Integer attendence_month_vacation_cnt,
	                     Integer attendence_year_vacation_cnt,
	                     String attendence_regDate) {
	    Member loginUser = memberService.getMemberById(attendence_member);

	    if (loginUser != null) {
	        session.setAttribute("loginUser", loginUser);

	        Integer year = vacationService.getTotalYear(loginUser.getMember_id());
	        Integer month = vacationService.getTotalMonth(loginUser.getMember_id());

	        if (attendence_month_vacation_cnt != null) {
	            month = attendence_month_vacation_cnt;
	        }
	        if (attendence_year_vacation_cnt != null) {
	            year = attendence_year_vacation_cnt;
	        }

	        attendenceService.attendenceInsert(attendence_member, member_status, month, year,
	                attendence_regDate, member_department, member_team);

	        System.out.println("@@@@@@@@@@@@" + attendence_member + member_status + month + year + attendence_regDate + member_department + member_team);

	        String url = "../jsp/common/login";

	        session.invalidate();

	        return url;
	    } else {
	        return "redirect:/common/login";
	    }
	}
	
	@PostMapping("/changeStatus")
	@ResponseBody
	public String changeStatus(HttpSession session, @RequestParam(value="memberStatus", required=false) String memberStatus) {
	    Member loginUser = (Member) session.getAttribute("loginUser");


	        memberService.updateMemberStatus( memberStatus,loginUser.getMember_id());
	        System.out.println("########"+loginUser.getMember_id()+memberStatus);
	     
	       Member member = memberService.getMemberById(loginUser.getMember_id());
	       
	       session.setAttribute("loginUser", member);
	        
	        
	      
		return "redirect:/usr/home/main";
	}
	
	@Value(value = "${picturePath}")
	private String picturePath;
	
	@GetMapping("/getPicture")
	@ResponseBody
	public byte[] getPicture(String id) throws Exception {
	   
	   Member member = memberService.getMemberById(id);
	   if(member==null) return null;
	   
	   String picture = member.getMember_pic();
	   String imgPath = this.picturePath;
	   
	   InputStream in = new FileInputStream(new File(imgPath, picture));
	   
	   
	   return IOUtils.toByteArray(in);
	
	}
	
	@GetMapping("/forget")
	public void forget(String member_name, String member_phone) {
	}

	@RequestMapping("/findId")
	@ResponseBody
	public String findId(String name, String phone, String email) {
	    String msg = "";
	    Member member = memberService.findId(name, email);

	    if (member == null) {
	        msg = "none-data";
	        return msg;
	    } else {
	        return member.getMember_id();
	    }
	}

	@PostMapping("/findPwd")
	@ResponseBody
	public String findPwd(String nameForPwd, String phoneForPwd, String emailForPwd, String id) {
	    String msg = "";
	    Member member = memberService.findPwd(id, nameForPwd);

	    if (member == null) {
	        msg = "none-data";
	        return msg;
	    } else {
	        return member.getMember_pwd();
	    }
	}


}


