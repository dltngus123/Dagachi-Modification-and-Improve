<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/head.jspf"%>
<div class="p-4 sm:ml-64">
   <div class="content-header">
   <h1>
   <i class="fas fa-star text-yellow"></i>
   	회의록 등록
   </h1>
   </div>
	<div class="col-12">
	  <div class="card">

	  <section class="col-8 mx-auto content-body">
     	
     	
     	<form action="registSuccess" role="form">
     	
     	<div class="mt-4 justify-content-center">

     		

     		<div class="row mt-2">
     			<label for="" class="mr-2 col-sm-2">회의록 제목</label>
     			<input class="form-control col-sm-6" type="text" name="title"/>
     		
     		</div>
     		
     		
     		
     		<div class="row mt-2">
     			<label for="" class="col-sm-2">공개 범위 및 분류</label>
     			<div class="col-sm-2">
     				<select class="form-control" onchange="changeType(this.value);" name="type">
     					<option value="" disabled="disabled" selected="selected">분류</option>
     					<option value="0">긴급</option>
     					<option value="1">주간</option>
     					<option value="2">월간</option>
     					<option value="3">임원</option>
     					<option value="4">협력</option>
     				</select>
     		
     			</div>
     			<div class="col-sm-5 row removableScope">
	     			<div class="col-sm-6">
	     				<input type="radio" name="scope" class="col-sm-6 scopeAll" value="1"/>전체 공개
	     			</div>
	     			<div class="col-sm-6">
	     				<input type="radio" name="scope" class="col-sm-6 scopePart" value="2"/>관련자 공개
	     			</div>
     			</div>
     		
     		</div>
     		
     		<div class="row mt-2" style="position: relative;">
     			<label for="" class="mr-2 col-sm-2">참석자</label>
     			<input class="form-control col-sm-6" type="text" name="memberInsert"/>
     		</div>
     		<div id="recommend"class="row col-sm-12" style="display:none; position:absolute; z-index:10;">
	     		<div class="col-sm-2 mr-2"></div>
	     		<div class=" border bg-white col-sm-6 memberResultSection" style="z-index: 0; max-height:200px; overflow-y:scroll; border-radius:10px;">
	     		
	     		</div>
     		</div>
     		
     		<div class="row mt-2">
 	    		<label for="" class="col-sm-2 mr-3">참석자 목록</label>
 	    		<input type="hidden" name="attenders" value="" />
    	 		<div class="col-sm-6 row border" id="attendenceList" style="max-height:200px; overflow-y: scroll;">
    	 			
    	 		</div>
   			</div>
     		
     		<div class="row mt-2" style="position: relative;">
     			<label for="" class="mr-2 col-sm-2">회의 주제</label>
     			<input class="form-control col-sm-6" type="text" name="topic"/>
     		</div>
     		
     		<label for="" class="mt-4">회의내용</label>	
     		<div class="contentbox row col-md-12 mt-2">
				<textarea class="content col-sm-12" name="body" style="width:100%;">
				</textarea>
   			</div>
			
     		<label for="" class="mt-4">회의결론</label>	
     		<div class="contentbox row mt-2">
				<textarea class="content mx-auto" name="result">

				</textarea>
   			</div>
     		
     		
     		

     	</div>
     	<div class="text-center my-4">
     	<button type="button" class="btn bg-gradient col-sm-2" onclick="history.back();" 
     	style="background: #5865F2; color:#ffffff;">뒤로가기</button>
     	<button type="submit" class="btn bg-gradient col-sm-2"  
     	style="background: #5865F2; color:#ffffff;">등록하기</button>
     	
     </div>
     	</form>	
     	
     </section>
       
	</div>
	
   </div>
</div>

<!-- onclick="registProceeding();" -->
<%@include file="../include/foot.jspf"%>
<script>
function registProceeding(){
	var bodyval=$('textarea[name="body"]');
	$('input[name="body"]').val(bodyval);
	 var form=$('form[role="form"]')
	form.submit()
} 




const inputBox = $("input[name='memberInsert']");
const recommendBox = $("#recommend");

inputBox.bind("keyup", function(e){
	if (e.target.value.length > 0) {
		recommendBox.css("display","");
		$.ajax({
			url:"recommend",
			data:{
				member_name: inputBox.val()
			},
			dataType: 'text',
			traditional:true,
			success:function(data){
				$('.memberResultSection').html(data);
				MemberPictureThumb('<%=request.getContextPath()%>');
			}
			
		});
		
	} else {
		recommendBox.css("display","none");
	}
});
var inList 
$('#recommend').on('mouseenter', function () {
	inList = true;
})
$('#recommend').on('mouseleave', function () {
	inList = false;
})
inputBox.on('focusout', function () {
	if(!inList) {
		$("#recommend").css("display","none");
	}
})
/* inputBox.focusout(function(){
	
	$("#recommend").css("display","none");
})  */




window.onload=function(){
		summernote_go($('.content'),'<%=request.getContextPath()%>');
		MemberPictureThumb('<%=request.getContextPath()%>');
		}

var memArr=[]

function inserting(fm,memId){
	$('#attendenceList').append(fm);
	memArr.push(memId);
	
	inputBox.val("");
	$('input[name="attenders"]').val(memArr);
	$("#recommend").css("display","none");
	
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
	      height:200,
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
	     
	   });
	   
	}
	
function changeType(dex){
	if(dex==0){
		$('.scopeAll').prop("checked",true);
	}else{
		$('.removableScope').css("display","");
	}
}
</script>
