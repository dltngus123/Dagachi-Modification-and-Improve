package com.sbs.dagachi.repository;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.dagachi.vo.Member;

@Mapper
public interface MemberRepository {

   List<Member> getMember();
   
   Member getMemberById(String member_id);
   
   Member getMemberByName(String member_name);
   
   List<Member>getMembersNameByteam(String member_team1);
   
   public List<Member> getMembername(@Param("member_name")String member_name);
   
   public List<Member> getDepartmentRepresentative(@Param("member_department")int member_department);
   
   List<Member> getMemberListByTeam(int team);

   public void updateMemberStatus(String member_status,String member_id );
   
   void registMember(String member_id, String member_pwd, String member_name, String member_phone, String member_email,
            String member_address, int member_dep, int member_team, String member_dep1, String member_team1, String member_rank,
             Date member_birth, int member_auth, String member_pic);
   public List<Member> almostName(@Param("member_name")String member_name);
   Member findId(String name,String email);
   
   Member findPwd(String id,String name);
   
   List<Member> searchMember(String searchType, String keyword);
}