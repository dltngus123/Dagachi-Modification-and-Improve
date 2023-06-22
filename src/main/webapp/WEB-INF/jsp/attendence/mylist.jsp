<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
<body style="overflow-y:hidden;">

<input type="hidden" name="${attendence.attendence_regDate }"/>

   <div class="" style="margin-top:10px;">
 <form class="" style="text-align:right;margin-right:10px;">
    <div class="flex w-full justify-between btns">
    <div class="w-1/2  text-left"><div style="margin:10px;">근태 : <span class="text-blue-700">${attendenceCount }</span> 건</div></div>
  <input type="hidden" name="reservation_code" value="${param.reservation_code}" />
     <div class="flex">
  <select name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode}" id="searchKeywordTypeCode" class="w-1/3 input input-bordered select select-bordered">
    <option disabled="disabled" >검색타입</option>
    <option value="attendence_status"${param.searchType=='attendence_status'? 'selected':'' }>출.퇴근상태</option>
    <option value="attendence_regDate"${param.searchType=='attendence_regDate'? 'selected':'' }>날짜</option>
    
  </select>
  <input name="searchKeyword" type="text" class="w-1/2 input input-bordered" placeholder="검색어" maxlength="20" value="${param.searchKeyword}" id="searchKeyword" />
  <button type="submit" class="col-sm-1 btn form-control btn-default" onclick="">
                 <i class="fas fa-search"></i>
       </button>
     </div>
    </div>
</form>
    
  </div>
  
  
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
             <tr class="hover">
                <th>부서명</th>
                <th>팀명</th>
               <th>날짜</th>
               <th class="text-blue-700">출근</th>
               <th class="text-red-700">퇴근</th>
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
                    <td class="text-blue-700">
                        <c:if test="${attendence.attendence_status eq 1}">
                            <fmt:formatDate value="${attendence.attendence_regDate}" pattern="HH:mm:ss" />
                        </c:if>
                    </td>
                    <td class="text-red-700">
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
   <div class="flex justify-center">
  <div class="col">
    <nav aria-label="Contacts Page Navigation" class="">
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${page - pageMenuArmLen < 1 ? 1 : page - pageMenuArmLen}" />
      <c:set var="endPage" value="${page + pageMenuArmLen > pagesCount ? pagesCount : page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="boardId=${boardId}&searchKeyword=${param.searchKeyword}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
      <ul class="pagination flex ">
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
function openwindow(url) {
  window.open(url, 'vacationdetail', 'width=600,height=600');
}
</script>

<script>
function open_in_frame(url) {
   $('#my_frame').attr('src', url);
}
</script>

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>