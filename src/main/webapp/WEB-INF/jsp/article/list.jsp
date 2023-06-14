<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>
<script>
   window.onload=function(){
      bookMarkList();
      checkedBookMark("/article/list");
   }
   
</script>
<div class="p-4 sm:ml-64">

<div class="col-md-12">
<div class="content-header">
<h1>
   <a href='javascript:registBookMark("/article/list", "공유게시판 조회")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      공유 게시판
      </span>
   </h1>
</div>
</div>
<div class="col-md-12" style="display:flex;">
<div class="col-md-6">
   <button onclick="write_go();" class="btn btn-default col-sm-2" style="background-color:#5865F2; color:white;">글작성</button>
</div>
<div class="col-md-6">
 <form class="row" style="text-align:right;margin-right:10px;">
        <input type="hidden" name="article_id" value="${param.article_id}"/>
           <select name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode }" id="" class="select select-bordered col-sm-3 form-control">
              <option disabled="disabled">검색타입</option>
              <option value="article_title">제목</option>
              <option value="article_regdate">작성일</option>
              <option value="article_register">작성자</option>
           </select>
        <input name="searchKeyword" type="text" class="col-sm-8 form-control" placeholder="검색어" maxlength="20" value="${param.searchKeyword }" />
            <button type="submit" class="btn btn-default form-control col-sm-1">
            	<i class="fas fa-search"></i>
            </button>
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
               <i class="fa fa-file"></i>
            </c:if>
         </td>
         <td>${article.article_regdate.substring(0, 11) }</td>
         <td>${article.member_name }</td>
      </tr>
         </c:forEach>
   </tbody>
</table>
</div>
   <div class="row">
  <div class="col">
    <nav aria-label="Contacts Page Navigation">
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${page - pageMenuArmLen < 1 ? 1 : page - pageMenuArmLen}" />
      <c:set var="endPage" value="${page + pageMenuArmLen > pagesCount ? pagesCount : page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="boardId=${article.board_Id}&searchKeyword=${param.searchKeyword}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
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



</div>




<%@include file="/WEB-INF/jsp/include/foot.jspf" %>
<script>
function write_go(){
   
    window.location.href = "/article/insert";
}

</script>



