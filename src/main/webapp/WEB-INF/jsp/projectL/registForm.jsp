<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../include/openhead.jspf"%>
	<section class="content-header">
        <div class="container-fluid">
           <div class="flex flex-nowrap items-cen
           ter md-2 p-4">
              <div class="w-1/2">
                 <h1 class="text-3xl font-bold">업무 등록</h1>              
              </div>
              <div class="w-1/2">
                 <ol class="breadcrumb flex float-right">
                 <li class="breadcrumb-item mr-2">
                    <a href="#">
                       <i class="fa fa-dashboard">업무 관리</i>
                    </a>
                 </li>
                 <li class="mr-2">></li>
                 <li class="breadcrumb-item active">
                    업무 등록
                 </li>              
            </ol>
              </div>
           </div>
        </div>
        <hr/>
     </section>
     <form role="form" action="regist">
     <section class="w-5/6 mx-auto content-body"  >
     	<div class="mt-2">
     		<div class="flex items-center">
 	    		<label for="" class="w-1/4">업무 명*</label>
    	 		<input name="pl_name" type="text" class="w-1/2 input input-bordered"/>
   			</div>

     		<div class="flex items-center mt-2">
    	 		<label for="" class="w-1/4">마감기한*</label>
	     		<input name="pl_endDate"type="date" class="w-1/2 input input-bordered phone"/><!-- 데이트 받을곳 -->
     		</div>
     		
     		<div class="flex items-center mt-2">
    	 		<label for="" class="w-1/4">상세업무 입력</label>
	     		<input name="pl_body"type="text" class="w-1/2 input input-bordered mr-2" onkeyup="enterKey();" />
     			<button type="button" class="btn bg-blue-300 w-1/6" onclick="clicking();"
     			style="height:40px;" >업무 추가</button>
     		</div>
     		
     		<div class="flex items-center mt-2">
 	    		<label for="" class="w-1/4">상세업무*</label>
    	 		<div class="w-1/2 input input-bordered mr-2" style="height:200px;overflow-y: scroll;">
    	 			<ul id="detailLi" class="w-full h-full" >
    	 			
    	 			</ul>
    	 		</div>
    	 		
     			
   			</div>
     		
   			
   			
     		<div class="flex items-center mt-2">
 	    		<label for="" class="w-1/4">담당 부서</label>
    	 		<select name="pl_team" class="w-1/2 input input-bordered">
					<c:forEach var="team" items="${teamlist }">
						<option  value="${team.team_name}">${team.team_name }</option>
					</c:forEach>
    	 		</select>
   			</div>
     		
     		<br />
     		<span style="color:gray">*표시 되어있는 항목은 필수입력 사항입니다.</span>
     	</div>
     </section>
     
     <div class="text-center mt-4">
     	<button type="button" class="btn bg-blue-300 w-1/4 mb-4" onclick="registPl();">등록</button>
     </div>
     
     </form>
<%@include file="../include/openfoot.jspf"%>

<script>
function remove_go(dataNum){
	var classText='.detail'+dataNum;
	   $(classText).remove();
}


var i=1;
function enterKey() {
    if (window.event.keyCode == 13) {
		//alert($('input[name=pl_body]').val());
		var pmLi='<li class="detail'+i+' row mt-2" >'+'</li>';
		var pmLiSpan='<span class="w-5/6 inline-block" style="overflow-x:hidden;">'+$('input[name=pl_body]').val()+'</span>'
		var pmLiBtn="<button onclick='remove_go("+i+");'style='border:0;outline:0;' class='badge bg-red-300 text-right' type='button'>x</button>"
		//alert(pmLi);
		$('#detailLi').append(pmLi);
		var detailName='.detail'+i;
		$(detailName).append(pmLiSpan);
		$(detailName).append(pmLiBtn);
		i++;
		$('input[name=pl_body]').val('');
    }
}

function clicking(){
	var pmLi='<li class="detail'+i+' row mt-2" >'+'</li>';
	var pmLiSpan='<span class="w-5/6 inline-block" style="overflow-x:hidden;">'+$('input[name=pl_body]').val()+'</span>'
	var pmLiBtn="<button onclick='remove_go("+i+");'style='border:0;outline:0;' class='badge bg-red-300 text-right' type='button'>x</button>"
	//alert(pmLi);
	$('#detailLi').append(pmLi);
	var detailName='.detail'+i;
	$(detailName).append(pmLiSpan);
	$(detailName).append(pmLiBtn);
	i++;
	$('input[name=pl_body]').val('');
}

function replaceResult(str){
	//alert(str);
	
	$.ajax({
		url: 'plList',
		dataType: 'text',
		data: {
			teamName:str
		},
		traditional: true,
		success: function(data){
			
			$('.resultSection').html(data);
			
		}
	});
}

function registPl(){
	var formvalue=$('form[role=form]').serialize();
	var teamname=$('select[name=pl_team]').val();
	var arr=[];
	$('#detailLi li span').each(function(index, item){
		//console.log(item.value);
		arr.push(item.innerText);
	});
	
	
	
	$.ajax({
		url: "regist",
		
		data: {
			pl_name:$('input[name=pl_name]').val(),
			pl_endDate:$('input[name=pl_endDate]').val(),
			pl_manager:'',
			pl_team: $('select[name=pl_team]').val(),
			pl_bodyArr: arr 
		},
		traditional: true,
		dataType: 'text',
		
		success: function(data){
			window.opener.replaceResult($('select[name=pl_team]').val());
			window.close();
		}
	});
}
</script>