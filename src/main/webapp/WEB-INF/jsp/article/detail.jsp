<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>
<link
   href="/resource/bootstrap/plugins/summernote/summernote-bs4.min.css"
   rel="stylesheet"/>

<div class="p-4 sm:ml-64">
<div class="col-md-12" style="text-align:right; margin-top:15px; margin-bottom:15px;">
<button class="btn btn-sidebar" style="background-color: #D7D7D7; width: 100px; "><a href="/article/list">목록</a></button>
</div>
<div class="col-md-12" style="text-align:center;">
<table class="table w-full" >
   <thead>
   <c:forEach var="article" items="${board}">
      
      <tr>
         <th>제목</th>
         <td style="background-color:white;">${article.article_title}</td>

         <th>작성자</th>
         <td style="background-color:white;">${article.member_name }</td>

         <th>등록일</th>
         <td style="background-color:white;">${article.article_regdate.substring(0, 11) }</td>
      </tr>
      </c:forEach>
   </thead>   
</table>

<div class="contentbox">

<c:forEach var="article" items="${board}">
    <textarea class="content summernote" name="content" id="content_${article.article_id}" readonly>${article.article_body}</textarea>
<table class="table w-full">
    <tr>
        <th style="text-align: start;">첨부파일</th>
        <td style="text-align: start;">
            <a href="${article.article_attach}" download>${article.article_attach}</a>
        </td>
    </tr>
</table>


         <c:if test="${loginUser.member_id eq  article.article_register }">
         <input type="hidden" name="article_id" value="${article.article_id }">
               <span style="float: right;">
                  <button onclick="modify();"
                     class="btn btn-sidebar"
                     style="background-color: #5865F2; width: 100px;">수정</button>
               <script>
                   function confirmDelete() {
                       if (confirm('정말 삭제하시겠습니까?')) {
                          
                           $.ajax({
                               url: '/article/delete', 
                               method: 'POST', 
                               data: { article_id: ${article.article_id} }, 
                               success: function(response) {
                                  
                                   window.location.href = '/article/list'; 
                               },
                               error: function(error) {
                                  
                               }
                           });
                       }
                   }
               </script>
                  <button onclick="confirmDelete();" class="btn btn-sidebar" style="background-color: #DC3545; width: 100px;">삭제</button>
               </span>
               </c:if>
               </c:forEach>
            </div>
   
</div>





</div>


<script>
function modify(){
   location.href="/article/domodify?article_id="+${param.article_id};
}
</script>



<script>
    $(document).ready(function() {
      
        $('.summernote').each(function() {
          
            $(this).summernote({
                height: 300,
                toolbar: [], 
                disableResizeEditor: true 
            });
        });
    });
</script>





<%@include file="/WEB-INF/jsp/include/foot.jspf" %>