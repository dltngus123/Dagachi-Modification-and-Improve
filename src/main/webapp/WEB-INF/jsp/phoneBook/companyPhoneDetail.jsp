<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/jsp/include/openhead.jspf"%>
   <div class="wrapper col-12 mx-auto" style="background: #f9f9f9; max-width:800px;">
   <section class="content-header p-4">
         <div class="container-fluid">
           <div class="flex">
              <div class="w-1/2 text-3xl">
                 <h1>주소록 상세조회</h1>              
              </div>
                <div class="w-1/2 text-lg">
                 <ol class="breadcrumb float-right flex">
                 <li class="breadcrumb-item mr-4">
                    <a href="#">
                       <i class="fa fa-dashboard">주소록</i>
                    </a>
                 </li>
                 <li class="breadcrumb-item active">
                    사원 상세조회
                 </li>              
            </ol>
              </div>
           </div>
        </div>
        <hr/>
     </section>
     <section class="col-10 mx-auto content-body">
        <div class="mt-4">
        <div class="manPicture my-4" data-id="${phoneBook.member_id }" style="height:250px;"></div>

           <div class="flex w-5/6 mx-auto">
              <label for="" class="w-1/4 self-center font-bold text-lg">이름</label>
              <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_name }"/>
            </div>

           <div class="flex w-5/6 mx-auto mt-2">
           <label for="" class="w-1/4 self-center font-bold text-lg">전화번호</label>
           <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_phone}"/>
           </div>
           
           <div class="flex w-5/6 mx-auto mt-2">
              <label for="" class="w-1/4 self-center font-bold text-lg">이메일</label>
              <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_email}"/>
              
            </div>
           
            </div>
           
           <div class="flex w-5/6 mx-auto mt-2">
              <label for="" class="w-1/4 self-center font-bold text-lg" >부서</label>
              <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_department1 }"/>
            </div>

           <div class="flex w-5/6 mx-auto mt-2">
              <label for="" class="w-1/4 self-center font-bold text-lg">팀</label>
              <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_team1 }"/>
            </div>

           <div class="flex w-5/6 mx-auto mt-2">
              <label for="" class="w-1/4 self-center font-bold text-lg">직급</label>
              <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_rank }"/>
            </div>
           
           <div class="flex w-5/6 mx-auto mt-2">
              <label for="" class="w-1/4 self-center font-bold text-lg">주소</label>
              <input type="text" class="col-sm-6 form-control w-1/2 mr-2 input input-bordered" disabled="disabled" value="${phoneBook.member_address }"/>
            </div>
           
         <div class="text-center mt-4">
        <button type="button" class="btn bg-blue-300 btn-md w-1/4" onclick="window.close()" 
        >창 닫기</button>
        
     </div>
        </div>
     </section>
     
     
     
     
     
   
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

window.onload=function(){
   MemberPictureThumb('<%=request.getContextPath()%>');
}
</script>