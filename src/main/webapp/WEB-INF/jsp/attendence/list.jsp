<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>
<style>
.rounded_div {
  border-radius: 20%;
  background-color:#1d2472;
  height: 100px;
  width: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}


</style>

<script>
   window.onload=function(){
      bookMarkList();
      checkedBookMark("/attendence/list");
   }
   
</script>
<input type="hidden" name="${attendence.attendence_regDate }"/>
<div class="p-4 sm:ml-64">
<div class="content-header">
<h1>
   <a href='javascript:registBookMark("/attendence/list", "근태 조회")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      근태 관리
      </span>
   </h1>
</div>
		<div class="col-lg-12" style="display:flex; justify-content:start;" >
		<div class="info-box mb-6 "  style="background-color: #5865F2;">
		<div class="member" style="display:flex; justify-content:center; color:white;">
	
		
		<div id="userimg" class="col-sm-6" style="width: 100px; height: 100px; border-radius: 50%;">
  <img src="${pageContext.request.contextPath}/attendence/getPicture?id=${loginUser.member_name}" alt="User Image"
    style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
</div>

		<div class="info-box-content">
		<span class="info-box-text"></span>
			<div>
			<c:if test="${loginUser.member_team ==1 }">1팀</c:if>
			<c:if test="${loginUser.member_team ==2 }">2팀</c:if>
			<c:if test="${loginUser.member_team ==3 }">3팀</c:if>
			<c:if test="${loginUser.member_team ==4 }">1팀</c:if>
			<c:if test="${loginUser.member_team ==5 }">2팀</c:if>
			<c:if test="${loginUser.member_team ==6 }">3팀</c:if>
			<c:if test="${loginUser.member_team ==7 }">1팀</c:if>
			<c:if test="${loginUser.member_team ==8 }">2팀</c:if>
			<c:if test="${loginUser.member_team ==9 }">3팀</c:if>
			<c:if test="${loginUser.member_team ==10 }">1팀</c:if>
			<c:if test="${loginUser.member_team ==11 }">2팀</c:if>
			<c:if test="${loginUser.member_team ==12 }">3팀</c:if>
			</div>
			<span>직급 : ${loginUser.member_rank }</span></span>
		</div>
		</div>
<div class="col-lg-6 col-6" style="margin-left: auto; text-align: center;">
  <div class="inner" style="height: 100px; color: white; font-size: 1.2rem; display: flex; justify-content:flex-end;">
    <input type="hidden" name="vacation_member" />

    <div class="rounded_div" style="margin-right: 50px;" onmouseout="this.style.backgroundColor= '#1d2472'"
                                    onmouseover="this.style.backgroundColor= '#5865f2'">
                                    <div class="text-block">
                                          <a href="#" style="color: inherit; font-size: 1rem"
                                                onclick="OpenWindow('/attendence/vacationdetail','연/월차 조회', 1000,500);">
                                                잔여 연차
                                                <i class="fas fa-search "></i>
                                          </a>
                                    </div>
                                    <span class="delYear">
                                          <a href="#" style="color: inherit;" onclick="OpenWindow('/attendence/vacationdetail','연/월차 조회',1000,500);">
                                                <div style="font-weight: bold;">${vacationYear - DelYear}</div>
                                          </a>
                                    </span>
                              </div>


     <div class="rounded_div" onmouseout="this.style.backgroundColor= '#1d2472'"
                                    onmouseover="this.style.backgroundColor= '#5865f2'">

                                    <div class="text-block">
                                          <a href="#" style="color: inherit; font-size: 1rem"
                                                onclick="OpenWindow('/attendence/vacationdetail','연/월차 조회',1000,500);">
                                                잔여 월차
                                                <i class="fas fa-search "></i>
                                          </a>
                                    </div>
                                    <span>
                                          <a href="#" style="color: inherit;" onclick="OpenWindow('/attendence/vacationdetail','연/월차 조회',1000,500);">
                                                <div style="font-weight: bold;">${vacationMonth - DelMonth}</div>
                                          </a>
                                    </span>
                              </div>

  </div>
</div>

		</div>
		</div>

  <div class="select" style="display:flex; margin:15px; justify-content:space-around;">
	  <div class="mine">
	    <a href="#" onclick='open_in_frame("/attendence/mylist")' style="  font-weight: bold;">근태 조회</a>
	  </div>
 <c:if test="${loginUser.member_auth == 3}">
    <div class="department-or-team">
        <a href="#" onclick='open_in_frame("/attendence/departmentlist")' style=" font-weight: bold;">부서별 근태 조회</a>
    </div>
</c:if>
<c:if test="${loginUser.member_auth == 2}">
    <div class="department-or-team">
        <a href="#" onclick='open_in_frame("/attendence/teamlist")' style=" font-weight: bold;">팀별 근태 조회</a>
    </div>
</c:if>

	</div>
	<hr/>
<iframe id='my_frame' class="col-sm-12"style=" border:none; margin-left:15px;width: 1600px; height: 700px;">
<input type="hidden" name="${attendence.attendence_regDate }"/>
<div class="flex" style="margin-top:10px;">
     <form class="flex" style="text-align:right;margin-right:10px;">
        <input type="hidden" name="reservation_code" value="${param.reservation_code}" />
        	<select name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode }" id="" class="select select-bordered">
	           <option disabled="disabled">검색타입</option>
	           <option value="attendence_status">출.퇴근상태</option>
	           <option value="attendence_regDate">날짜</option>
	           <option value="member_department">부서별</option>
	           <option value="member_team">팀별</option>
	           <option value="room_code,reservation_member">출.퇴근상태,날짜</option>
        	</select>
        <input name="searchKeyword" type="text" class="ml-2 w-72 input input-bordered" placeholder="검색어" maxlength="20" value="${param.searchKeyword }" />
      		<button type="submit" style="background-color:#5865F2; color:white; border:none;">검색</button>
     </form>
    
  </div>
  <div style="margin:10px;">근태 : <span class="text-blue-700">${attendenceCount }</span> 건</div>
  
	<div class="content-list" style="margin:10px;">
		<div class="mt-3">
	      <table class="table w-full">
	        <colgroup>   
	          <col width="50"/>
	          <col width="50"/>
	          <col width="50"/>
	          <col width="50"/>
	          <col width="50"/>
	          <col width="50"/>
	          <col width="50"/>
	        </colgroup>
	        <thead>
	          <tr>
	          	<th>부서명</th>
	          	<th>팀명</th>
	            <th>날짜</th>
				<th>출근</th>
				<th>퇴근</th>
	            <th>유형</th>
	            <th>사유</th>
	          </tr>
	        </thead>
	        <tbody>
	       <c:forEach var="attendence" items="${attendences}">
				    <tr class="hover">
				    	<th>
				    		<c:if test="${attendence.member_department eq 1}">인사 부서</c:if>
				    		<c:if test="${attendence.member_department eq 2}">마케팅 부서</c:if>
				    		<c:if test="${attendence.member_department eq 3}">영업 부서</c:if>
				    		<c:if test="${attendence.member_department eq 4}">관리 부서</c:if>
				    	</th>
				    	<th>
				    		<c:if test="${attendence.member_team eq 1}">인사 1팀</c:if>
				    		<c:if test="${attendence.member_team eq 2}">인사 2팀</c:if>
				    		<c:if test="${attendence.member_team eq 3}">인사 3팀</c:if>
				    		<c:if test="${attendence.member_team eq 4}">마케팅 1팀</c:if>
				    		<c:if test="${attendence.member_team eq 5}">마케팅 2팀</c:if>
				    		<c:if test="${attendence.member_team eq 6}">마케팅 3팀</c:if>
				    		<c:if test="${attendence.member_team eq 7}">영업 1팀</c:if>
				    		<c:if test="${attendence.member_team eq 8}">영업 2팀</c:if>
				    		<c:if test="${attendence.member_team eq 9}">영업 3팀</c:if>
				    		<c:if test="${attendence.member_team eq 10}">관리 1팀</c:if>
				    		<c:if test="${attendence.member_team eq 11}">관리 2팀</c:if>
				    		<c:if test="${attendence.member_team eq 12}">관리 3팀</c:if>
				    	</th>
				        <td><fmt:formatDate value="${attendence.attendence_regDate}" pattern="yyyy-MM-dd" /></td>
				        <td>
				            <c:if test="${attendence.attendence_status eq 1}">
				                <fmt:formatDate value="${attendence.attendence_regDate}" pattern="HH:mm:ss" />
				            </c:if>
				        </td>
				        <td>
				            <c:if test="${attendence.attendence_status eq 2}">
				                <fmt:formatDate value="${attendence.attendence_regDate}" pattern=" HH:mm:ss" />
				            </c:if>
				            <c:if test="${attendence.attendence_status eq 3}">
				                <fmt:formatDate value="${attendence.attendence_regDate}" pattern=" HH:mm:ss" />
				            </c:if>
				            <c:if test="${attendence.attendence_status eq 4}">
				                <fmt:formatDate value="${attendence.attendence_regDate}" pattern=" HH:mm:ss" />
				            </c:if>
				            <c:if test="${attendence.attendence_status eq 5}">
				                <fmt:formatDate value="${attendence.attendence_regDate}" pattern=" HH:mm:ss" />
				            </c:if>
				            <c:if test="${attendence.attendence_status eq 6}">
				                <fmt:formatDate value="${attendence.attendence_regDate}" pattern=" HH:mm:ss" />
				            </c:if>
				        </td>
				        <td>
				            <c:if test="${attendence.attendence_status eq 4}">
				                <button type="button" style="background-color:#ffd400;  border:none;">휴가</button>
				            </c:if>
				            <c:if test="${attendence.attendence_status eq 5}">
				                <button type="button" style="background-color:#808080;  border:none;">조퇴</button>
				            </c:if>
				            <c:if test="${attendence.attendence_status eq 6}">
				                <button type="button" style="background-color:#81c147; border:none;">연차</button>
				            </c:if>
				        </td>
				        <td>${attendence.attendence_reason}</td>
				    </tr>
				</c:forEach>

	        </tbody>
	      </table>
    	</div>
	</div>
   <div class="row">
  <div class="col">
    <nav aria-label="Contacts Page Navigation">
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${page - pageMenuArmLen < 1 ? 1 : page - pageMenuArmLen}" />
      <c:set var="endPage" value="${page + pageMenuArmLen > pagesCount ? pagesCount : page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="boardId=${boardId}&searchKeyword=${param.searchKeyword}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
      <ul class="pagination justify-content-center m-0">
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





</iframe>
 
</div>

<script>
function openwindow(url) {
  window.open(url, 'vacationdetail', 'width=800,height=600');
}
</script>

<script>
function open_in_frame(url) {
	$('#my_frame').attr('src', url);
}
window.addEventListener("DOMContentLoaded", function() {
	  open_in_frame("/attendence/mylist");
	});
</script>

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>