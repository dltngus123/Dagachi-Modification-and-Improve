<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/head.jspf"%>
<div class="p-4 sm:ml-64">
   
   <h1>
   <i class="fas fa-star text-yellow"></i>
      회의록
   </h1>
   <div class="col-12">
     <div class="card">
       <div class="card-header row">
         <!-- <h3 class="card-title"></h3> -->
         <h3 class="row ml-4 text-bold">
              ${proceeding.form_proceeding_title }
           </h3>
   

     </div>
     <section class="col-11 mx-auto content-body">
        
        
        
        <div class="mt-4">

           

           <div class="row mt-2">
           <label for="" class="col-sm-2">등록 일자</label>
           <fmt:formatDate value="${proceeding.form_proceeding_regDate }" pattern="yyyy.MM.dd" var="regDate"/>
               <input class="form-control col-sm-6"type="text" value="${regDate }" disabled="disabled"/>
           
           </div>
           <div class="row mt-2">
              <label for="" class="col-sm-2 mr-2">등록자*</label>
              <div class="col-sm-6 row">
                 <div class="col-sm-1 manPicture" data-id="${proceeding.form_proceeding_register }"></div>
                 <div class="col-sm-9">
                 ${member.member_name}
                 </div>
              </div>
            </div>
            <div class="row mt-2">
               <label for="" class="col-sm-2">희의 주제*</label>
               <input class="col-sm-6 form-control" type="text" value="${proceeding.form_proceeding_topic }" disabled="disabled"/>
            </div>
           
           
           <label for="" class="mt-4">회의내용</label>   
           <div class="contentbox row col-sm-12">
            <textarea class="content summernote mx-auto" name="content" id="content" disabled="disabled">
               ${proceeding.form_proceeding_body }
            </textarea>
            </div>

           <label for="" class="mt-4">회의결론</label>   
           <div class="contentbox row col-sm-12 ">
            <textarea class="content summernote mx-auto" name="content" id="content" disabled="disabled">
               ${proceeding.form_proceeding_result }
            </textarea>
            </div>
           
           
           

           
        </div>
     </section>
       <div class="text-center my-4">
        <button type="button" class="btn bg-gradient col-sm-2" onclick="" 
        style="background: #5865F2; color:#ffffff;">내려받기</button>
        <button type="button" class="btn bg-gradient col-sm-2" onclick="history.back();" 
        style="background: #5865F2; color:#ffffff;">뒤로가기</button>
        
     </div>
   </div>
   
   </div>

</div>

<%@include file="../include/foot.jspf"%>
<script>

window.onload=function(){
      var att='${proceeding.form_proceeding_attender}';
      //alert(att);
      var attArr=att.split(',');
      //alert(attArr[0]);
      var proceeding_scope='${proceeding.form_proceeding_scope}'
      
      if(proceeding_scope==2){
         
      $.ajax({
         url:'authCheck',
         data: {
            att: att,
            register: '${proceeding.form_proceeding_register}'
         },
         dataType:'text',
         traditional: true,
         success: function(data){
            if(data=='ok'){
               
            }else{   
               alert("권한이 없습니다.");
               history.back();
            }
         }
         
      });
      }
      
      
      
      
      summernote_go($('.content'),'<%=request.getContextPath()%>');
      MemberPictureThumb('<%=request.getContextPath()%>');
      }


function MemberPictureThumb(contextPath){
    for(var target of document.querySelectorAll('.manPicture')){   
       var id = target.getAttribute('data-id');
       
      target.style.backgroundImage="url('"+contextPath+"/dagachi/proceeding/getPicture?id="+id+"')";            
      target.style.backgroundPosition="center";
      target.style.backgroundRepeat="no-repeat";
      target.style.backgroundSize="contain";
    }
}
</script>
<script>
function summernote_go(target,context){
      contextPath=context;
      
      target.summernote({
         placeholder:'여기에 내용을 적으세요.',
         lang:'ko-KR',
         height:300,
         width:1000,
         
         dsableResizeEditor: true,
         callbacks:{
            onImageUpload: function(files, editor, welEditalbe){
               for(var file of files){
                  if(file.name.substring(file.name.lastIndexOf(".")+1).toUpperCase() != "JPG"){
                     alert("JPG 이미지 형식만 가능합니다.");
                     return;
                  }
                  if(file.size > 1024*1024*1){
                     alert("이미지는 1MB 미만입니다.");
                     return;
                  }
               }
               
               for (var file of files) {
                  sendFile(file,this);
               }
            },
            onMediaDelete : function(target) {

               deleteFile(target[0].src);
            }
         },
        toolbar:[]
      });
      $('.summernote').summernote('disable');
   }
</script>