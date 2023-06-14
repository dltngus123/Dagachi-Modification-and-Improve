<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/head.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link
	href="/resource/bootstrap/plugins/summernote/summernote-bs4.min.css"
	rel="stylesheet">

<style>
#approver {
	position: fixed;
	margin: 0 auto;
	left: 0;
	right: 0;
	width: 100%;
	height: 100%;
	overflow: scroll;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
	left: 0;
	right: 0;
}

.modal-content {
	background-color: #fefefe;
	width: 400px;
	height: 400px;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #888;
}

.close {
	color: black;
	margin-top: 50px;
	float: right;
	font-size: 28px;
	font-weight: bold;
	font-size: 28px;
	float: right;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>

<div class="p-4 sm:ml-64">
	<div class="card" style="width: 90%; margin: auto;">
		<div class="card-header">
			<h5 style="padding: none;">새 결재 작성</h5>
		</div>
		<form class="form"method="post" action="regist">
			<div class="card-body">
				<span style="margin-left: 10px;">양식<span style="color: red;">*</span></span>
				<hr>
				<div class="step1"
					style="display: flex; justify-content: space-evenly;">
					<div>
						<span>양식: </span><select name="form" onchange="formChange(this)"
							style="width: 130px; height: 30px; font-size: 13px; margin-left: 10px;">
							<option value="">양식을 선택하세요.</option>
							<c:forEach var="form" items="${form}">
								<option value="${form.form_id}">${form.form_name}</option>
							</c:forEach>
						</select>

						<c:forEach var="form" items="${form}">
							<div style="display: none;" id="${form.form_id}">${form.form_content}</div>
						</c:forEach>

					</div>
					<div>
						<span>중요도: </span><select name="level"
							style="width: 130px; height: 30px; font-size: 13px; margin-left: 10px;">
							<option value="">중요도</option>
							<option value="1">긴급</option>
							<option value="0">보통</option>

						</select>
					</div>
					<div>
						<span>보관기한: </span><select
							style="width: 130px; height: 30px; font-size: 13px; margin-left: 10px;">
							<option value="">보관기한</option>
							<option value="">5년</option>
							<option value="">10년</option>

						</select>
					</div>
					<div>
						<span>작성자: </span><input name="member_id"
							style="margin-left: 10px; width: 130px; height: 30px; border: none; background: #D7D7D7;"
							type="text" value="${loginUser.member_name }" readonly> <input type="hidden"
							id="member_id" value="${loginUser.member_id}">
					</div>
				</div>
				<hr>
				<span style="margin-left: 10px;">결재선<span style="color: red;">*</span></span>

				<hr>
				<div class="step2" style="display: flex; justify-content: center;">
					<div id="infobox" name="1" class="1" style="width: 175px;">


						<div class="card" style="margin-right: 10px;">
							<div class="card-header" style="background-color: #D7D7D7;">
								<h3 class="card-title" style="margin-top: 2px;">결재선 1</h3>
								<div class="card-tools">
									<button id="open-modal" type="button"
										style="background: none; border: none;">
										<span>➕</span>
									</button>

								</div>

							</div>

							<div class="card-body" style="height: 70px;">
								<span style="font-size: 14px;" id="info1"></span>
							</div>

						</div>

					</div>
					<div id="infobox2" name="2"  class="2" style="width: 175px;">
						<div class="card" style="margin-right: 10px;">
							<div class="card-header" style="background-color: #D7D7D7;">
								<h3 class="card-title" style="margin-top: 2px;">결재선 2</h3>
								<div class="card-tools">
									<button id="open-modal2" type="button"
										style="background: none; border: none;">
										<span>➕</span>
									</button>
								</div>

							</div>

							<div class="card-body" style="height: 70px;">
								<span style="font-size: 14px;" id="info2"></span>
							</div>

						</div>

					</div>
					<div id="infobox3" name="3"  class="3" style="width: 175px;">
						<div class="card">
							<div class="card-header" style="background-color: #D7D7D7;">
								<h3 class="card-title" style="margin-top: 2px;">결재선 3</h3>
								<div class="card-tools">
									<button id="open-modal3" type="button"
										style="background: none; border: none;">
										<span>➕</span>
									</button>
								</div>

							</div>

							<div class="card-body" style="height: 70px;">
								<span style="font-size: 14px;" id="info3"></span>
							</div>

						</div>

					</div>

				</div>
				<hr>
				<div class="title">
					<span style="margin-left: 10px;">제목 :</span><input type="text"
						name="title" style="width: 80%; margin-left: 10px;">
				</div>
				<hr>
				<div class="contentbox">
					<textarea class="content" name="content" id="content">
			
			</textarea>

					<span style="float: right;">
					<input type="hidden" name="save" value="1"/>
						<button onclick="submit_go(1)"type="button" name="save" value="1"
							class="btn btn-sidebar"
							style="background-color: #5865F2; width: 100px;">제출</button>

						<button onclick="submit_go(2)" type="button" name="save" value="2"
							class="btn btn-sidebar"
							style="background-color: #D7D7D7; width: 100px;">임시저장</button>
					</span>
				</div>
			</div>
		</form>



		<div id="approver">
			<div class="modal-content">
				<h4 style="display: block; border-bottom: 2px solid black;">결재선
					설정</h4>
				<div>
					<div
						style="border-bottom: 0.05rem solid black; height: 50px; margin-top: 30px;">
						<span>부서 :</span> <select id="boosu" style="width: 200px;"
							onchange="optionChange(this)">
							<option>부서를 선택하세요.</option>
							<option value="a">영업 부서</option>
							<option value="b">관리 부서</option>
							<option value="c">인사 부서</option>
						</select>
					</div>
					<div
						style="border-bottom: 0.05rem solid black; height: 50px; margin-top: 30px;">
						<span>팀명 :</span> <select id="team" style="width: 200px;"
							onchange="nameChange(this)">
							<option>팀명을 선택하세요.</option>
						</select>
					</div>
					<div
						style="border-bottom: 0.05rem solid black; height: 50px; margin-top: 30px;">
						<span>이름 :</span> <select id="name" style="width: 200px;">
							<option>이름을 선택하세요.</option>



						</select>
					</div>
				</div>
				<div>
					<button class="close" id="close-modal">닫기</button>
					<button style="margin-right: 20px;" class="close" id="submit-btn">완료</button>
				</div>


			</div>
		</div>

	</div>





</div>

<script>
window.onload=function(){
	summernote_go($('.content'),'<%=request.getContextPath()%>'
			);
	}



  function submit_go(value) {
    var levelSelect = document.getElementsByName('level')[0];
    var form = document.getElementsByName('form')[0];
    var infobox1 =document.getElementById('infobox');
    var infobox2 =document.getElementById('infobox2');
    var infobox3 =document.getElementById('infobox3');
    if (levelSelect.value === '' || form.value==='' ||infobox1.name !== '0' ||infobox2.name !== '0' ||infobox3.name !== '0') {
      alert('모든 필수 정보를 입력하세요.');
      return;
    }
    $('.form').submit();    
  }


  function optionChange(e) {
	  var teamoption1 = ["영업1팀", "영업2팀", "영업3팀"];
	  var teamoption2 = ["관리1팀", "관리2팀", "관리3팀"];
	  var teamoption3 = ["인사1팀", "인사2팀", "인사3팀"];
	  var target = document.getElementById("team");

	  var d;

	  if (e.value === "a") {
	    d = teamoption1;
	  } else if (e.value === "b") {
	    d = teamoption2;
	  } else if (e.value === "c") {
	    d = teamoption3;
	  }

	  target.options.length = 0;
        
	  
	   var opt1=document.createElement("option");
	    opt1.innerHTML ="팀명을 선택하세요.";
	    target.appendChild(opt1);
	  for (var x in d) {
	    var opt = document.createElement("option");
	    opt.value = d[x];
	    opt.innerHTML = d[x];
	    target.appendChild(opt);
	  }
	}
var array =[];	
	
function nameChange(e) {
	  var teamname1 = e.value;
	  var target = document.getElementById("name");
	  var opt = document.createElement("option");
	  

	  $.ajax({
	    type: "get",
	    url: "sendNameList",
	    dataType: "json",
	    data: {
	      teamname1: teamname1
	    },
	    success: function(data) {
	    	target.options.length = 0;
	    	
	    	for (var x in data) {
	    	    var opt = document.createElement("option");
	    	    var member = data[x];
	    	    var name = member.member_name;
	    	    var rank = member.member_rank;
	    	    opt.value = member.member_id;
	    	    opt.innerHTML = name+" "+rank;
	    	    target.appendChild(opt);
	    	  } 
	    	console.log(data)
	    	 
	    },
	    error: function(fail) {
	      console.log(fail);
	    },
	  });
}
	
const modal = document.getElementById("approver");
const openModalBtn = document.getElementById("open-modal");
const openModalBtn2 = document.getElementById("open-modal2");
const openModalBtn3 = document.getElementById("open-modal3");
const closeModalBtn = document.getElementById("close-modal");
const submitModalBtn = document.getElementById("submit-btn");
// 모달창 열기
openModalBtn.addEventListener("click", () => {
  modal.style.display = "block";
  modal.value ="1";
  document.body.style.overflow = "hidden"; // 스크롤바 제거
});
openModalBtn2.addEventListener("click", () => {
  modal.style.display = "block";
  modal.value ="2";
  document.body.style.overflow = "hidden"; // 스크롤바 제거
});
openModalBtn3.addEventListener("click", () => {
  modal.style.display = "block";
  modal.value ="3";
  document.body.style.overflow = "hidden"; // 스크롤바 제거
});
// 모달창 닫기
closeModalBtn.addEventListener("click", () => {
  console.log(modal.id)
  modal.style.display = "none";
  modal.value="";
  document.body.style.overflow = "auto"; // 스크롤바 보이기
});
submitModalBtn.addEventListener("click", () => {
	  modal.style.display = "none";
	  document.body.style.overflow = "auto";
	  if (modal.value == '1') {
	    var info = document.getElementById("info1");
	    var infobox = document.getElementById("infobox");
	  } else if (modal.value == '2') {
	    var info = document.getElementById("info2");
	    var infobox = document.getElementById("infobox2");
	  } else if (modal.value == '3') {
	    var info = document.getElementById("info3");
	    var infobox = document.getElementById("infobox3");
	  }
	  const approver2 = document.getElementById("team");
	  const approver3 = document.getElementById("name");
	  const app1 = approver2.options[approver2.selectedIndex];
	  const app2 = approver3.options[approver3.selectedIndex];

	  info.innerText = app1.text + " " + app2.text;

	  // 기존의 ipt 요소 삭제
	  var existingIpt = infobox.querySelector("input[name^='approver']");
	  if (existingIpt) {
	    infobox.removeChild(existingIpt);
	  }

	  // 새로운 ipt 요소 추가
	  var ipt = document.createElement("input");
	  ipt.type = "hidden";
	  if (info.id == "info1") {
	    ipt.name = "approver1";
	    infobox.name = "0";
	  } else if (info.id == "info2") {
	    ipt.name = "approver2";
	    infobox.name = "0";
	  } else if (info.id == "info3") {
	    ipt.name = "approver3";
	    infobox.name = "0";
	  }
	  ipt.value = app2.value;
	  infobox.appendChild(ipt);
	});

function formChange(e) {
	  var opt = e.options[e.selectedIndex];
	  var divId = opt.value;
	  var inp = document.getElementById(divId);

	  var target = document.getElementById("content");
	  $(target).summernote("code", inp.innerHTML);
	}



</script>





<%@include file="../include/foot.jspf"%>