<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/openhead.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<link href="https://cdn.jsdelivr.net/npm/daisyui@3.0.4/dist/full.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>

<style>
div.card-header{
	border-style:2px outset black;
	display:flex;
	justify-content:center; 
	align-items:center;
	color:gray;

}

div.footer-btn{
	height:200px;
	display:flex;
	justify-content: space-around;
}
div.resultid{
	color:black;
	font-size:20px;
	text-align:center; 
	display:flex; 
	flex-direction:column; 
	justify-content:center; 
	align-items: center;
	height:250px;
}
div>p{
	font-size:30px;
	color:blue;
}
</style>
<div class="content-wrapper bg-white">
	
	<div style="text-align:center;">
  <p class="text-blue-600 mt-4">아이디 찾기</p>
  </br>
</div>
<div class="card border-success mb-3" style="width:500px;height:500px; margin:0 auto;">
 	<div class="card-header"style="text-align:center; height:100px;">아이디를 잊으셨나요?</div>
  <div class="card-body text-success" style="height:400px;">
  <div class="resultid">
  		회원님의 찾으신 아이디는
  		<br/>
  		<br/>
  		<br/>
  		<p>${member.member_id}</p> 입니다.
  </div>     
    </div>
    <div class="footer-btn">
    <button onclick="window.close()"class="btn btn-outline btn-ghost btn-sm" style="width:150px; height:40px;">닫기</button>
	<button onclick="location.href='../common/forget'"type="button" class="btn btn-outline btn-primary btn-sm" style="width:150px; height:40px; margin:0">비밀번호찾기</button>
  </div>
  </div>
	
	
	
</div>









<%@include file="../include/openfoot.jspf"%>