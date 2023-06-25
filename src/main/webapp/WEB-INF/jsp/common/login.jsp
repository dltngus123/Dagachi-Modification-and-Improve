<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="https://cdn.jsdelivr.net/npm/daisyui@3.0.4/dist/full.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>
	
<style>
.back{
	
	width: 100%; 
  	height: 100vh;
	background-image:url('../resource/img/430-5000x3333.jpg');
	background-repeat:no-repeat;
	background-position:center;
    background-size:cover;
}


.bg-signature{

}

.cl-signature{
}


</style>





<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body class="back flex justify-center items-center">
   <!-- <div style="margin-left:800px;padding-top:100px;width:400px; height:300px;">
      <form method="POST" action="dologin">
      <input type="text"  name="member_id"class="id" placeholder="아이디를 입력하세요.">
      <input type="password" name="member_pwd"class="pwd" placeholder="비밀번호를 입력하세요.">
      </br>
      <div style="paddin:none;margin-top:10px; margin-left:40px; font-size:15px;"><input type="checkbox">아이디 기억하기</input></div>
      <button type="submit" class="btn btn-block btn-primary button">LOGIN</button>
      </form>
        <a href="javascript:window.open('../common/forget', 'dd', 'width=800,height=800');"style="display:block; padding:none;margin-top:20px; margin-left:170px;">아이디/비밀번호 찾기</a>
   
   </div>    -->
   <div class="card lg:card-side bg-base-100 shadow-xl h-1/2">
  <div class="flex justify-center items-center border-r">
     <h1 class="font-bold text-6xl p-14 cl-signature">DAGACHI</h1>
  </div>
  <div class="card-body">
    <h2 class="card-title text-3xl cl-signature mb-4">Log-In</h2>
    <form method="POST" action="dologin">
      <input type="text" placeholder="아이디를 입력하세요"  name="member_id" class="input input-bordered w-80 max-w-xs" />
      </br>
      </br>
      <input type="password" placeholder="비밀번호를 입력하세요"  name="member_pwd" class="input input-bordered w-full max-w-xs" />
      </br>
      </br>
      <div class="p-2">
         <input type="checkbox">아이디 기억하기</input>
      </div>
      <button type="submit" class="btn btn-block bg-blue-400 button">LOGIN</button>
      </form> 
      <a class="" href="javascript:window.open('../common/forget', 'dd', 'width=800,height=800');">아이디/비밀번호 찾기</a>
  </div>
</div>
   
   

<script>
var msg = "${msg}";
if (msg !== null && msg !== "") {
  alert(msg);
}


</script>   
   
   
 
</body>
</html>