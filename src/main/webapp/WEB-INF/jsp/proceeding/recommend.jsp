<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="member" items="${memberList }">
      <div class="flex w-full ml${member.member_id }" style="height:50px; align-items: center" onclick="inserting(this,'${member.member_id}')">
            <div class="w-1/6 manPicture"style="height:50px;" data-id="${member.member_id}"></div>
            <div class="w-1/4">${member.member_name}</div>
            <div class="w-1/4">${member.member_department1}</div>
            <div class="w-1/4">${member.member_team1}</div>
      </div>
</c:forEach>