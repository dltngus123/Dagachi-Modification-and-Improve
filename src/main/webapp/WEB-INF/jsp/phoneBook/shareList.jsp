<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../include/head.jspf"%>
 <div class="p-4 sm:ml-64">
   <div class="content-header mb-3">
   <h1 class="text-3xl">
      <c:if test="${phoneBookType eq '1' }">
      <a href='javascript:registBookMark("/dagachi/phoneBook/showList?phone_book_type=1", "공유 주소록")'>
  <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      공유 주소록
      </span>
      </c:if>
      <c:if test="${phoneBookType eq '2' }">
      <a href='javascript:registBookMark("/dagachi/phoneBook/showList?phone_book_type=2", "개인 주소록")'>
  <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      개인 주소록
      </span>
      </c:if>
      <c:if test="${phoneBookType eq '3' }">
      <a href='javascript:registBookMark("/dagachi/phoneBook/showList?phone_book_type=3", "주소록 휴지통")'>
  <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      주소록 휴지통
      </span>
      </c:if>
   </h1>
   </div>
   <div class="col-12">
     <div class="card">
       <div class="card-header flex">
         <!-- <h3 class="card-title"></h3> -->
         <div class="btns w-1/2">
         <c:if test="${phoneBookType ne '3' }">
            <button type="button" class="btn bg-blue-400 btn-sm" style="color:#ffffff;" onclick="OpenWindow('registForm','주소록 등록',800,800);">주소록 등록</button>
            <button type="button" class="btn bg-red-400 btn-sm" style="color:#ffffff;" onclick="deleteChecked();">삭제</button>
         </c:if>
        <c:if test="${phoneBookType eq '3' }">
        <button type="button" class="btn bg-blue-400 btn-sm" style="color:#ffffff;" onclick="recoveryPhoneBookCb(1)">공유 주소록 복구</button>
        <button type="button" class="btn bg-blue-400 btn-sm" style="color:#ffffff;" onclick="recoveryPhoneBookCb(2)">개인 주소록 복구</button>
        <button type="button" class="btn bg-red-400 btn-sm" style="color:#ffffff;" onclick="eliminateChecked()">주소록 영구삭제</button>
           </c:if>            
         </div>
         <div class="w-1/2 flex justify-end">
           <form action="showList" class="flex  justify-end">
           <div class="input-group input-bordered">
             <select name="searchType"class="select2 select2-hidden-accessible input-sm input input-bordered ">
                <option value="name" ${searchType eq 'name' ? 'selected':'' }>이름</option>
                <option value="dep" ${searchType eq 'dep' ? 'selected':'' }>부서</option>
                <option value="tag" ${searchType eq 'tag' ? 'selected':'' }>태그</option>
             </select>
             <input
               type="text"
               name="keyword"
               class="input-sm input input-bordered "
               placeholder="Search"
               value="${keyword }"
             />
          
            <button type="submit" class="w-1/8 bg-blue-300 btn-sm btn rounded">
            	<i class="fas fa-search text-lg"></i>
            </button>
             <input type="hidden" name="phone_book_type" value="${param.phone_book_type }" />
             <input type="hidden" name="phone_book_register" value="${param.phone_book_register }" />
             
           </div>
           </form>
         </div>
       </div>
   
       <div class="card-body table-responsive p-0">
         <table class="table table-hover text-nowrap">
           <thead>
             <tr>
                <th><input type="checkbox" name="all" class="check-all"/></th>
                <th><i class="fas fa-star text-yellow-300"></i></th>
               <th>이름</th>
                 <th>전화번호</th>
                 <th>이메일</th>
                 <th>회사</th>
                 <th>태그</th>
             </tr> 
           </thead>
           <tbody id="ListTable">
           <c:forEach var="sharePhone" items="${phoneBookList }">
             <tr>
              <td><input type="checkbox" class="ab" value="${sharePhone.phone_Book_Id }"/></td>
              
              <td>
                 <a class=" fav fav${sharePhone.phone_Book_Id}" href="javascript:registFav('${sharePhone.phone_Book_Id}');" >
                    <i class="fas fa-star"></i>
                 </a>
              </td>
              
              <td>
                 <a href="javascript:OpenWindow('detail?phone_Book_Id=${sharePhone.phone_Book_Id }','주소록 상세조회',800,800);">
                    ${sharePhone.phone_Book_Name }
                 </a>
              </td>
              
              <td>${sharePhone.phone_Book_Phone }</td>
              
              <td>${sharePhone.phone_Book_Email }</td>
              
              <td>${sharePhone.phone_Book_Company }</td>
              
              <td>
                    <c:if test="${fn:contains(sharePhone.phone_Book_Tag,',') }">
                       <c:forEach items="${fn:split(sharePhone.phone_Book_Tag, ',') }" var="tag">
                          <a href="showList?searchType=tag&phone_book_type=${phoneBookType}&keyword=${tag }">
                             ${tag }
                          </a>
                       </c:forEach>
                    </c:if>
                    <c:if test="${not fn:contains(sharePhone.phone_Book_Tag,',') }">
                          <a href="showList?searchType=tag&phone_book_type=${phoneBookType}&keyword=${sharePhone.phone_Book_Tag }">
                             ${sharePhone.phone_Book_Tag}
                          </a>
                    </c:if>
                    
              </td>
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
      <c:set var="pageBaseUri" value="searchType=${param.searchType }&phone_book_type=${param.phone_book_type }&keyword=${param.keyword }&phone_book_register=${param.phone_book_register }" />
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
   </div>
   
   </div>
   <form name="deleteCb" action="moveTrashCb">
      <input type="hidden" name="checkedId" value=""/>
      <input type="hidden" name="phoneBookType" value="${phoneBookType }"/>
   </form>
   <form name="eliminateCb" action="eliminateCb">
      <input type="hidden" name="checked_EId" value=""/>
   </form>
   
<%@include file="../include/foot.jspf"%>
<script>

function recoveryPhoneBookCb(num){
   //alert('확인');
   const arr=[]
   $('.ab').each(function (index) {
      if($(this).is(":checked")==true){
         //alert($(this).val());
         arr.push($(this).val());
         //alert(arr);
         
       }
   });
   if(confirm('선택한 정보를 복구하시겠습니까?')){
      
      $.ajax({
         url:"recoveryPhoneBook",
         type:"post",
         dataType:"text",
         data:{
            phone_Book_Id:arr,
            phone_Book_Type:num,
            register: '${param.phone_book_register}'
            },
         traditional:true,
         success:function(data){
            $('#ListTable').html(data);
            alert("복구 되었습니다.");
         },
         error:function(error){
            alert(error);
         }
      });
      }
   
}

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
   /* const arr=[]
   $('.ab').each(function (index) {
      if($(this).is(":checked")==true){
         //alert($(this).val());
         arr.push($(this).val());
         //alert(arr);
         $('input[name=checkedId]').val(arr);
         //alert($('input[name=checkedId]').val());
         if(!confirm("해당 정보를 삭제 하시겠습니까?")){
            
         }else{
            $('form[name=deleteCb]').submit();
            alert("해당 정보는 휴지통으로 이동되었으며 30일 경과 후 자동으로 삭제됩니다.");
         }
       }else{
          
          
       }
   }); */
   const arr=[]
   $('.ab').each(function (index) {
      if($(this).is(":checked")==true){
         //alert($(this).val());
         arr.push($(this).val());
         //alert(arr);
         
       }
   });
   
   if(confirm('선택한 정보를 삭제하시겠습니까?')){
   
   $.ajax({
      url:"moveTrashCb",
      type:"post",
      dataType:"text",
      data:{
         checkedIdArr:arr,
         phoneBookType:'${param.phone_book_type}'
         },
      traditional:true,
      success:function(data){
         $('#ListTable').html(data);
         alert("해당 정보는 휴지통으로 이동되었으며 30일 경과 후 자동으로 삭제됩니다.");
      },
      error:function(error){
         console.log(error);
      }
   });
   }
   
}

window.addEventListener('load', function(){
   const favCheckArr=${favIdList};
   //alert(favCheckArr);
   const favClassNameArr=[];
   for(var i=0;i<favCheckArr.length;i++){
      //alert(favCheckArr[i]);
      favClassNameArr.push(".fav"+favCheckArr[i]);
   }
   //alert(favClassNameArr);
   for(var j=0;j<favClassNameArr.length;j++){
      var favClass=$(favClassNameArr[j]).addClass("text-yellow-300");
      
   }
 
   checkedBookMark('/dagachi/phoneBook/showList?phone_book_type=1');
   
}) 

function eliminateChecked(){
   const arr=[]
   $('.ab').each(function (index) {
      if($(this).is(":checked")==true){
         //alert($(this).val());
         arr.push($(this).val());
       }
   });
   if(confirm('선택한 정보를 영구 삭제 하시겠습니까? 삭제 시 복구는 불가능합니다.')){
      
      $.ajax({
         url:"eliminateCb",
         type:"post",
         dataType:"text",
         data:{
            checked_EIdArr:arr,
            phoneBookType:'${param.phone_book_type}',
            register: '${param.phone_book_register}'
            },
         traditional:true,
         success:function(data){
            $('#ListTable').html(data);
            alert("선택하신 정보가 영구 삭제되었습니다.");
         },
         error:function(error){
            alert(error);
         }
      });
      }
   
}

function registFav(num){
   var classText=".fav"+num;
   
   if($(classText).is(".text-yellow-300")){
      $(classText).removeClass("text-yellow-300");
      $.ajax({
         url: "removeFav",
         type: "post",
         dataType: "json",
         data:{
            phone_Book_Id: num,
            userId: '${param.phone_book_register}'
         },
         success:function(data){
            
         }
      
      })
   }else{
      $(classText).addClass("text-yellow-300");
      $.ajax({
         url: "registFav",
         type: "post",
         dataType: "json",
         data:{
            phone_Book_Id: num,
            userId: '${param.phone_book_register}'
         },
         success:function(data){
            
         }
      
      })
   }
}



</script>