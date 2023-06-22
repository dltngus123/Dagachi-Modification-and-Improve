<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
<input type="hidden" name="member_department">
<input type="hidden" name="attendence_regdate">

<div class="w-auto flex">
<div class="col-md-8" >
<div class="col-md-4">
<div class="card card-primary " style="width:800px; ">
<div class="card-header rounded-2xl" style=" background-color:#808080;">
<h2 class="card-title">
<div>

</div>
<table class="table table-fixed w-auto ">
	<tr class="text-white ">
	<td class=" flex">
	<div>
	<span class="flex text-center">
<c:set var="Team" value="${Teams[0]}"/>
${Team.name}
부서 부장 :<c:set var="member" value="${memberdepartmentname[0]}"/>
  ${member.member_name}&nbsp;&nbsp;
</span>
</div>
<c:forEach var="Team" items="${Teams }"><span class="flex text-center">${Team.name}${Team.team }팀 팀장:<c:forEach var="member" items="${memberdepartmentname}" varStatus="status">
      <c:if test="${status.index != 0 and member.member_team == Team.team}">
        ${member.member_name}&nbsp;&nbsp; 
      </c:if>
    </c:forEach></span></c:forEach>
	</td>
	</tr>
  <tr class="flex justify-items-center">
    <th id="TOTALWORK" style="" >이달 총 근태/이달 총 근무일</th>
 <td>
  <c:forEach var="Team" items="${Teams}" varStatus="teamIndex">
<c:set var="teamNum" value="${Team.team}" />
<c:choose>
<c:when test="${teamNum == 1 || teamNum == 4 || teamNum == 7 || teamNum == 10}">
<c:set var="teamName" value="1팀" />
</c:when>
<c:when test="${teamNum == 2 || teamNum == 5 || teamNum == 8 || teamNum == 11}">
<c:set var="teamName" value="2팀" />
</c:when>
<c:when test="${teamNum == 3 || teamNum == 6 || teamNum == 9 || teamNum == 12}">
<c:set var="teamName" value="3팀" />
</c:when>
<c:otherwise>
<c:set var="teamName" value="" />
</c:otherwise>
</c:choose>
 ${teamName}:
<c:forEach var="todaytotalwork" items="${totalworks}" varStatus="workIndex">
<c:choose>
<c:when test="${teamIndex.index == workIndex.index}">
(${todaytotalwork.total_work_days}/${weekdaysCount })&nbsp;&nbsp;
</c:when>
</c:choose>
</c:forEach>
</c:forEach>
</td>
  </tr>
		<tr>
</table></h2>
<div class="card-tools">

</div>

</div>

<div class="card-body">
<table class="table table-fixed w-full">
  <thead>
		<tr>
		
	
			<th>날짜</th>
			
			 <c:forEach var="Team" items="${Teams}">
  <c:choose>
    <c:when test="${Team.team == 1 || Team.team == 4 || Team.team == 7 || Team.team == 10}">
      <th style="">${Team.name} ${Team.team == 1 ? '1팀' : Team.team == 4 ? '1팀' : Team.team == 7 ? '1팀' : Team.team == 10 ? '1팀' : '2팀'}(출근 인원/총 인원)</th>
    </c:when>
    <c:when test="${Team.team == 2 || Team.team == 5 || Team.team == 8 || Team.team == 11}">
      <th>${Team.name} ${Team.team == 2 ? '2팀' : Team.team == 5 ? '2팀' : Team.team == 8 ? '2팀' : Team.team == 11 ? '2팀' : '3팀'}(출근 인원/총 인원)</th>
    </c:when>
    <c:when test="${Team.team == 3 || Team.team == 6 || Team.team == 9 || Team.team == 12}">
      <th>${Team.name} ${Team.team == 3 ? '3팀' : Team.team == 6 ? '3팀' : Team.team == 9 ? '3팀' : Team.team == 12 ? '3팀' : '1팀'}(출근 인원/총 인원)</th>
    </c:when>
    <c:otherwise>
      <th>${Team.name}(출근 인원/총 인원)</th>
    </c:otherwise>
  </c:choose>
</c:forEach>


		</tr>
	</thead>
 
  <tbody>
 
    <c:forEach var="department" items="${todayTeams}">
      <tr class="hover">
        <td style="width:100px;">${department.attendence_regdate.toLocalDate().toString().substring(0, 10)}</td>
        <c:forEach var="Team" items="${Teams}">
       
          <c:set var="teamName" value="${Team.name}${Team.team}" />
          <td>
            <c:if test="${department.name == Team.name && department.team == Team.team}">
              <c:set var="teamCount" value="${department.team_count}/${Team.team_count}" />
<a href="#" onclick="var myWindow = window.open('/attendence/teamdetail?member_department=${param.member_department }&member_team=${Team.team}&attendence_regDate=${department.attendence_regdate.toLocalDate().toString().substring(0, 10)}', 'departmentdetail2', 'width=1000,height=600,modal=yes,alwaysRaised=yes'); modal.open('/attendence/teamdetail?member_team=${fn:substring(Team.team,0,1)}&attendence_regDate=${department.attendence_regdate.toLocalDate().toString().substring(0, 10)}', 'departmentdetail', 'modal=yes,alwaysRaised=yes');">
  ${teamCount}
</a>

              <form method="POST" action="/attendence/teamdetailgetmember">
                <input type="hidden" name="member_team" value="${Team.team}"/>
              </form>
            </c:if>
          </td>
        </c:forEach>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>

</div>

</div>




   <div class="flex justify-center">
  <div class="col">
    <nav aria-label="Contacts Page Navigation" >
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${page - pageMenuArmLen < 1 ? 1 : page - pageMenuArmLen}" />
      <c:set var="endPage" value="${page + pageMenuArmLen > pagesCount ? pagesCount : page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="member_department=${empty param.member_department ? '' : param.member_department}&searchKeyword=${param.searchKeyword}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
      <ul class="pagination justify-content-center m-0 flex"  >
        <c:if test="${startPage > 1}">
          <li class="page-item">
            <a class="page-link btn btn-sm" href="?${pageBaseUri}&page=1">1</a>
          </li>
          <c:if test="${startPage > 2}">
            <li class="page-item">
              <a class="page-link btn btn-sm">...</a>
            </li>
          </c:if>
        </c:if>
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
          <li class="page-item ${param.page == i ? 'active' : ''}">
            <a class="page-link btn btn-sm" href="?${pageBaseUri}&page=${i}">${i}</a>
          </li>
        </c:forEach>
        <c:if test="${endPage < pagesCount}">
          <li class="page-item">
            <a class="page-link btn btn-sm">...</a>
          </li>
        </c:if>
        <c:if test="${endPage < pagesCount-1}">
          <li class="page-item">
            <a class="page-link btn btn-sm" href="?${pageBaseUri}&page=${pagesCount}">${pagesCount}</a>
          </li>
        </c:if>
      </ul>
    </nav>
  </div>
</div>






</div>

<div class="card ">
<div class="card-header bg-red-400 rounded-xl">
<h3 class="card-title my-3 ml-3 text-white ">출근률</h3>
<div class="card-tools">
</div>
</div>
<div class="card-body">
	<div class="w-auto" >
<div style="margin-left:10px;">
			<canvas id="donutChart"
							style="min-height: 200px; height: 200px; max-height: 250px; max-width: 100%; display: block; width: 521px;"
							width="703" height="337" class="chartjs-render-monitor"></canvas>
							

</div>
</div>

<table class="table table-fixed w-full">
<thead>
		<tr>
			<th>출근</th>
			<th>지각</th>
			<th>결근</th>
			<th>조퇴</th>
			<th>연/월차</th>
			<th>출근률</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${totayStatusTotalCount}</td>
			<td>${todaystatus7TotalCount }</td>
			<td>
			<c:choose>
			    <c:when test="${totalTeamCount-(totayStatusTotalCount+todaystatus5TotalCount+todaystatus7TotalCount+todayStatus4TotalCount)  < 0}">0</c:when>
			    <c:otherwise>${totalTeamCount-(totayStatusTotalCount+todaystatus5TotalCount+todaystatus7TotalCount+todayStatus4TotalCount) }</c:otherwise>
			  </c:choose>
			 </td>
			<td>${todaystatus5TotalCount }</td>
			<td>${todayStatus4TotalCount }</td>
			<td id="TOTAL"></td>
		</tr>
	</tbody>
</table>
<ul style="list-style: none;">
<c:forEach var="Team" items="${Teams}">
  <li style=" font-weight: bold;">
    <c:choose>
      <c:when test="${Team.team == 1 || Team.team == 4 || Team.team == 7 || Team.team == 10}">
        ${Team.name} 1팀
      </c:when>
      <c:when test="${Team.team == 2 || Team.team == 5 || Team.team == 8 || Team.team == 11}">
        ${Team.name} 2팀
      </c:when>
      <c:when test="${Team.team == 3 || Team.team == 6 || Team.team == 9 || Team.team == 12}">
        ${Team.name} 3팀
      </c:when>
      <c:otherwise>
        ${Team.name}
      </c:otherwise>
    </c:choose>
  </li>

  <c:forEach var="department" items="${todayTeams}">
    <c:if test="${department.team == Team.team}">
      <li id="TODAY">${department.attendence_regdate.toLocalDate().toString().substring(0, 10)}: ${String.format("%.2f", department.team_count / weekdaysCount * 100)}%</li>
    </c:if>
  </c:forEach>
</c:forEach>
</ul>
</div>
</div>

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

	var totalWarkEl = document.getElementById("TOTALWORK");
	totalWarkEl.innerHTML =  "이달 총 근태/이달 총 근무일"+"("+weekdaysCount+")" ;

</script>

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
	


//출근 인원수
var totalAttendeeCount = 100;

// 지각 인원수
var lateCount = ${todaystatus7TotalCount};

// 결근 인원수
var absentCount = ${totalTeamCount-(totayStatusTotalCount+todaystatus5TotalCount+todaystatus7TotalCount) };

// 조퇴 인원수
var earlyLeaveCount = ${todaystatus5TotalCount };

// 연원차 인원수
var vacationCount = ${todayStatus4TotalCount }

var totalWorkDays = weekdaysCount;
var actualWorkDays = totalWorkDays - (lateCount + absentCount + earlyLeaveCount + vacationCount);
var attendanceRate = actualWorkDays / totalWorkDays * 100;


var totalWarkEl = document.getElementById("TOTAL");
totalWarkEl.innerHTML = attendanceRate.toFixed(2) + "%";

</script>




<!--JS  -->
<!-- <script>
	window.onload = function() {
		
			var donutChartCanvas = $('#donutChart').get(0).getContext('2d')
			var donutData = {
				labels : [ '출근', '결근', '지각', '조퇴' ],
				datasets : [ {
					data : [ ${totayStatusTotalCount}, ${totalTeamCount-(totayStatusTotalCount+todaystatus5TotalCount+todaystatus7TotalCount) }, ${todaystatus7TotalCount }, ${todaystatus5TotalCount } ],
					backgroundColor : [ '#007BFF', '#DC3545', '#FFC107',
							'#6C757D' ],
				} ]

			}

			var donutOptions = {
				maintainAspectRatio : false,
				responsive : true,
			}
			//Create pie or douhnut chart
			// You can switch between pie and douhnut using the method below.
			new Chart(donutChartCanvas, {
				type : 'doughnut',
				data : donutData,
				options : donutOptions

			})
		
		
		//-------------
		//- BAR CHART -
		//-------------
		var barChartCanvas = $('#barChart').get(0).getContext('2d')
		var barChartData = $.extend(true, {}, myChartData)
		var temp0 = myChartData.datasets[0]
		var temp1 = myChartData.datasets[1]
		barChartData.datasets[0] = temp1
		barChartData.datasets[1] = temp0
		var barChartOptions = {
			responsive : true,
			maintainAspectRatio : false,
			datasetFill : false
		}
		new Chart(barChartCanvas, {
			type : 'bar',
			data : barChartData,
			options : barChartOptions
		})
	}
</script>


   -->


  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
  <script>
    var ctx = document.getElementById('donutChart').getContext('2d');
    var donutChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
    	  labels : [ '출근', '결근', '지각', '조퇴' ],
        datasets: [{
        	data : [ ${totayStatusTotalCount}, ${totalTeamCount-(totayStatusTotalCount+todaystatus5TotalCount+todaystatus7TotalCount) }, ${todaystatus7TotalCount }, ${todaystatus5TotalCount } ],
			backgroundColor : [ '#007BFF', '#DC3545', '#FFC107',
					'#6C757D' ],
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          position: 'bottom',
        }
      }
    });
  </script>
<!-- <script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script> -->
	
	

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>