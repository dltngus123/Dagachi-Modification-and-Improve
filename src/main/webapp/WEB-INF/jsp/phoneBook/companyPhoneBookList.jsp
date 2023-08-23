<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/jsp/include/head.jspf"%>

   <div class="p-4 sm:ml-64">
   <div class="content-header mb-4">
   <h1 class="text-3xl">
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
       <div class="card-header flex justify-between">
         <!-- <h3 class="card-title"></h3> -->
         <div class="btns col-sm-6">
             <button type="button" class="btn btn-sm bg-blue-400" style="color:#ffffff;" onclick="OpenWindow('memberRegist','신규사원',800,900);">신규 사원 등록</button>
         </div>
         <div class="card-tools w-1/3">
           <form action="" class="">
           <div class="input-group input-group-sm w-full">
             <select name="searchType" class="w-1/4">
                <option value="" disabled="disabled" selected="selected">검색구분</option>
                <option value="name" ${param.searchType=='name'? 'selected':'' }>이름</option>
                <option value="dep" ${param.searchType=='dep'? 'selected':'' }>부서</option>
             </select>
             <input
               type="text"
               name="keyword"
               class="w-1/2"
               placeholder="Search"
               value="${param.keyword }"
             />
          
             <div class="input-group-append">
               <button type="submit" class="btn btn-sm">
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
                 <th>상태</th>
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
              <td>
                       
		       <c:if test="${companyPhone.member_status  eq 1 }">
		       <span class="badge bg-blue-400 text-white p-2">출근</span>
		     </c:if>
		     
		     	 <c:if test="${companyPhone.member_status  eq 2 }">
		       <span class="badge bg-red-400 text-white p-2">퇴근</span>
		     </c:if>
		       
		       <c:if test="${companyPhone.member_status  eq 4 }">
		       <span class="badge bg-yellow-400">연차</span>
		     </c:if>
		       <c:if test="${companyPhone.member_status  eq 5 }">
		       <span class="badge bg-yellow-400">월차</span>
		     </c:if>
		       <c:if test="${companyPhone.member_status  eq 3 }">
		       <span class="badge bg-gray-400 text-white">자리비움</span>
		     </c:if>

             </td>
              
              <td>${companyPhone.member_email } <a href="mailto:${companyPhone.member_email }"><button style="font-size:x-small;" class="btn btn-sm bg-yellow-400">send email</button></a></td>
              
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
   checkedBookMark("/dagachi/phoneBook/companyPhoneBookList");
   bookMarkList();
}
</script>