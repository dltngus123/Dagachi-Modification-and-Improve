<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="메인" />
<%@include file="../include/head.jspf"%>
<div class="p-4 sm:ml-64">
		<section class="mt-5">
  <div class="container mx-auto px-3">
 
    <div class="mt-3">
      <table class="table table-fixed w-full">
        <colgroup>   
          <col width="50"/>
          <col width="100"/>
          <col width="200"/>
          <col width="150"/>
          <col width="150"/>
          <col width="150"/>
          <col width="100"/>
          <col />
        </colgroup>
        <thead>
          <tr>
			<th>번호</th>
            <th>제목</th>
            <th>내용</th>
            <th>시작</th>
            <th>완료</th>
            <th>등록</th>
            <th>작성자</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="schedule" items="${totalSchedule}">
            <tr class="hover">
              <th>${schedule.schedule_Code}</th>
              <td>${schedule.schedule_Name}</td>
              <td>${schedule.schedule_Body }</td>
              <td><fmt:formatDate value="${schedule.schedule_StartDate}" pattern="yyyy-MM-dd, HH시"/></td>
              <td><fmt:formatDate value="${schedule.schedule_EndDate}" pattern="yyyy-MM-dd, HH시"/></td>
              <td><fmt:formatDate value="${schedule.schedule_RegDate}" pattern="yyyy-MM-dd"/></td>
              <td>${schedule.schedule_Register}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
    
  </div>
</section>
</div>

<%@include file="../include/foot.jspf"%>