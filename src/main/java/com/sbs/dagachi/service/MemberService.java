package com.sbs.dagachi.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.dagachi.repository.MemberRepository;
import com.sbs.dagachi.vo.Member;

@Service
public class MemberService {

   @Autowired
   private MemberRepository memberRepository;
   
   public MemberService(MemberRepository memberRespository) {
      this.memberRepository = memberRespository;
   }
   
   public List<Member> getMember(){
      List<Member> memberList= memberRepository.getMember();
      
      return memberList;
      
   }
   public List<Member>getMembersNameByteam(String member_team1){
      List<Member>memberList=memberRepository.getMembersNameByteam(member_team1);
      
      return memberList;
   }
   public Member getMemberById(String member_id) {
       Member member= memberRepository.getMemberById(member_id);
      return member;
   }
   
   public Member getMemberByName(String member_name) {
      Member member = memberRepository.getMemberByName(member_name);
      return member;
   }
   
   public int login(String member_id,String member_pwd) {
      int result = 0;
      
      Member member = memberRepository.getMemberById(member_id);
      
      if(member != null) {
         if(member.getMember_pwd().equals(member_pwd)) {
            result=0;
         }else {
            result=1;
         }
         
      }else {
         result=2;
      }
      
      
      return result;
   }
   public List<Member>getMemberListByTeam(int team){
         return memberRepository.getMemberListByTeam(team);
      }
   public List<Member> getMembername(String member_name){
         return memberRepository.getMembername(member_name);
      }
   public List<Member> getDepartmentRepresentative(@Param("member_department")int member_department){
         return memberRepository.getDepartmentRepresentative(member_department);
      }

   public void updateMemberStatus( String member_status,String member_id) {
      memberRepository.updateMemberStatus( member_status,member_id);
      
       System.out.println("########"+member_id+member_status);
   }
   public void registMember(String member_id, String member_pwd, String member_name, String member_phone, String member_email,
            String member_address, int member_dep, int member_team, String member_dep1, String member_team1, String member_rank,
             Date member_birth, int member_auth, String member_pic) {
         
         memberRepository.registMember(member_id, member_pwd, member_name,
               member_phone, member_email, member_address, member_dep, member_team, 
               member_dep1, member_team1, member_rank, member_birth, member_auth, member_pic);
      }
   public List<Member> almostName(String member_name){
        return memberRepository.almostName(member_name);
     }
public Member findId(String name,String email) {
      
      return memberRepository.findId(name, email);
   }
   public Member findPwd(String id,String name) {
      
      return memberRepository.findPwd(id, name);
   }
   
   public List<Member> searchMember(String searchType, String keyword) {
      return memberRepository.searchMember(searchType, keyword);
   }
   
}