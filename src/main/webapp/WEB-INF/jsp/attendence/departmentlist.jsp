<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
   <div class="flex justify-between" style="margin-top:10px;">
   <div style="margin:10px;">근태 : <span class="text-blue-700">${attendenceCount }</span> 건</div>
     <form class="flex" style="text-align:right;margin-right:10px;">
        <input type="hidden" name="reservation_code" value="${param.reservation_code}" />
           <select name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode }" id="" class="select select-bordered">
              <option disabled="disabled">검색타입</option>
              <option value="attendence_regDate">날짜</option>
               <option value="member_department">부서별</option>
           </select>
        <input name="searchKeyword" type="text" class="w-72 input input-bordered" placeholder="검색어" maxlength="20" value="${param.searchKeyword }" />
             <button type="submit" class="col-sm-1 btn form-control btn-default" onclick="">
                 <i class="fas fa-search"></i>
       </button>
     </form>
    
  </div>

<div class="content-list" style="margin:10px;">
   <div class="mt-3">
<table class="table table-fixed w-full">
    <thead>
        <tr>
            <th>날짜</th>
            <c:forEach var="department" items="${departments}">
                <th>${department.name}(출근 인원/총 인원)</th>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="todaydepartment" items="${todayDepartments}">
            <tr>
              <td>${todaydepartment.attendence_regdate.toLocalDate().toString().substring(0, 10)}</td>
            <c:forEach var="department" items="${departments}">
            <c:set var="departmentCode" value="" />
                    <c:choose>
                        <c:when test="${department.name == '인사'}">
                            <c:set var="departmentCode" value="1" />
                        </c:when>
                        <c:when test="${department.name == '마케팅'}">
                            <c:set var="departmentCode" value="2" />
                        </c:when>
                        <c:when test="${department.name == '영업'}">
                            <c:set var="departmentCode" value="3" />
                        </c:when>
                        <c:when test="${department.name == '관리'}">
                            <c:set var="departmentCode" value="4" />
                        </c:when>
                    </c:choose>
                    <td>
                        <c:if test="${department.name == todaydepartment.name}">
                            <a href="#" onclick="openwindow('/attendence/departmentdetail?member_department=${departmentCode}&attedence_regdate=${todaydepartment.attendence_regdate.toLocalDate().toString().substring(0, 10) }')">${todaydepartment.total_count }/${department.totalCount}</a>
                        </c:if>
                    </td>    
                </c:forEach>
            </tr>
        </c:forEach>

    </tbody>
</table>

   </div>
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

</div>


<script>
function openwindow(url) {
  window.open(url, 'departmentdetail', 'width=1250,height=800');
}
</script>
<script>
function open_in_frame(url) {
   $('#my_frame').attr('src', url);
}
</script>

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>