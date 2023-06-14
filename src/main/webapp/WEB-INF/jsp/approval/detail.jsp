<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/openhead.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.card {
	width: 800px;
	margin: auto;
}

.infobox {
	width: 800px;
	height: 100px;
	display: flex;
}

.1 {
	width: 800px;
	height: 50px;
}

.info1 {
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	font-weight: bold;
	width: 100px;
	height: 50px;
	border: 1px solid black;
}

.info {
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	width: 300px;
	height: 50px;
	border: 1px solid black;
}

.content {
	margin: 0 auto;
}
</style>
<div class="p-4 sm:ml-64">

	<div class="card">
		<span style="font-weight: bold; font-size: 20px; padding: 10px;">
			${ap.approval_title }</span>

		<div class="infobox">
			<div class="1">
				<div class="info1" style="border-bottom: none;">작성자</div>
				<div class="info1">소속</div>
			</div>
			<div class="1">
				<div class="info" style="border-bottom: none;">${member.member_name }</div>
				<div class="info">${member.member_team1 }</div>
			</div>
			<div class="1">
				<div class="info1" style="border-bottom: none;">기안일자</div>
				<div class="info1">중요도</div>
			</div>
			<div class="1">
				<div class="info" style="border-bottom: none;">
					<fmt:formatDate value="${ap.approval_registdate }"
						pattern="yyyy.MM.dd HH.mm" />
				</div>
				<div class="info">
					<c:if test="${ap.approval_level eq '0' }">
						<span class="badge bg-warning">보통</span>
					</c:if>
					<c:if test="${ap.approval_level eq '1' }">
						<span class="badge bg-danger">긴급</span>
					</c:if>
				</div>
			</div>
		</div>
		<div class="content">${ap.approval_content }</div>
		<div class="approvalBox"
			style="display: flex; justify-content: flex-end; margin-top: 20px; padding-right: 30px;">
			<div id="approver1"
				style="text-align: center; width: 150px; height: 100px; border: 1px solid black;">
				<div
					style="width: 150px; height: 30px; border-bottom: 1px solid black;">${member1.member_name}
					${member1.member_rank}</div>
				<c:set var="memberFound" value="false" />
				<c:forEach var="approver" items="${approvers}">
					<c:if test="${approver.a_approver eq member1.member_id}">
						<c:set var="memberFound" value="true" />
						<c:if test="${approver.a_status eq '0'}">
							<span id="status1" class="badge bg-primary">승인</span>
						</c:if>
						<c:if test="${approver.a_status eq '1'}">
							<span  id="status1"class="badge bg-danger">반려</span>
						</c:if>
					</c:if>
				</c:forEach>

				<c:if test="${not memberFound}">
					 <span id="status1" class="badge bg-warning">대기</span>
				</c:if>
			</div>
			<div id="approver2"
				style="text-align: center; width: 150px; height: 100px; border: 1px solid black; border-left: none;">
				<div
					style="width: 150px; height: 30px; border-bottom: 1px solid black;">${member2.member_name}
					${member2.member_rank}</div>
				<c:set var="memberFound" value="false" />
				<c:forEach var="approver" items="${approvers}">
					<c:if test="${approver.a_approver eq member2.member_id}">
						<c:set var="memberFound" value="true" />
						<c:if test="${approver.a_status eq '0'}">
							<span id="status2"  class="badge bg-primary">승인</span>
						</c:if>
						<c:if test="${approver.a_status eq '1'}">
							<span id="status2" class="badge bg-danger">반려</span>
						</c:if>
					</c:if>
				</c:forEach>

				<c:if test="${not memberFound}">
					 <span id="status2" class="badge bg-warning">대기</span>
				</c:if>
			</div>
			<div id="approver3"
				style="text-align: center; width: 150px; height: 100px; border: 1px solid black; border-left: none;">
				<div
					style="width: 150px; height: 30px; border-bottom: 1px solid black;">${member3.member_name}
					${member3.member_rank}</div>
				<c:set var="memberFound" value="false" />
				<c:forEach var="approver" items="${approvers}">
					<c:if test="${approver.a_approver eq member3.member_id}">
						<c:set var="memberFound" value="true" />
						<c:if test="${approver.a_status eq '0'}">
							<span id="status3"class="badge bg-primary">승인</span>
						</c:if>
						<c:if test="${approver.a_status eq '1'}">
							<span id="status3" class="badge bg-danger">반려</span>
						</c:if>
					</c:if>
				</c:forEach>

				<c:if test="${not memberFound}">
					 <span id="status3" class="badge bg-warning">대기</span>
				</c:if>
			</div>

		</div>
		<div id="approverList" class="table table-bordered" style="margin-top:20px;display:none;">
		  <table style="width:100%;">
		  	<thead>
		  	 <tr>
		  	  <th>결재자</th>
		  	  <th style="width:90px;">승인여부</th>
		  	  <th style="width:450px;">의견</th>
		  	  <th>일시</th>
		  	 </tr>
		  	</thead>
		  	<tbody>
		  		<tr>
		  		<td style="width:120px;">${member1.member_name } ${member1.member_rank }</td>
		  		<c:if test="${approvers[0].a_status eq null }">
		  		<td> <span id="status3" class="badge bg-warning">대기</span></td>
		  		</c:if>
		  		<c:if test="${approvers[0].a_status eq '0' }">
		  		<td style="width:100px;"> <span id="status3" class="badge bg-primary">승인</span></td>
		  		</c:if>
		  		<c:if test="${approvers[0].a_status eq '1' }">
		  		<td> <span id="status3" class="badge bg-danger">반려</span></td>
		  		</c:if>
		  		<td style ="font-size:15px;">${approvers[0].a_comment}</td>
		  		<td><fmt:formatDate value="${approvers[0].a_approvaldate }" pattern="yyyy.MM.dd HH.mm" /></td>
		  		</tr>
		  		<tr>
		  		<td>${member2.member_name } ${member2.member_rank }</td>
		  		<c:if test="${approvers[1].a_status eq null }">
		  		<td> <span id="status3" class="badge bg-warning">대기</span></td>
		  		</c:if>
		  		<c:if test="${approvers[1].a_status eq '0' }">
		  		<td> <span id="status3" class="badge bg-primary">승인</span></td>
		  		</c:if>
		  		<c:if test="${approvers[1].a_status eq '1' }">
		  		<td> <span id="status3" class="badge bg-danger">반려</span></td>
		  		</c:if>
		  		<td>${approvers[1].a_comment}</td>
		  		<td><fmt:formatDate value="${approvers[1].a_approvaldate }" pattern="yyyy.MM.dd HH.mm" /></td>
		  		</tr>
		  		<tr>
		  		<td>${member3.member_name } ${member3.member_rank }</td>
		  		<c:if test="${approvers[2].a_status eq null }">
		  		<td> <span id="status3" class="badge bg-warning">대기</span></td>
		  		</c:if>
		  		<c:if test="${approvers[2].a_status eq '0' }">
		  		<td> <span id="status3" class="badge bg-primary">승인</span></td>
		  		</c:if>
		  		<c:if test="${approvers[2].a_status eq '1' }">
		  		<td> <span id="status3" class="badge bg-danger">반려</span></td>
		  		</c:if>
		  		<td>${approvers[2].a_comment}</td>
		  		<td><fmt:formatDate value="${approvers[2].a_approvaldate }" pattern="yyyy.MM.dd HH.mm" /></td>
		  		</tr>
		  	</tbody>
		  </table>
		
		
		</div>
	
		
		<div class="comment-box" style="margin-top: 20px; margin-left: 75px;">
		<textarea name="commentdata" placeholder="의견을 작성해주세요. (50글자 이하)" style="width: 650px; height: 100px;" oninput="checkInputLength()"></textarea>

		</div>
		<div class="btns"
			style="display: flex; justify-content: flex-end; padding-right: 30px;">
			<div
				style="width: 250px; display: flex; justify-content:flex-end">

				<div id="btns2" style="display:flex;">
					<button onclick="approval_go(0)" style="background-color: #28a745; width: 80px; height: 50px; border: none; margin-right:10px; border-radius: 10%;">승인</button>
					<button onclick="approval_go(1)" style="background-color: #dc3545; width: 80px; height: 50px; border: none;margin-right:10px; border-radius: 10%;">반려</button>
				</div>
				<button onclick="window.close()"style="background-color: gray; width: 80px; height: 50px; border: none; border-radius: 10%;">취소</button>
			</div>


		</div>


	</div>
	<form id="data" method="post" action="approvalRegist">
		<input type="hidden" name="approval_id" value="${ap.approval_id }"></input>	
		<input type="hidden" name="approver" value="${loginUser.member_id }"></input>	
		<input type="hidden" name="comment" value=""></input>	
		<input type="hidden" name="status" value=""></input>	

	</form>
	
	
	
</div>



<script>
function checkInputLength() {
    var comment = document.getElementsByName("commentdata")[0].value;
    if (comment.length > 50) {
      alert("50글자 이하만 작성 가능합니다.");
    }
  }
	window.onload = function() {
		var status1 = document.getElementById("status1").innerText;
		var status2 = document.getElementById("status2").innerText;
		var status3 = document.getElementById("status3").innerText;
		var btns = document.getElementById("btns2");
	    var approvals = "${member.member_id}";
		var loginUser = "${loginUser.member_id}";
		var approver1 = "${member1.member_id}";
		var approver2 = "${member2.member_id}";
		var approver3 = "${member3.member_id}";
		
			console.log(status1);
			console.log(status2);
			if (loginUser === approvals) {
		 	  btns.style.display = "none";
		 	 document.querySelector('.comment-box').style.display = "none";
		 	 document.querySelector('.approvalBox').style.display = "none"; 
		 	 document.querySelector('#approverList').style.display= "";
		}

		
		if(status1 ==="반려" || status1 ==="반려" || status1 ==="반려"){
		  btns.style.display ="none";
		}
		
		if(loginUser === approver1 &&(status1 ==="승인" || status1 ==="반려") ){
			btns.style.display ="none";
		
		}	
		if(loginUser === approver2 &&(status2 ==="승인" || status2 ==="반려")){
			btns.style.display ="none";
		
		}	
		if(loginUser === approver3 && (status3 ==="승인" || status3 ==="반려")){
			btns.style.display ="none";
		
		}	

		if (loginUser === approver2
				&& (status1 !== "승인" || status1 === "대기")) {
			btns.style.display = "none";
		}

		if (loginUser === approver3
				&& (status2 !== "승인" || status2 === "대기")) {
			btns.style.display = "none";
		}
	}
	function approval_go(e) {
		  document.getElementsByName("comment")[0].value = document.getElementsByName("commentdata")[0].value;
		  document.getElementsByName("status")[0].value = e;
		  console.log(e);

		  if (e === 0) {
		    if (confirm("승인 하시겠습니까?") == true) {
		      $('form').submit();
		    } else {
		      console.log("취소되었습니다");
		    }
		  }
		  if (e === 1) {
		    if (confirm("반려 하시겠습니까?") == true) {
		      $('form').submit();
		    } else {
		      console.log("취소되었습니다");
		    }
		  }
		}

	
</script>





<%@include file="../include/openfoot.jspf"%>