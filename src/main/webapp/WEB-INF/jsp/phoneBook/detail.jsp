<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/jsp/include/openhead.jspf"%>
   <div class="wrapper mx-auto" style="background: #f9f9f9; max-width:800px;">
   <section class="content-header">
        <div class="container-fluid">
           <div class="flex md-2 items-center">
              <div class="w-1/2">
              <c:if test="${phoneBook.phone_Book_Type ne '3' }">
                 <h1 class="font-bold text-3xl p-4">주소록 상세조회</h1>
              
              </c:if>
              <c:if test="${phoneBook.phone_Book_Type eq '3' }">
                 <h1 class="font-bold text-3xl p-4">주소록 복구</h1>               
              </c:if>
              </div>
              <div class="w-1/2">
                 <ol class="breadcrumb flex float-right">
                 <li class="breadcrumb-item mr-2">
                    <a href="#">
                       
                       <i class="fa fa-dashboard">주소록</i>
                    </a>
                 </li>
            <li class="mr-2">></li>
                 <li class="breadcrumb-item active">
                    <c:if test="${phoneBook.phone_Book_Type ne '3' }">

                       주소록 상세조회
                    </c:if>
                    <c:if test="${phoneBook.phone_Book_Type eq '3' }">
                       주소록 복구
                    </c:if>
                 </li>              
            </ol>
              </div>
           </div>
        </div>
        <hr/>
     </section>
     <section class="w-5/6 mx-auto content-body">
        
        <div class="mt-4">

           <div class="flex items-center">
              <label for="" class="w-1/4">이름</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Name }"/>
            </div>

           <div class="flex items-center mt-2">
           <label for="" class="w-1/4">전화번호</label>
           <select class="input input-bordered w-1/6 mr-2" disabled="disabled" name="phone1" id="">
              <option value="010" ${phone1 eq '010' ? 'selected':'' }>010</option>
              <option value="011" ${phone1 eq '011' ? 'selected':'' }>011</option>
              <option value="016" ${phone1 eq '016' ? 'selected':'' }>016</option>
              <option value="017" ${phone1 eq '017' ? 'selected':'' }>017</option>
           </select>
           <input type="text" class="w-1/6 mr-2 input input-bordered" disabled="disabled" value="${phone2 }"/>
           <input type="text" class="w-1/6 input input-bordered" disabled="disabled" value="${phone3 }"/>
           </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">이메일</label>
              <input type="text" class="w-1/6 input input-bordered" disabled="disabled" value="${email1 }"/>&nbsp;@&nbsp;
              <input type="text" class="w-1/4 input input-bordered" disabled="disabled" value="${email2 }"/>
            </div>
           
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4" >태그</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Tag }"/>
            </div>

           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">회사명</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Company }"/>
            </div>

           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">부서</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Dep }"/>
            </div>

           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">직급</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Rank }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">웹사이트</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Web }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">팩스</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Fax }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">주소</label>
              <input type="text" class="w-1/2 input input-bordered" disabled="disabled" value="${phoneBook.phone_Book_Address }"/>
            </div>
           <br />
           <div class="w-3/4 flex items-center my-4 mx-auto justify-center">
        <c:if test="${phoneBook.phone_Book_Type ne '3' }">
           <button type="button" class="btn bg-blue-300 w-1/6 mr-2 my-4" 
           onclick="location.href='modifyForm?phone_Book_Id=${phoneBook.phone_Book_Id}&phone_Book_Register=${phoneBook.phone_Book_Register}'">수정</button>
           <button type="button" class="btn bg-red-400 w-1/6" onclick="deleteGo(${phoneBook.phone_Book_Id})">삭제</button>
        
        </c:if>
        <c:if test="${phoneBook.phone_Book_Type eq '3' }">
           <button type="button" class="btn bg-blue-400 w-1/3 mr-2 my-4" onclick="recoveryPhoneBook(2);" 
           >개인 주소록 복구</button>
           
           <button type="button" class="btn bg-blue-400 w-1/3 mr-2" onclick="recoveryPhoneBook(1);" 
           >공유 주소록 복구</button>
           
           <button type="button" class="btn bg-red-400 w-1/4" onclick="eliminate(${phoneBook.phone_Book_Id})"
           >영구 삭제</button>
        </c:if>
        
     </div>
     </section>
        </div>
        
     
     
     
     
     
     
   
<%@include file="/WEB-INF/jsp/include/openfoot.jspf"%>
<script>
function deleteGo(phoneBookId){
   if(!confirm('정말 삭제 하시겠습니까?')){
      //alert('아니오');
   }else{
      //alert('예');
      location.href='moveTrash?phone_Book_Id='+phoneBookId;
      alert("해당 정보는 휴지통으로 이동되었으며 30일 경과 후 자동으로 삭제됩니다.");
      window.opener.location.reload(true);
      window.close();
   }

}

function recoveryPhoneBook(pbType){
   if(confirm('해당 주소록을 복구 하시겠습니까?')){
      location.href='recoveryPhoneBookAtDetail?phone_Book_Id='+${phoneBook.phone_Book_Id}+'&phone_Book_Type='+pbType;
      
   }
}


function eliminate(id){
   if(confirm('해당 주소록을 영구 삭제 하시겠습니까?')){
      location.href='eliminatePhoneBook?phone_Book_Id='+${phoneBook.phone_Book_Id};
      
   
   }
}
</script>