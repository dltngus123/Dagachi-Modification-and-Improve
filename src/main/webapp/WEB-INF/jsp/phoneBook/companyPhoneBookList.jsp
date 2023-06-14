<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/jsp/include/head.jspf"%>
<script>
   window.onload=function(){
      bookMarkList();
      checkedBookMark("/dagachi/phoneBook/companyPhoneBookList");
   }
   
</script>
 <div class="p-4 sm:ml-64">
   <div class="content-header">
   <h1>
   <a href='javascript:registBookMark("/dagachi/phoneBook/companyPhoneBookList", "사내 주소록")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      사내 주소록
      </span>
   </h1>
   </div>
   <div class="col-12">
     <div class="card">
       <div class="card-header row">
         <!-- <h3 class="card-title"></h3> -->
         <div class="btns col-sm-6">
             <button type="button" class="btn bg-gradient" style="background: #5865F2; color:#ffffff;" onclick="OpenWindow('memberRegist','신규사원',800,900);">신규 사원 등록</button>
         </div>
         <div class="card-tools col-sm-6">
           <form action="" class="">
           <div class="input-group input-group-sm ">
             <select name="searchType">
                <option value="" disabled="disabled" selected="selected">검색구분</option>
                <option value="name">이름</option>
                <option value="dep">부서</option>
             </select>
             <input
               type="text"
               name="keyword"
               class="form-control float-right"
               placeholder="Search"
             />
          
             <div class="input-group-append">
               <button type="submit" class="btn btn-default">
                 <i class="fas fa-search"></i>
               </button>
             </div>
           </div>
           </form>
         </div>
       </div>
   
       <div class="card-body table-responsive p-0">
         <table class="table table-hover text-nowrap">
           <thead>
             <tr>
                <th class="text-center">사진</th>
               <th>이름</th>
                 <th>전화번호</th>
                 <th>이메일</th>
                 <th>부서</th>
                 <th>팀</th>
                 <th>직급</th>
             </tr> 
           </thead>
           <tbody>
           <c:forEach var="companyPhone" items="${companyPhoneBookList }">
             <tr>
              
              <td class="manPicture" data-id="${companyPhone.member_id }">
                       
              </td>
              
              <td>
                 <a href="javascript:OpenWindow('companyPhoneBookDetail?member_id=${companyPhone.member_id }','주소록 상세조회',800,800);">
                    ${companyPhone.member_name}
                    
                 </a>
              </td>
              
              <td>${companyPhone.member_phone}</td>
              
              <td>${companyPhone.member_email }</td>
              
              <td>${companyPhone.member_department1 }</td>
              <td>${companyPhone.member_team1 }</td>
              
              <td>
                 <a href="">
                    ${companyPhone.member_rank }
                 </a>
              </td>
             </tr>
           </c:forEach>
            
           </tbody>
         </table>
       </div>
     </div>
   </div>
   
   

<%@include file="/WEB-INF/jsp/include/foot.jspf"%>
<script>
function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
   winleft = (screen.width - WinWidth) / 2;
   wintop = (screen.height - WinHeight) / 2;
   var win = window.open(UrlStr , WinTitle , "scrollbars=yes,width="+ WinWidth+",height="+ WinHeight +",top="+wintop+",left="+ winleft +",resizable=yes" );
   win.focus();
}
//체크박스 전부 선택
$( document ).ready( function() {
     $( '.check-all' ).click( function() {
       $( '.ab' ).prop( 'checked', this.checked );
     });
   });
   
   
function deleteChecked(){
   var checked=$('.ab').attr('checked');
   alert(checked);
}

window.onload=function(){
   MemberPictureThumb('<%=request.getContextPath()%>');
}
</script>