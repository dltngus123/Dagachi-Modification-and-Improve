package com.sbs.dagachi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sbs.dagachi.service.DepartmentService;
import com.sbs.dagachi.service.FavPhoneService;
import com.sbs.dagachi.service.MemberService;
import com.sbs.dagachi.service.Phone_Book_Service;
import com.sbs.dagachi.service.TeamService;
import com.sbs.dagachi.utill.MakeFileName;
import com.sbs.dagachi.vo.DepartmentVO;
import com.sbs.dagachi.vo.FavPhoneVO;
import com.sbs.dagachi.vo.Member;
import com.sbs.dagachi.vo.Phone_BookVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class Phone_Book_Controller {

   private Phone_Book_Service phone_Book_Service;
   private MemberService memberService;
   private FavPhoneService favPhoneService;
   private DepartmentService departmentService;
   private TeamService teamService;
   
   public Phone_Book_Controller(Phone_Book_Service phone_Book_Service,MemberService memberService, FavPhoneService favPhoneService,
         DepartmentService departmentService, TeamService teamService) {
      this.phone_Book_Service = phone_Book_Service;
      this.memberService=memberService;
      this.favPhoneService=favPhoneService;
      this.departmentService=departmentService;
      this.teamService=teamService;
      
   }

   
   
   @RequestMapping("dagachi/phoneBook/showList")
   public String showList(String searchType, String keyword,
         String phone_book_type, String phone_book_register,Model model,@RequestParam(defaultValue = "1") int page,HttpSession session) {
      
      if(phone_book_register==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         phone_book_register=loginUser.getMember_id();
      }
      //페이지네이션
      int typeInt=Integer.parseInt(phone_book_type);
      int phoneBookCount=phone_Book_Service.getPhoneBookCount(searchType,keyword,typeInt,phone_book_register);
      int itemsCountInAPage=10;
      int pagesCount=(int)Math.ceil((double)phoneBookCount/itemsCountInAPage);
      //리스트 출력 용
      List<Phone_BookVO>list=phone_Book_Service.getPhoneBookList(searchType, keyword, typeInt, phone_book_register,itemsCountInAPage, page);
      
      
      
      
      
      //즐겨찾기 등록 되있나 안되있나 확인용
      List<FavPhoneVO>favCheckList=favPhoneService.getFavApp(phone_book_register);
      List<Integer>favIdList=new ArrayList<Integer>();
      
      for(FavPhoneVO fav: favCheckList) {
         int favId=fav.getPhone_Book_Id();
         favIdList.add(favId);
      }
      System.out.println(list.size());
      System.out.println(favIdList);
      System.out.println(page);
      
      System.out.println(phoneBookCount);
      model.addAttribute("favIdList", favIdList);
      model.addAttribute("favCheckList", favCheckList);
      model.addAttribute("searchType", searchType);
      model.addAttribute("keyword", keyword);
      model.addAttribute("page", page);
      model.addAttribute("pagesCount", pagesCount);
      model.addAttribute("phoneBookCount",phoneBookCount);
      model.addAttribute("phoneBookList",list);
      model.addAttribute("phoneBookType", phone_book_type);
      
      
      return "phoneBook/shareList";
   }
   
   
   
   
   
   
   
   
   
   
   
   
   @RequestMapping("dagachi/phoneBook/companyPhoneBookList")
   public String showCompanyPhoneBookList(Model model, String searchType, String keyword) {
      List<Member>companyPhoneBookList=memberService.searchMember(searchType, keyword);            
      model.addAttribute("companyPhoneBookList",companyPhoneBookList);
      return "phoneBook/companyPhoneBookList";
   }

   @RequestMapping("dagachi/phoneBook/companyPhoneBookDetail")
   public String showDetail(String member_id,Model model) {
      Member phoneBook=memberService.getMemberById(member_id);
      model.addAttribute("phoneBook",phoneBook);
      return "phoneBook/companyPhoneDetail";
      
   }
   @RequestMapping("dagachi/phoneBook/detail")
   public String showDetail(int phone_Book_Id,Model model) {
      Phone_BookVO phoneBook=phone_Book_Service.getPhoneBookDetail(phone_Book_Id);
      
      String phones=phoneBook.getPhone_Book_Phone();
      String[]phoneArr=phones.split("-");
      if(phoneArr.length==3){
         
         model.addAttribute("phone1",phoneArr[0]);
         model.addAttribute("phone2",phoneArr[1]);
         model.addAttribute("phone3",phoneArr[2]);
      }
      
      
      String emails=phoneBook.getPhone_Book_Email();
      String[]emailArr=emails.split("@");
      if(emailArr.length==2){
         model.addAttribute("email1",emailArr[0]);
         model.addAttribute("email2",emailArr[1]);
      }
      
      model.addAttribute("phoneBook",phoneBook);
      
      

      
      return "phoneBook/detail";
      
   }

   @RequestMapping("dagachi/phoneBook/liid")
   @ResponseBody
   public int liid() {
      return phone_Book_Service.getLastInsertId();
   }


   @RequestMapping("dagachi/phoneBook/regist")
   public String registPhone_Book(String phone_Book_Name, String phone_Book_Email, String phone_Book_Phone,
         String phone_Book_Company, String phone_Book_Tag, String phone_Book_Fax, String phone_Book_Dep,
         String phone_Book_Rank, String phone_Book_Address, String phone_Book_Web,
         @RequestParam(defaultValue = "1")String phone_Book_Type,HttpServletRequest req, Model model) {
      
      String phone_Book_Register=null;
      HttpSession session=req.getSession();
      if(phone_Book_Register==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         phone_Book_Register=loginUser.getMember_id();
      }

      
      int phone_Book_Type2=Integer.parseInt(phone_Book_Type);
      
      phone_Book_Service.registPhone_Book(phone_Book_Name, phone_Book_Email, phone_Book_Phone,
            phone_Book_Company, phone_Book_Tag, phone_Book_Fax, phone_Book_Dep,
            phone_Book_Rank, phone_Book_Address, phone_Book_Web,
            phone_Book_Register, phone_Book_Type2);
         
         model.addAttribute("phone_book_type", phone_Book_Type2);
         model.addAttribute("phone_book_register", phone_Book_Register);
         return "phoneBook/registSuccess";
   }
   
   @RequestMapping("dagachi/phoneBook/registForm")
   public String showPhoneBookRegistForm(Model model,HttpSession session) {
      String phone_book_register=null;
      if(phone_book_register==null) {
         Member loginUser=(Member) session.getAttribute("loginUser");
         phone_book_register=loginUser.getMember_id();
      }
      
      List<String>tags=phone_Book_Service.getTagList();
      model.addAttribute("tags",tags);
      model.addAttribute("phone_book_register", phone_book_register);
      return "phoneBook/regist";
   }
   
   
   
   @RequestMapping("dagachi/phoneBook/modifyForm")
   public String showPhoneBookModifyForm(int phone_Book_Id,HttpSession session, Model model) {
      
      Phone_BookVO phoneBook=phone_Book_Service.getPhoneBookDetail(phone_Book_Id);
      
      List<String>tags=phone_Book_Service.getTagList();
      model.addAttribute("tags",tags);
      
      String phones=phoneBook.getPhone_Book_Phone();
      String[]phoneArr=phones.split("-");
      if(phoneArr.length==3){
         
         model.addAttribute("phone1",phoneArr[0]);
         model.addAttribute("phone2",phoneArr[1]);
         model.addAttribute("phone3",phoneArr[2]);
      }
      
      
      String emails=phoneBook.getPhone_Book_Email();
      String[]emailArr=emails.split("@");
      if(emailArr.length==2){
         model.addAttribute("email1",emailArr[0]);
         model.addAttribute("email2",emailArr[1]);
      }
      
      String addedTags=phoneBook.getPhone_Book_Tag();
      if(addedTags.contains(",")) {
      String[]addedTagArr=addedTags.split(",");
      List<String>addedTagList=Arrays.asList(addedTagArr);
      model.addAttribute("addedTag", addedTagList);
      }
      model.addAttribute("addedTag", addedTags);
      
      String phone_Book_Register=null;
      if(phone_Book_Register==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         phone_Book_Register=loginUser.getMember_id();
      }
      model.addAttribute("phone_Book_register", phone_Book_Register);
      model.addAttribute("phoneBook",phoneBook);
      return "phoneBook/modify";
   }

   
   @RequestMapping("dagachi/phoneBook/modify")
   public String modifyPhone_Book(String phone_Book_Id, String phone_Book_Name, String phone_Book_Email, String phone_Book_Phone,
         String phone_Book_Company, String phone_Book_Tag, String phone_Book_Fax, String phone_Book_Dep,
         String phone_Book_Team, String phone_Book_Rank, String phone_Book_Address, String phone_Book_Web,
         String phone_Book_Register, String phone_Book_Type,Model model) {
      
      int phoneBookId=Integer.parseInt(phone_Book_Id);


      
      int phone_Book_Type2=Integer.parseInt(phone_Book_Type);
         
      phone_Book_Service.modifyPhone_Book(phoneBookId, phone_Book_Name, phone_Book_Email, phone_Book_Phone,
              phone_Book_Company, phone_Book_Tag, phone_Book_Fax, phone_Book_Dep,
            phone_Book_Team, phone_Book_Rank, phone_Book_Address, phone_Book_Web,
            phone_Book_Register, phone_Book_Type2);
   
      model.addAttribute("register", phone_Book_Register);   



      return "phoneBook/modifySuccess";
   }
   
   @RequestMapping("dagachi/phoneBook/moveTrash")
   public void moveTrashPhone_Book(int phone_Book_Id) {
      phone_Book_Service.moveTrashPhone_Book(phone_Book_Id);
      
   }
   
   @RequestMapping("dagachi/phoneBook/moveTrashCb")
   public String moveTrashCb(String[]checkedIdArr, String phoneBookType, HttpSession session, String searchType, String keyword,
         @RequestParam(defaultValue = "1")int page, Model model) {
      for(int i=0;i<checkedIdArr.length;i++) {
         int checkedId=Integer.parseInt(checkedIdArr[i]);
         phone_Book_Service.moveTrashPhone_Book(checkedId);
      }
      String register=null;
      if(register==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         register=loginUser.getMember_id();
      }
      
      int phone_book_type=Integer.parseInt(phoneBookType);
      
      int phoneBookCount=phone_Book_Service.getPhoneBookCount(searchType,keyword,phone_book_type,register);
      int itemsCountInAPage=10;
      int pagesCount=(int)Math.ceil((double)phoneBookCount/itemsCountInAPage);
      
      List<Phone_BookVO>list=phone_Book_Service.getPhoneBookList(searchType, keyword, phone_book_type, register,itemsCountInAPage, page);
      
      model.addAttribute("phoneBookList", list);
      
      
      
      return "phoneBook/ResultTable";
   }
   
   
   @RequestMapping("dagachi/phoneBook/recoveryPhoneBook")
   public String recoveryPhoneBook(String[] phone_Book_Id, String phone_Book_Type,Model model, HttpSession session, String searchType, String keyword,
         @RequestParam(defaultValue = "1")int page) {
      
      String register=null;
      if(register==null) {
            Member loginUser=(Member) session.getAttribute("loginUser");
            register=loginUser.getMember_id();
         }
      
      for(int i=0;i<phone_Book_Id.length;i++) {
         int phoneBookId= Integer.parseInt(phone_Book_Id[i]);
         phone_Book_Service.modifyType(phoneBookId, phone_Book_Type);
      }
      int phone_book_type=Integer.parseInt(phone_Book_Type);
      
      int phoneBookCount=phone_Book_Service.getPhoneBookCount(searchType,keyword,phone_book_type,register);
      int itemsCountInAPage=10;
      int pagesCount=(int)Math.ceil((double)phoneBookCount/itemsCountInAPage);
      
      List<Phone_BookVO>list=phone_Book_Service.getPhoneBookList(searchType, keyword, 3, register,itemsCountInAPage, page);
      
      model.addAttribute("phoneBookList", list);
      
      
      return "phoneBook/ResultTable";
   }
   
   @RequestMapping("dagachi/phoneBook/eliminatePhoneBook")
   public String eliminatePhoneBook(String phone_Book_Id) {
      int phoneBookId= Integer.parseInt(phone_Book_Id);
      phone_Book_Service.removePhone_Book(phoneBookId);
      
      return "phoneBook/eliminateSuccess";
   }
   
   @RequestMapping("dagachi/phoneBook/eliminateCb")
   public String eliminateCb(String[]checked_EIdArr, String phoneBookType, HttpSession session, String searchType, String keyword,
         @RequestParam(defaultValue = "1")int page, Model model) {
      for(int i=0;i<checked_EIdArr.length;i++) {
         int checkedId=Integer.parseInt(checked_EIdArr[i]);
         phone_Book_Service.removePhone_Book(checkedId);
      }
      String register=null;
      if(register==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         register=loginUser.getMember_id();
      }
      
      int phone_book_type=Integer.parseInt(phoneBookType);
      
      int phoneBookCount=phone_Book_Service.getPhoneBookCount(searchType,keyword,phone_book_type,register);
      int itemsCountInAPage=10;
      int pagesCount=(int)Math.ceil((double)phoneBookCount/itemsCountInAPage);
      
      List<Phone_BookVO>list=phone_Book_Service.getPhoneBookList(searchType, keyword, phone_book_type, register,itemsCountInAPage, page);
      
      model.addAttribute("phoneBookList", list);
      
      
      
      return "phoneBook/ResultTable";
   }
   
   
   @RequestMapping("dagachi/phoneBook/recoveryPhoneBookAtDetail")
   public String recoveryPhoneBookAtDetail(String phone_Book_Id,String phone_Book_Type) {
      int phoneBookId= Integer.parseInt(phone_Book_Id);
      phone_Book_Service.modifyType(phoneBookId, phone_Book_Type);
      
      return "phoneBook/recoverySuccess";
   }
   
   @RequestMapping("dagachi/phoneBook/registFav")
   public String registFavAtPhoneBook(HttpSession session, String phone_Book_Id) {
      int phoneBookId=Integer.parseInt(phone_Book_Id);
      String userId=null;
      if(userId==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         userId=loginUser.getMember_id();
      }
      favPhoneService.registFav(phoneBookId, userId);
      return "phoneBook/ResultTable";
   }
   
   @RequestMapping("dagachi/phoneBook/removeFav")
   public String removeFavAtPhoneBook(HttpSession session, String phone_Book_Id) {
      int phoneBookId=Integer.parseInt(phone_Book_Id);
      String userId=null;
      if(userId==null) {
         
         Member loginUser=(Member) session.getAttribute("loginUser");
         userId=loginUser.getMember_id();
      }
      favPhoneService.registFav(phoneBookId, userId);
      favPhoneService.removeFavAtPhone(phoneBookId,userId);
      return "phoneBook/ResultTable";
   }
   
   @RequestMapping("dagachi/phoneBook/memberRegist")
   public String memberRegistForm(Model model) {
      List<DepartmentVO>depList=departmentService.getDepList();
      model.addAttribute("depList", depList);
      return "phoneBook/memberRegist";
   }
   
   
   
    @Value(value = "${picturePath}")
      private String picturePath;
      
      @PostMapping(value="dagachi/phoneBook/picture.do",produces="text/plain;charset=utf-8")
      @ResponseBody
      /* 스트링으로 return하려면 위의 responsebody가 꼭있어야함 */
      public String pictureUpload(@RequestParam("pictureFile") MultipartFile multi,String oldPicture)throws Exception{
         
         String result="";
         
         /* 파일저장확인 */
         result = savePicture(oldPicture, multi);
         
         return result;
      }
      
      public String savePicture(String oldPicture, MultipartFile multi)throws Exception{
         String fileName="";
         
         /* 파일저장폴더설정 저장과 삭제하는 경로가 같아서 여기서 한거임*/
         String uploadPath = this.picturePath;
         
         /* 파일유무확인 */
         if(!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
            fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
            File storeFile = new File(uploadPath, fileName);
            
            //파일 경로 생성
            storeFile.mkdirs();
            
            //local HDD에 저장.
            multi.transferTo(storeFile);
         }
         
         //기존파일 삭제
         if(oldPicture !=null && !oldPicture.isEmpty()) {
            File oldFile = new File(uploadPath, oldPicture);
            if(oldFile.exists()) {
               oldFile.delete();
            }
         }
         
         return fileName;
      }
         
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
   
     @RequestMapping("dagachi/phoneBook/idCheck")
     @ResponseBody
     public int idCheck(String member_id) {
        Member member=null;
        member=memberService.getMemberById(member_id);
        
       if(member==null) {
          return 1; 
       }else {
          return 2;
       }
        
        
     }
     
     @RequestMapping("dagachi/phoneBook/memberRegistSuccess")
     public String memberRegistSuccess(String member_id, String member_pwd, String member_name, String phone1,String phone2,String phone3,
           String email1, String email2, int member_dep, int member_team, String member_rank, String member_address,String member_pic,
           @DateTimeFormat(pattern="yyyy-MM-dd")Date member_birth) {

        String member_phone=phone1+"-"+phone2+"-"+phone3;
        String member_email=email1+"@"+email2;
        
        String member_dep1=departmentService.getDep(member_dep).getDepartment_name();
        String member_team1=teamService.getTeamByCode(member_team).getTeam_name();
        
        int member_auth=1;
        if(member_rank=="부장") {
           member_auth=2;
        
        }
        
        
      memberService.registMember(member_id, member_pwd, member_name, member_phone, member_email, member_address, member_dep, 
            member_team, member_dep1, member_team1, member_rank, member_birth, member_auth, member_pic);
        
        
        
        
        
        
        return "phoneBook/memberRegistSuccess";
     }
   
}