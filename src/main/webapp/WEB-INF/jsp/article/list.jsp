<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>

<script>
   
   window.addEventListener('load', function(){
        checkedBookMark("/article/list");
         
      })
   
</script>

<div class="p-4 sm:ml-64">

<div class="content-header mb-4">
<div class="content-header">
<h1 class="text-3xl">
   <a href='javascript:registBookMark("/article/list", "공유게시판 조회")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      공유 게시판
      </span>
   </h1>
</div>
</div>
<div class="flex justify-between" >
<div class="w-1/2">
   <button onclick="write_go();" class="btn btn-sm bg-blue-400 text-white" >글작성</button>
</div>
<div class="w-1/2 flex justify-end">
 <form class="flex w-full justify-end" style="">
  <div class="w-full flex justify-end input-bordered" >
        <input type="hidden" name="article_id" value="${param.article_id}"/>
           <select name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode }" id="" class="input-sm w-1/5 input input-bordered ">
               <option disabled="disabled">검색타입</option>
              <option value="article_title" ${param.searchType=='article_title'? 'selected':'' }>제목</option>
              <option value="article_regdate" ${param.searchType=='article_regdate'? 'selected':'' }>작성일</option>
              <option value="article_register" ${param.searchType=='article_register'? 'selected':'' }>작성자</option>
           </select>
        <input name="searchKeyword" type="text" class="w-3/5 input input-bordered input-sm" placeholder="검색어" maxlength="20" value="${param.searchKeyword }" />
            <button type="submit" class="w-1/8 bg-blue-300 btn-sm btn">
            	<i class="fas fa-search text-lg"></i>
            </button>
            </div>
     </form>
</div>
</div>
<div class="col-md-12">
 <div style="margin:10px;">게시글 : <span class="text-blue-700">${articleCount }</span> 건</div>
<table class="table w-full">
   <thead>
      <tr>
         <th>글 번호</th>
         <th>제목</th>
         <th>첨부파일</th>
         <th>작 성일</th>
         <th>작 성자</th>
      </tr>
   </thead>
   <tbody>
         <c:forEach var="article" items="${borad2 }">
      <tr>
         <td>${article.article_id }</td>
         <td><a href="/article/detail?article_id=${article.article_id }" >${article.article_title}</a></td>   
         <td><c:if test="${article.article_attach != null}">
                <div class="">💾</div>
            </c:if>
         </td>
         <td>${article.article_regdate.substring(0, 11) }</td>
         <td>${article.member_name }</td>
      </tr>
         </c:forEach>
   </tbody>
</table>
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




<%@include file="/WEB-INF/jsp/include/foot.jspf" %>
<script>
function write_go(){
   
    window.location.href = "/article/insert";
}

</script>



