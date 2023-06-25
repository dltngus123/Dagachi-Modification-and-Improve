<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/head.jspf"%>
<div class="p-4 sm:ml-64" style="">
<section class="content-header">
<div class="container-fluid">
<div class="flex flex-nowrap">
<div class="w-1/2 mb-4">
<h1 class="text-3xl font-bold">
   <a href='javascript:registBookMark("/dagachi/projectM/list", "팀 단위 업무관리")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      단위 업무 관리
      </span>
   </h1>
</div>
<div class="w-1/2  d-none d-sm-block">
<ol class="breadcrumb flex float-right">
<li class="breadcrumb-item mr-2"><a href="#">업무 관리</a></li>
<li class="mr-2">></li>
<li class="breadcrumb-item active">업무 현황</li>
</ol>
</div>
</div>
</div>
</section>

<section class="pb-3 flex justify-center">
<div class="container-fluid flex w-full flex-nowrap justify-center " style="height:70vh;">

<div class="w-1/4 card-primary border mr-2 rounded-3xl">
<div class="bg-gray-300 rounded-t-3xl p-2">
<h3 class="card-title">
	팀원 목록
</h3>
</div>
	<c:forEach var="member" items="${memberList }"> 
		<button style="" type="button" class="text-white btn bg-blue-300 w-full memberNameVal${member.member_id}" onclick="memberDetail('${member.member_id}')">${member.member_name}</button>
		<input type="hidden" name="member_id" value=""/>
	</c:forEach>
</div>

<div class="w-1/3 mr-2 border rounded-3xl card-success" ><!-- 여기에 어펜드 걸어서 할 것  -->
<div class="bg-gray-300 rounded-t-3xl p-2 mb-1">
<h3 class="card-title" >
 	${teamName} 전체 업무
</h3>
</div>
	<div class="resultSectionPl" style="max-height:90%; overflow-y:scroll;">
	
	
	</div>

</div>
<div class="card card-row w-1/3 border rounded-3xl card-success"><!-- 여기에 어펜드 걸어서 할 것  -->
<div class="bg-gray-300 rounded-t-3xl p-2">
<h3 class="card-title memberNameTitle">
 	팀원별 업무 현황
</h3>
</div>
	<button type="button" class="btn btn-block btn-default btn-flat col-sm-12" onclick="regist_go()">저장하기</button>
	<div class="resultSectionPm" style="max-height:87%; overflow-y:scroll;">
	<div class="bg-gray-300 flex p-4 alert-dismissible mustRemove">
		<h5><i class="icon fas fa-check"></i > 팀원을 선택해 주세요</h5>

	</div>
	</div>

</div>
</div>
</section>
</div>
<input type="hidden" name="inputIdValue" value="" />

<!-- 모달창 -->
				


<%@include file="../include/foot.jspf"%>

<script>
window.onload=function(){
	$.ajax({
		url: 'resultPL',
		data:{
			
		},
		dataType:'text',
		traditional: true,
		success: function(data){
			$('.resultSectionPl').html(data);
		}
	
	});
	
	bookMarkList();
    checkedBookMark('/dagachi/projectM/list');
}

function memberDetail(str){
	if(changedPM.length==0){
		
	$('input[name=member_id]').val(str);
	
	//alert(memberNameText);
	
	$.ajax({
		url: 'resultPM',
		data:{
			member_id: str
		},
		dataType:'text',
		traditional: true,
		success: function(data){
			$('.resultSectionPm').html(data);
			var memberNameText=$('.memberNameVal'+str).text().trim();
			$('.memberNameTitle').html(memberNameText+' 업무 현황');
		}
	
	});
	}else{
		if(confirm("저장되지 않은 변경상태가 있습니다. 저장하시겠습니까?")){
			regist_go();
		}else{
			//changedPM=[];
		}
	}
	
	
	
	//넣어놓고 저장안하고 다른멤버 보려하면 저장하겠냐는 문구와 함께 저장할 것
}



var changedPM=[];
var changedPL=[];

function moveToLeft(pl_Id,pm_Id){
	var pmNameClass='pl'+pl_Id+'pm'+pm_Id;
	$('#'+pmNameClass).remove();
	for(let i = 0; i < changedPM.length; i++) {
		  if(changedPM[i]== pm_Id)  {
			  changedPM.splice(i, 1);
		    i--;
		  }
		}
	
}


function moveToRight(pl_Id,pm_Id){
	//alert($('input[name=member_id]').val())
	if($('input[name=member_id]').val()){
		var cardClaText='.pmCard'+pl_Id;
		//alert(cardClaText);
		var check=$(cardClaText).length;
		var pmNameClass='pl'+pl_Id+'pm'+pm_Id;
		var pmNameText=$('.'+pmNameClass+'name').text().trim();
		var moveText='<li class="flex" id="'+pmNameClass+'" style="list-style:none;" onclick="moveToLeft('+pl_Id+','+pm_Id+')">'+
						'<div class="w-5/6">'+pmNameText+'</div>'+
						
						'<div class="w-1/6 text-center">'+'<span class="badge bg-red-300">x</span>'+'</div>'
					'</li>';
		
		
		
		if(check==1){
			//alert("dd");
			//return false;
			if($('#'+pmNameClass).length==0){
				$('.pmli'+pl_Id).append(moveText);
				$('.pmli'+pl_Id).parent().css("display","block");
				changedPM.push(pm_Id);
				changedPL.push(pl_Id);
				//console.log(changedPM);
				
				return false;
			}else{
				alert("이미 등록됨");
				//console.log(changedPM);
				return false;
			}
		}else{
			$('.mustRemove').remove();
			var createCard= $('.plCard'+pl_Id).clone();
			createCard.removeClass('plCard'+pl_Id);
			createCard.addClass('pmCard');
			createCard.addClass('pmCard'+pl_Id);
			createCard.find('.cloneCard').empty();
			createCard.find('.cloneCard').addClass('pmli'+pl_Id);
			createCard.appendTo('.resultSectionPm');
		}
		
		if($('#'+pmNameClass).length==0){
			$('.pmli'+pl_Id).append(moveText);
			$('.pmli'+pl_Id).css("display","block");
			changedPM.push(pm_Id);
			changedPL.push(pl_Id);
		}else{
			alert("이미 등록됨");
			return false;
		}
	}else{
		alert("등록할 팀원을 선택해주세요");
	}
}

function moveToRightRegisted(pl_Id,pm_Id){
	if(confirm('이미 배정된 업무입니다. 담당자를 바꾸시겠습니까?')){
		moveToRight(pl_Id,pm_Id);
	}
}

function regist_go(){
	//alert(changedPM);
	var memId=$('input[name=member_id]').val()
	//alert(memId);
	$.ajax({
		url: 'modify',
		data:{
			member_id: memId,
			pm_ids: changedPM
		},
		dataType: 'text',
		traditional: true,
		success: function(data){
			$('.resultSectionPm').html(data);
			for(var i=0;i<changedPL.length;i++){
				$('.divpm'+changedPL[i]).css("display","");
			}
		}
		
	});
	
	$.ajax({
		url: 'resultPL',
		data:{
			
		},
		dataType:'text',
		traditional: true,
		success: function(data){
			$('.resultSectionPl').html(data);
			
		}
	
	});
	
			changedPM=[];
			changedPL=[];
	
	
}




</script>
<script>
function aaa(id){
	$('div[data-id='+id+']').slideToggle();
}
function bbb(id){
	$('.'+id).slideToggle();
}
</script>