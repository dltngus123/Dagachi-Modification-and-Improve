<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
<input type="hidden" name="member_department" value="${department.name }">
<input type="hidden" name="member_team" value="${department.team}">
<div class="col-md-12" style=" margin-right:10px; display:flex; ">
<div class="col-md-7" style="margin-right:20px; ">

	<div class="card card-success" style=" width:580px; height:600px;">
<div class="card-header bg-gray-400 rounded-xl my-2 text-white" >
 

  <div style="text-align: left;">
    <div style="display:flex;justify-content:center;">
<c:set var="member" value="${memberdepartmentname[0]}"/>
  ${member.member_rank}: ${member.member_name}
<c:forEach var="Team" items="${Teams}">
  <span>

    &nbsp;${Team.name}
    <c:choose>
      <c:when test="${Team.team == 1 or Team.team == 4 or Team.team == 7 or Team.team == 10}">
        1팀 :
      </c:when>
      <c:when test="${Team.team == 2 or Team.team == 5 or Team.team == 8 or Team.team == 11}">
        2팀 :
      </c:when>
      <c:otherwise>
        3팀 :
      </c:otherwise>
    </c:choose>
    <c:forEach var="member" items="${memberdepartmentname}" varStatus="status">
      <c:if test="${status.index != 0 and member.member_team == Team.team}">
        ${member.member_name} &nbsp;
      </c:if>
    </c:forEach>
  </span>
</c:forEach>


<span style="margin-left:30px;">
  <c:if test="${Team.team eq '1팀' }">
			<span><c:set var="department" value="${todayTeams[0]}"/>${department.attendence_regdate.toLocalDate().toString().substring(0, 10) }</span>
			</c:if>
			 <c:if test="${Team.team eq '2팀' }">
			<span><c:set var="department" value="${todayTeams[1]}"/>${department.attendence_regdate.toLocalDate().toString().substring(0, 10) }</span>
			</c:if>
			 <c:if test="${Team.team eq '3팀' }">
			<span><c:set var="department" value="${todayTeams[2]}"/>${department.attendence_regdate.toLocalDate().toString().substring(0, 10) }</span>
			</c:if>
</span>
</div>
  </div>
<div class="card-tools" style="text-align: left;">
</div>

</div>

<div class="card-body" style="overflow-y:scroll;">
<table class="table table-fixed w-full">
	<thead>
		<tr>
			<th>직급</th>
			<th>이름</th>
			<th>출근여부</th>
			<th>출근일</th>
			<th>연/월차 사유</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="teamdetail" items="${TeamDetails }">
		<tr>
			<td>${teamdetail.member_rank }</td>	
			<td><a href="#" onclick='open_in_frame("/attendence/teamdetailgetmember?member_name=${teamdetail.member_name}")'> ${teamdetail.member_name}</a>
				<form method="POST" action="/attendence/teamdetailgetmember">
				<input type="hidden" name="member_name" value="${teamdetail.member_name}"/>
				<input type="hidden" name="member_team" value="${department.team}"/>
				</form>
				
			</td>
			 <td>
				<c:choose>
				  <c:when test="${teamdetail.attendence_status eq 1}">
				    <button class="badge bg-Disabled" type="button" style="background-color:#c3c7f8; border:none;">출근</button>
				  </c:when>
				  <c:when test="${teamdetail.attendence_status eq 2}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#D8BFD8; border:none;">퇴근</button>
				  </c:when>
				  <c:when test="${teamdetail.attendence_status eq 3}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#f5a395; border:none;">자리비움</button>
				  </c:when>
				  <c:when test="${teamdetail.attendence_status eq 4}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#f8e589; border:none;">월차</button>
				  </c:when>
				  <c:when test="${teamdetail.attendence_status eq 5}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#c8c7c7; border:none;">조퇴</button>
				  </c:when>
				  <c:when test="${teamdetail.attendence_status eq 6}">
				    <button class="badge bg-Disabled"type="button" style="background-color:#bef78b; border:none;">연차</button>
				  </c:when>
				  <c:otherwise>
				    <button class="badge bg-Disabled"type="button" style="background-color:#FF0000; border:none;">결근</button>
				  </c:otherwise>
				</c:choose>
			</td>
			<td class="text-xs">${teamdetail.attendence_regdate.toLocalDate().toString().substring(0, 10)}</td>
			<td>${teamdetail.attendence_reason}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</div>

</div>
<div class="col-md-5" >
<iframe  id='my_frame' style=" border:none; width:350px; height: 600px; margin-right:30px;"> 
<div style="margin-left:10px;">
<span style="width:100px;height:100px; background-color:red;">사진</span>
<span>이름:직급</span>
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
			<td>출근</td>
			<td>지각</td>
			<td>결근</td>
			<td>조퇴</td>
			<td>출근률</td>
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
		<tr>
			<td>날짜</td>
			<td>출근시간</td>
			<td>퇴근시간</td>
			<td>근태상태</td>
		</tr>
	</tbody>
</table>


</iframe>
</div>
<script>
function open_in_frame(url) {
	$('#my_frame').attr('src', url);
}

</script>
<%@include file="/WEB-INF/jsp/include/foot.jspf" %>