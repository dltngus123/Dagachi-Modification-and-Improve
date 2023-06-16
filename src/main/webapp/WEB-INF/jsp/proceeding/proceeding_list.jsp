<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/head.jspf"%>
<div class="p-4 sm:ml-64">


<div class="content-header mb-4">
<h1 class="text-3xl">
   <a href='javascript:registBookMark("/dagachi/proceeding/list", "회의록 전체 조회")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      회의록
      </span>
   </h1>
</div>
	<div class="col-12">
	  <div class="card">
	    <div class="card-header flex justify-between">
	      <!-- <h3 class="card-title"></h3> -->
	      <div class="btns col-sm-6">
	      	<button type="button" class="btn btn-sm bg-blue-400 text-white" 
	      	onclick="location.href='regist'">회의록 등록</button>
	      </div>
	      <div class="card-tools col-sm-6">
	        <form action="list" class="">
			<div class="w-full flex justify-end input-bordered" >
	          <select name="searchType" class="input-sm w-2/5 input input-bordered ">
	          	<option value="" disabled="disabled" selected="selected">검색구분</option>
	          	<option value="title" ${searchType eq 'title' ? 'selected':'' }>제목</option>
	          	<option value="body" ${searchType eq 'body' ? 'selected':'' }>내용</option>
	          </select>
	          <input class="w-3/5 input input-bordered input-sm"
	            type="text"
	            name="keyword"
	            
	            placeholder="Search"
	            value="${keyword }"
	          />
	       
	          <div class="input-group-append">
	             <button type="submit" class="w-1/8 bg-blue-300 btn-sm btn">
            	<i class="fas fa-search text-lg"></i>
            	</button>
	          </div>
	        </div>
	        </form>
	      </div>
	    </div> 
	
	    <div class="card-body table-responsive p-0">
	      <table class="table table-hover text-nowrap col-sm-11 mx-auto">
	        <thead>
	          <tr class="text-center">
	          	
	           	<th class="col-sm-2">회의록 번호</th>
	            <th class="col-sm-4">회의 제목</th>
	           	<th class="col-sm-1">구분</th><!-- 회의 중요도 뱃지 출력  -->
	           	<th class="col-sm-3">등록 및 수정 일자</th>
	           	<th class="col-sm-2">등록자</th>
	          </tr> 
	        </thead>
	        <tbody id="ListTable">
	        	<c:forEach var="imp" items="${proceedingImpList }">
	        		<tr class="text-center text-red text-bold">
	        			<td>${imp.proceeding_id }</td>
	        			
	        			<td>
	        			<a href="detail?proceeding_id=${imp.proceeding_id }" class=" text-red text-bold">
	        			${imp.form_proceeding_title }
	        			</a>
	        				
	        			</td>
	        			
	        			<td>
	        				<span class="badge bg-red-400 text-white">긴급</span>
	        			</td>
	        			<fmt:formatDate pattern="yyyy.MM.dd" value="${imp.form_proceeding_updateDate }" var="updateDate"/>
	        			<td>${updateDate }</td>
	        			<td>${imp.extra_member_name }</td>
	        		</tr>
	        	</c:forEach>
	        	<c:forEach var="proceed" items="${proceedingList }">
	        		<tr class="text-center">
	        			<td>${proceed.proceeding_id }</td>
	        			<td>
							<a href="detail?proceeding_id=${proceed.proceeding_id }" style="text-decoration: none; color:black;">
	        					${proceed.form_proceeding_title }
	        				</a>
	        			</td>
	        			
	        			<td>
	        				<c:if test="${proceed.form_proceeding_type eq 0 }">
	        					<span class="badge bg-red-400 text-white" >긴급</span>
	        				</c:if>
	        				<c:if test="${proceed.form_proceeding_type eq 1 }">
	        					<span class="badge bg-primary text-white">주간</span>
	        				</c:if>
	        				<c:if test="${proceed.form_proceeding_type eq 2 }">
	        					<span class="badge bg-primary text-white">월간</span>
	        				</c:if>
	        				<c:if test="${proceed.form_proceeding_type eq 3 }">
	        					<span class="badge bg-warning text-white">임원</span>
	        				</c:if>
	        				<c:if test="${proceed.form_proceeding_type eq 4 }">
	        					<span class="badge bg-success text-white">협력</span>
	        				</c:if>
	        			</td>
	        			<fmt:formatDate pattern="yyyy.MM.dd" value="${proceed.form_proceeding_updateDate }" var="updateDate"/>
	        			<td>${updateDate }</td>
	        			<td>${proceed.extra_member_name }</td>
	        		</tr>
	        	</c:forEach>
	        	
	        </tbody>
	      </table>
	      
	    </div>
	  </div>
	      <div class="">
  <div class="col">
    <nav aria-label="Contacts Page Navigation">
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${page - pageMenuArmLen < 1 ? 1 : page - pageMenuArmLen}" />
      <c:set var="endPage" value="${page + pageMenuArmLen > pagesCount ? pagesCount : page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="boardId=${article.board_id}&searchKeyword=${param.searchKeyword}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
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
          <li class="page-item">
            <a class="page-link btn btn-sm  ${param.page == i ? 'btn-active' : ''}" href="?${pageBaseUri}&page=${i}">${i}</a>
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
	
   </div>



<%@include file="../include/foot.jspf"%>
<script>


window.addEventListener('load', function(){
     checkedBookMark("/dagachi/proceeding/list");
      
   })

</script>
