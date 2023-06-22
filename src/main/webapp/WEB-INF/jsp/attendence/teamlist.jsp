<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
<body class=""style="overflow-y:hidden;">
   
   <div class="flex justify-between" style="margin-top:10px;">
   <div style="margin:10px;">근태 : <span class="text-blue-700">${attendenceCount }</span>건</div>
     <form class="flex" style="text-align:right;margin-right:10px;">
        <input type="hidden" name="reservation_code" value="${param.reservation_code}" />
           <select name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode }" id="" class="select select-bordered">
              <option disabled="disabled">검색타입</option>
              <option value="attendence_regDate">날짜</option>
              <option value="member_team">팀별</option>
           </select>
        <input name="searchKeyword" type="text" class="w-72 input input-bordered" placeholder="검색어" maxlength="20" value="${param.searchKeyword }" />
            <button type="submit" class="col-sm-1 btn form-control btn-default" onclick="">
                 <i class="fas fa-search"></i>
       </button>
     </form>
    
  </div>

   
         
<table class="table table-fixed w-full">
  <colgroup>
    <col width="50"/>
    <c:forEach var="Team" items="${Teams}">
      <col width="50"/>
    </c:forEach>
  </colgroup>
  <thead>
    <tr class="hover">
      <th>날짜</th>
       <c:forEach var="Team" items="${Teams}">
  <c:choose>
    <c:when test="${Team.team == 1 || Team.team == 4 || Team.team == 7 || Team.team == 10}">
      <th>${Team.name} ${Team.team == 1 ? '1팀' : Team.team == 4 ? '1팀' : Team.team == 7 ? '1팀' : Team.team == 10 ? '1팀' : '2팀'} (출근 인원/총 인원)</th>
    </c:when>
    <c:when test="${Team.team == 2 || Team.team == 5 || Team.team == 8 || Team.team == 11}">
      <th>${Team.name} ${Team.team == 2 ? '2팀' : Team.team == 5 ? '2팀' : Team.team == 8 ? '2팀' : Team.team == 11 ? '2팀' : '3팀'} (출근 인원/총 인원)</th>
    </c:when>
    <c:when test="${Team.team == 3 || Team.team == 6 || Team.team == 9 || Team.team == 12}">
      <th>${Team.name} ${Team.team == 3 ? '3팀' : Team.team == 6 ? '3팀' : Team.team == 9 ? '3팀' : Team.team == 12 ? '3팀' : '1팀'} (출근 인원/총 인원)</th>
    </c:when>
    <c:otherwise>
      <th>${Team.name} (출근 인원/총 인원)</th>
    </c:otherwise>
  </c:choose>
</c:forEach>
    </tr>
  </thead>
  <tbody>

    <c:forEach var="department" items="${todayTeams}">
      <tr class="hover">
        <td>${department.attendence_regdate.toLocalDate().toString().substring(0, 10)}</td>
        <c:forEach var="Team" items="${Teams}">
          <c:set var="teamName" value="${Team.name}${Team.team}" />
          <td>
            <c:if test="${department.name == Team.name && department.team == Team.team}">
              <c:set var="teamCount" value="${department.team_count}/${Team.team_count}" />
              <a href="#" onclick="OpenWindow('/attendence/teamdetail?member_department=${department.name == '인사' ? 1 : department.name == '마케팅' ? 2 : department.name == '영업' ? 3 : department.name == '관리' ? 4 : ''}&member_team=${Team.team}&attendence_regDate=${department.attendence_regdate.toLocalDate().toString().substring(0, 10)}','팀별 근태 조회',1000,700)">
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
        
<div class="flex justify-center">
  <div class="col">
    <nav aria-label="Contacts Page Navigation">
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${page - pageMenuArmLen < 1 ? 1 : page - pageMenuArmLen}" />
      <c:set var="endPage" value="${page + pageMenuArmLen > pagesCount ? pagesCount : page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="boardId=${boardId}&searchKeyword=${param.searchKeyword}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
      <ul class="pagination flex justify-center m-0">
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
</body>
  

<script>
function open_in_frame(url) {
   $('#my_frame').attr('src', url);
}
</script>
<script>
function openwindow(url) {
  window.open(url, 'departmentdetail', 'width=800,height=400');
}
</script>

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>