<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/head.jspf"%>
<div class="p-4 sm:ml-64" style="">
<section class="">
<div class="container-fluid">
<div class="flex">
<div class="w-1/2">
<h1 class="text-3xl">
   <a href='javascript:registBookMark("/dagachi/projectL/list", "부서 단위 업무관리")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      부서단위 업무 관리
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

<section class="py-3 flex">
<div class="container-fluid w-full flex justify-center">

<div class="w-1/3 mr-4 rounded-3xl 
 card-primary">
<div class="card-header bg-gray-300 rounded-t-3xl p-2">
<h3 class="card-title" >
   팀 목록
</h3>
</div>
   <c:forEach var="team" items="${teamlist }"> 
      <button  style=""type="button" class="btn bg-blue-300 text-white w-full" onclick="replaceResult('${team.team_name}')">${team.team_name }</button>
   </c:forEach>
</div>

<div class="card card-row w-1/2 card-success" ><!-- 여기에 어펜드 걸어서 할 것  -->
<div class="card-header bg-gray-300 rounded-t-3xl p-2">
<h3 class="card-title">
    팀 업무 현황
</h3>
</div>
   <button type="button" class="btn btn-block btn-default btn-flat col-sm-12" onclick="OpenWindow('registForm','주소록 등록',800,700);">업무 등록하기</button>
   <div class="resultSection" style="max-height:600px; overflow-y:scroll">
   <div class="alert alert-success alert-dismissible mustRemove" style="background-color:#333c9e;">
      <button type="button" class="close" data-dismiss="alert" aria-hidden="true" style="color:red;">×</button>
      <h5 class="text-white"><i class="icon fas fa-check"></i> 팀을 선택해 주세요</h5>
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
function inputValue(dex){
   $('input[name=inputIdValue]').val(dex)
}

window.onload=function(){
   if(${memberAuth}===1){
      alert("권한이 없습니다.");
      history.back();
   }
   
   bookMarkList();
    checkedBookMark('/dagachi/projectL/list');
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

function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
   winleft = (screen.width - WinWidth) / 2;
   wintop = (window.screen.height - WinHeight) / 2;
   var win = window.open(UrlStr , WinTitle , "scrollbars=yes,width="+ WinWidth+",height="+ WinHeight +",top="+wintop+",left="+ winleft +",resizable=yes" );
   win.focus();
}



</script>
<script>
function aaa(id){
   $('div[data-id='+id+']').slideToggle();
}
</script>