<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
<input type="hidden" name="member_name" value="${member_name }"/>


	<div class="card card-success" >
<div class="card-header bg-gray-400 mt-2 rounded-xl text-white font-bold w-full text-right flex" >
  
    <div id="userimg" class="my-2 ml-2 mr-2" style="width: 100px; height: 100px; border-radius: 50%; text-align: right;">
      <img src="${pageContext.request.contextPath}/attendence/getPicture?id=${param.member_name}" alt="User Image"
        style="width: 100px; height: 100px; object-fit: cover; border-radius: 20%; ">
    </div>

    <c:forEach items="${member}" var="member">
      <c:set var="departmentName" value="" />
      <c:choose>
        <c:when test="${member.member_department == '1'}">
          <c:set var="departmentName" value="인사" />
        </c:when>
        <c:when test="${member.member_department == '2'}">
          <c:set var="departmentName" value="마케팅" />
        </c:when>
        <c:when test="${member.member_department == '3'}">
          <c:set var="departmentName" value="영업" />
        </c:when>
        <c:when test="${member.member_department == '4'}">
          <c:set var="departmentName" value="관리" />
        </c:when>
      </c:choose>
      <c:set var="teamName" value="" />
      <c:choose>
        <c:when test="${member.member_team == '1' || member.member_team == '4' || member.member_team == '7' || member.member_team == '10'}">
          <c:set var="teamName" value="1" />
        </c:when>
        <c:when test="${member.member_team == '2' || member.member_team == '5' || member.member_team == '8' || member.member_team == '11'}">
          <c:set var="teamName" value="2" />
        </c:when>
        <c:when test="${member.member_team == '3' || member.member_team == '6' || member.member_team == '9' || member.member_team == '12'}">
          <c:set var="teamName" value="3" />
        </c:when>
      </c:choose>
      <span class="text-center mt-12"  >
        ${departmentName}부서&nbsp;&nbsp;${teamName}팀&nbsp;&nbsp;${member.member_rank}&nbsp;&nbsp;${member.member_name }
</c:forEach>


</div>

<div class="card-body w-full p-0">
<table class="table table-fixed w-auto">

<thead>
		<tr>
			<th>출근</th>
			<th>지각</th>
			<th>결근</th>
			<th>조퇴</th>
			<th>출근률</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${TotalStatus1} </td>
			<td>${TotalStatus7Count }</td>
			<td id="totalwark"></td>
			<td>${TotalStatus5Count }</td>
			<td id="total"></td>
		</tr>
	</tbody>
</table>
<table class="table table-fixed w-full">
 <colgroup>   
	          <%-- <col width="50"/>
	          <col width="100"/>
	          <col width="100"/>
	          <col width="100"/>
	          <col width="100"/> --%>
	         
	        </colgroup>
<thead>
		<tr>
			<th>날짜</th>
			<th class="text-blue-700">출근</th>
			<th class="text-red-700">퇴근</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
		  <c:forEach var="getMemberList" items="${getMemberLists}">
		<tr>
		    <td class="text-xs">${getMemberList['attendence_regdate'].toLocalDate().toString().substring(0, 10)}</td>
		    <td class="text-xs text-blue-700">${getMemberList['출근시간']}</td>
		    <td class="text-xs text-red-700">${getMemberList['퇴근시간']}</td>
		    <td class="text-xs">
		    <c:choose>
				  <c:when test="${getMemberList['근태상태'] eq 1}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#c3c7f8; border:none;">출근</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 2}">
				    <button class="badge bg-Disabled" type="button" style="background-color:#D8BFD8; border:none;">퇴근</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 3}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#f5a395; border:none;">자리비움</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 4}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#f8e589; border:none;">월차</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 5}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#c8c7c7; border:none;">조퇴</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 6}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#bef78b; border:none;">연차</button>
				  </c:when>
				  <c:otherwise>
				    <button type="button" style="background-color:#FF0000; border:none;">결근</button>
				  </c:otherwise>
				</c:choose>
		    </td>
		</tr>
		  </c:forEach>
	</tbody>
</table>
</div>
</div>
<%-- <div style="margin-left:10px;">
<span style="width:100px;height:100px; background-color:red;">사진</span>
<c:forEach items="${member }" var="member">
    <c:set var="departmentName" value=""/>
    <c:choose>
        <c:when test="${member.member_department == '1'}">
            <c:set var="departmentName" value="인사"/>
        </c:when>
        <c:when test="${member.member_department == '2'}">
            <c:set var="departmentName" value="마케팅"/>
        </c:when>
        <c:when test="${member.member_department == '3'}">
            <c:set var="departmentName" value="영업"/>
        </c:when>
        <c:when test="${member.member_department == '4'}">
            <c:set var="departmentName" value="관리"/>
        </c:when>
    </c:choose>
    <c:set var="teamName" value=""/>
    <c:choose>
        <c:when test="${member.member_team == '1' || member.member_team == '4' || member.member_team == '7' || member.member_team == '10'}">
            <c:set var="teamName" value="1"/>
        </c:when>
        <c:when test="${member.member_team == '2' || member.member_team == '5' || member.member_team == '8' || member.member_team == '11'}">
            <c:set var="teamName" value="2"/>
        </c:when>
        <c:when test="${member.member_team == '3' || member.member_team == '6' || member.member_team == '9' || member.member_team == '12'}">
            <c:set var="teamName" value="3"/>
        </c:when>
    </c:choose>
    <span style="text-align:center;">${departmentName} 부서&nbsp;&nbsp;&nbsp;&nbsp;${teamName}팀&nbsp;&nbsp;&nbsp;&nbsp;${member.member_rank}&nbsp;&nbsp;&nbsp;&nbsp;${member.member_name}</span>
</c:forEach>

</div>
<table class="table table-fixed w-full">
<thead>
		<tr>
			<th>출근</th>
			<th>지각</th>
			<th>결근</th>
			<th>조퇴</th>
			<th>출근률</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${TotalStatus1} </td>
			<td>${TotalStatus7Count }</td>
			<td id="totalwark"></td>
			<td>${TotalStatus5Count }</td>
			<td id="total">출근률</td>
		</tr>
	</tbody>
</table>
<table class="table table-fixed w-full">
<thead>
		<tr>
			<th>날짜</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>근태상태</th>
		</tr>
	</thead>
	<tbody>
		  <c:forEach var="getMemberList" items="${getMemberLists}">
		<tr>
		    <td>${getMemberList['attendence_regdate'].toLocalDate().toString().substring(0, 10)}</td>
		    <td>${getMemberList['출근시간']}</td>
		    <td>${getMemberList['퇴근시간']}</td>
		    <td>
		    <c:choose>
				  <c:when test="${getMemberList['근태상태'] eq 1}">
				    <button type="button" style="background-color:#5865F2; border:none;">출근</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 2}">
				    <button type="button" style="background-color:#D8BFD8; border:none;">퇴근</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 3}">
				    <button type="button" style="background-color:#FF6347; border:none;">자리비움</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 4}">
				    <button type="button" style="background-color:#ffd400; border:none;">월차</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 5}">
				    <button type="button" style="background-color:#808080; border:none;">조퇴</button>
				  </c:when>
				  <c:when test="${getMemberList['근태상태'] eq 6}">
				    <button type="button" style="background-color:#81c147; border:none;">연차</button>
				  </c:when>
				  <c:otherwise>
				    <button type="button" style="background-color:#FF0000; border:none;">결근</button>
				  </c:otherwise>
				</c:choose>
		    </td>
		</tr>
		  </c:forEach>
	</tbody>
</table> --%>

<script>
	var today = new Date();

	var startDate = new Date(today.getFullYear(), today.getMonth(), 1);
	var endDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);

	var totalDays = endDate.getDate();

	var weekdaysCount = 0;

	for (var date = startDate; date <= today; date.setDate(date.getDate() + 1)) {
		var dayOfWeek = date.getDay();
		if (dayOfWeek !== 6 && dayOfWeek !== 0) {
			weekdaysCount++;
		}
	}

	var mytotalstatus1 = ${TotalStatus1}; //내 출근수
	var mytotalstatus7 =${TotalStatus5Count }; //내조퇴수
	var mytotalstatus5 =${TotalStatus7Count }; //내 지각수
	
 	/* var totalWarkEl = document.getElementById("totalwark");
	totalWarkEl.innerHTML = mytotalstatus1+mytotalstatus7+mytotalstatus5- weekdaysCount ;  */
	//이달기준 총결근수
	var totalWarkEl = document.getElementById("totalwark");
	totalWarkEl.innerHTML = weekdaysCount-(mytotalstatus1+mytotalstatus5); 



	//출근 해야할일수 백분율
	var totalAttendeeCount = 100;

	//출근일수
	var attendanceCount = mytotalstatus1;

	// 지각일수
	var lateCount = ${TotalStatus7Count};

	// 이달기준 총 결근일수에서 출근일수, 지각일수를 뺀 값이 결근수
	//var absentCount = weekdaysCount - attendanceCount - lateCount;

	// 출석률 계산
	var totalWorkDays = weekdaysCount;
	var actualWorkDays = attendanceCount + lateCount;
	var attendanceRate = actualWorkDays / totalWorkDays * 100;

	var totalWarkEl = document.getElementById("total");
	totalWarkEl.innerHTML = attendanceRate.toFixed(2) + "%";


</script>


<%@include file="/WEB-INF/jsp/include/openfoot.jspf" %>