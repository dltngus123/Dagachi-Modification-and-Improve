<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/WEB-INF/jsp/include/openhead.jspf"%>
   <div class="wrapper mx-auto" style="background: #f9f9f9; max-width:800px;">
   <section class="content-header">
        <div class="container-fluid">
           <div class="flex md-2 items-center">
              <div class="w-1/2">
                 <h1 class="text-3xl font-bold">주소록 수정</h1>              
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
                    주소록 수정
                 </li>              
            </ol>
              </div>
           </div>
        </div>
        <hr/>
     </section>
     <form role="form" action="modify">
     <section class="w-5/6 mx-auto content-body"  >
        
        <div class="btn-group btn-group-toggle flex col-sm-12"" data-toggle="buttons">
           <c:if test="${phoneBook.phone_Book_Type ne '3' }">
         <label class="btn bg-gray-400 w-1/2">
            <input type="radio" name="phone_Book_Type" value="1" ${phoneBook.phone_Book_Type==1? 'checked':'' }> 공유
         </label>
         <label class="btn bg-gray-400 w-1/2">
            <input type="radio" name="phone_Book_Type" value="2" ${phoneBook.phone_Book_Type==2? 'checked':'' }> 개인
         </label>
           </c:if>
      </div>
        <div class="mt-4">

           <div class="flex items-center">
              <label for="" class="w-1/4">이름*</label>
              <input name="phone_Book_Name" type="text" class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Name }"/>
            </div>

           <div class="flex items-center mt-2">
           <label for="" class="w-1/4">전화번호</label>
           <select class="input input-bordered w-1/6 mr-2 phone" name="phone1" onchange="inputPhone();">
              <option value="010" ${phone1 eq '010' ? 'selected':'' }>010</option>
              <option value="011" ${phone1 eq '011' ? 'selected':'' }>011</option>
              <option value="016" ${phone1 eq '016' ? 'selected':'' }>016</option>
              <option value="017" ${phone1 eq '017' ? 'selected':'' }>017</option>
           </select>
           <input name="phone2" type="text" class="w-1/6 mr-2 input input-bordered phone" onchange="inputPhone();" value="${phone2 }"/>
           <input name="phone3"type="text" class="w-1/6 input input-bordered phone" onchange="inputPhone();" value="${phone3 }"/>
           </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">이메일</label>
              <input name="email1" type="text" class="w-1/6 input input-bordered" onchange="inputEmail();" value="${email1 }"/>&nbsp;@&nbsp;
              <input name="email2" type="text" class="w-1/4 input input-bordered" onchange="inputEmail();" value="${email2 }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">태그</label>
              <select class="input input-bordered w-1/2 mr-2" name="selectTag" id="" onchange="hideNewTag();">
                 <option disabled="disabled" selected="selected">==태그 선택==</option>
                 <option value="newTag">새 태그 입력하기</option>
              <c:forEach var="tag" items="${tags }">
                 <c:if test="${not empty tag || tag eq ' '}">
                    <c:if test="${not fn:contains(tag,',')}">
                       <option value="${tag }">${tag }</option>                          
                    </c:if>
                 </c:if>
              </c:forEach>
              
           </select>
              <button type="button" name="addTagBtn" onclick="addTag_do()" class="btn bg-blue-400 col-sm-2" 
              style=" color:#ffffff; display:none;">태그 추가</button>
            </div>
           
           <div class="flex items-center mt-2 inputTag" style="display: none">
              <label for="" class="w-1/4">새 태그</label>
              <input type="text" name="selectNewTag" class="w-1/2 input input-bordered mr-2"/>
              <button type="button" name="addTag" onclick="addNewTag_do()" class="btn bg-blue-400 col-sm-2 " style=" color:#ffffff;">태그 추가</button>
            </div>
            <div class="flex">
            <div class="w-1/4"></div>
            <div class="tagInput">
               
            </div>
            </div>

           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">회사명</label>
              <input type="text" name="phone_Book_Company"class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Company }"/>
            </div>

           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">부서</label>
              <input type="text" name="phone_Book_Dep" class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Dep }"/>
            </div>

           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">직급</label>
              <input type="text" name="phone_Book_Rank" class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Rank }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">웹사이트</label>
              <input type="text" name="phone_Book_Web" class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Web }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">팩스</label>
              <input type="text" name="phone_Book_Fax" class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Fax }"/>
            </div>
           
           <div class="flex items-center mt-2">
              <label for="" class="w-1/4">주소</label>
              <input type="text" name="phone_Book_Address" class="w-1/2 input input-bordered" value="${phoneBook.phone_Book_Address }"/>
            </div>
           <br />
           <span style="color:gray">*표시 되어있는 항목은 필수입력 사항입니다.</span>
        </div>
     </section>
     
     <div class="text-center mt-4">
        <button type="button" class="btn bg-blue-400 w-1/4" style="color:#ffffff;" onclick="checkName()">수정</button>
     </div>
     <input type="hidden" name="phone_Book_Id" value="${phoneBook.phone_Book_Id }"/>
     <input type="hidden" name="phone_Book_Phone" value="" />
     <input type="hidden" name="phone_Book_Email" value="" />
     <input type="hidden" name="phone_Book_Tag" value="" />
     <input type="hidden" name="phone_Book_Register" value="${phoneBook.phone_Book_Register }" />
     
     </form>
    
    <c:forEach var="addedTag" items="${addedTag }">
       <input type="hidden" name="pastTag" value="${addedTag }" />
    </c:forEach>
     
     
   </div>
<%@include file="/WEB-INF/jsp/include/openfoot.jspf"%>
<script>
   function inputPhone(){
   /* 
   alert($('select[name=phone1]').val());
   alert($('input[name=phone2]').val());
   alert($('input[name=phone3]').val());
    */
   
    const phoneArr=$('select[name=phone1]').val()+'-'+$('input[name=phone2]').val()+'-'+$('input[name=phone3]').val();
   $('input[name=phone_Book_Phone]').val(phoneArr);
   //alert($('input[name=phone_Book_Phone]').val());
      
   }
   
   function inputEmail(){
      const emailArr=$('input[name=email1]').val()+'@'+$('input[name=email2]').val();
      $('input[name=phone_Book_Email]').val(emailArr);
   }
   
   function hideNewTag(){
      if($('select[name=selectTag]').val()=='newTag'){
         $('.inputTag').slideDown();
         $('button[name=addTagBtn]').css("display","none");
         
      }else{
         $('.inputTag').slideUp();
         $('button[name=addTagBtn]').css("display","");
      }
   }
   
   var dataNum=0;
   
   
   window.onload=function(){
      inputPhone();
      inputEmail();
      const added=$('input[name=pastTag]');
      const tagArr=[];
      for(var i=0;i<added.length;i++){
         
         var div=$('<div>').addClass('inputRow').attr('data-no',dataNum);
         var input=$('<input>').attr({"type":"text","name":"addedTag","disabled":"disabled","value":added[i].value}).css("display","inline");
      
         div.append(input).append("<button onclick='remove_go("+dataNum+");'style='border:0;outline:0;' class='badge bg-red-400' type='button'>X</button>");
         $('.tagInput').append(div);
         var tags=$('input[name="addedTag"]');
         for(var tag of tags){
            tagArr.push(tag.value);
         }
         
         $('input[name=phone_Book_Tag]').val(tagArr);
         dataNum++;
      
      }
   }
   
   
   
   
   function addTag_do(){
      //alert($('select[name=selectTag]').val());
      if($('input[name="addedTag"]').length>=3){
         alert("태그 추가는 3개까지 가능합니다.");
         return;
      }
      var div=$('<div>').addClass('inputRow').attr('data-no',dataNum);
      var input=$('<input>').attr({"type":"text","name":"addedTag","disabled":"disabled","value":$('select[name=selectTag]').val()}).css("display","inline");
      
      div.append(input).append("<button onclick='remove_go("+dataNum+");'style='border:0;outline:0;' class='badge bg-red-400' type='button'>X</button>");
      $('.tagInput').append(div);
      
      //alert($('input[name="addedTag"]').length);
      
      const tagArr=[];
      var tags=$('input[name="addedTag"]');
      for(var tag of tags){
         tagArr.push(tag.value);
      }
      
      //alert(tagArr);
      
      
      $('input[name=phone_Book_Tag]').val(tagArr);
      dataNum++;
   }
   function addNewTag_do(){
      //alert($('select[name=selectTag]').val());
      if($('input[name="addedTag"]').length>=3){
         alert("태그 추가는 3개까지 가능합니다.");
         return;
      }
      var div=$('<div>').addClass('inputRow').attr('data-no',dataNum);
      var input=$('<input>').attr({"type":"text","name":"addedTag","disabled":"disabled","value":$('input[name=selectNewTag]').val()}).css("display","inline");
      
      div.append(input).append("<button onclick='remove_go("+dataNum+");'style='border:0;outline:0;' class='badge bg-red-400' type='button'>x</button>");
      $('.tagInput').append(div);
      
      //alert($('input[name="addedTag"]').length);
      var tags=$('input[name="addedTag"]');
      for(var tag of tags){
         tagArr.push(tag.value);
      }
      
      //alert(tagArr);
      
      const tagArr=[];
      $('input[name=phone_Book_Tag]').val(tagArr);
      dataNum++;
   }
   
   function remove_go(dataNum){
         $('div[data-no="'+dataNum+'"]').remove();
         
         const tagArr=[];
         
         var tags=$('input[name="addedTag"]');
         for(var tag of tags){
            tagArr.push(tag.value);
         }
         $('input[name=phone_Book_Tag]').val(tagArr);
      }
   
   
   function checkName(){
       if($('input[name=phone_Book_Name]').val()==null || $('input[name=phone_Book_Name]').val()== ""){
          
          alert("이름을 입력해 주세요");
          $('input[name=phone_Book_Name]').focus();
          return false;
       }else{
          if(confirm("정보를 수정하시겠습니까?")){
          $('form[role=form]').submit();
          }else{
             
          }
       }
   }
   
   function insertType(){
      //alert($('label.active').children('input[name=options]').val())
      $('input[name=phone_Book_Type]').val($('label.active').children('input[name=options]').val());
      
   }
   
</script>