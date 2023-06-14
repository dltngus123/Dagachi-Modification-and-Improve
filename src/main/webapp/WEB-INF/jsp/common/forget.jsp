<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/openhead.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<link href="https://cdn.jsdelivr.net/npm/daisyui@3.0.4/dist/full.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>

<style>
.card {
   
}
span{
margin-left:70px;
width:70px;
font-weight: bold;
}



input{
width:200px;
margin-left:20px;

}


        #modal-id.modal-overlay {
           
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        #modal-id .modal-window {
            background: rgba( 69, 139, 197, 0.70 );
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 400px;
            height: 500px;
            position: relative;
            top: -100px;
            padding: 10px;
        }
        #modal-id .title {
            padding-left: 10px;
            display: inline;
            text-shadow: 1px 1px 2px gray;
            color: white;
            
        }
        #modal-id .title h2 {
            display: inline;
        }
        #modal-id .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        
        #modal-id .content {
            margin-top: 20px;
            padding: 0px 10px;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        
        #modal-pwd.modal-overlay {
           
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        #modal-pwd .modal-window {
            background: rgba( 69, 139, 197, 0.70 );
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 400px;
            height: 500px;
            position: relative;
            top: -100px;
            padding: 10px;
        }
        #modal-pwd .title {
            padding-left: 10px;
            display: inline;
            text-shadow: 1px 1px 2px gray;
            color: white;
            
        }
        #modal-pwd .title h2 {
            display: inline;
        }
        #modal-pwd .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        
        #modal-pwd .content {
            margin-top: 20px;
            padding: 0px 10px;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }

</style>
<div class="content-wrapper">
   <div class="card">
      <div class="card-header"
         style="display: flex; justify-content:space-between; ">
         <h3 class="text-bold text-4xl">ID/PWD 찾기
         <i class="fas fa-search"></i>
         </h3>
      </div>
      <div class="card-body" style="background-color: #f1f1f1;">

   
      <div class="card md:card-side bg-base-100 shadow-xl h-1/2">
  <div class="flex justify-center items-center border-r border-gray-700 bg-blue-100 rounded-l-2xl">
     <h1 class="font-bold text-2xl p-8 cl-signature text-gray-500">&nbsp;&nbsp;아이디 찾기&nbsp;&nbsp;&nbsp;</h1>
  </div>
  <div class="card-body">
    <form id="id"action="findId" method="post">
      <div class="font-bold">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" placeholder="이름을 입력해 주세요" name="name" class="input input-bordered w-60 w-full max-w-xs" /></div>
         </br>
      <div class="font-bold">전화번호<input type="text" placeholder="ex)010-0000-0000" name="phone" class="input input-bordered w-60 w-full max-w-xs" /></div>
      </br>
      <div class="font-bold">이메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  name="email"placeholder="example@xxxx.com" class="input input-bordered w-full max-w-xs" /></div>
       </br>
       <div style="margin-right:50px;display:flex; justify-content:flex-end;">
       <button type="button"onclick="idfind_go();"class="btn btn-block btn-primary col-sm-3" id="btn-modal-id">ID찾기</button>
       </div>
      </form> 
    
  </div>
</div>



   
      <div class="card md:card-side bg-base-100 shadow-xl h-1/2">
  <div class="flex justify-center items-center border-r border-gray-700 bg-blue-100 rounded-l-2xl">
     <h1 class="font-bold text-2xl p-8 cl-signature text-gray-500">비밀번호 찾기</h1>
  </div>
  <div class="card-body">
      <form id="pwd" method="post" action="findPwd">
      <div class="font-bold">아이디&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="id" placeholder="아이디를 입력해 주세요" class="input input-bordered w-60 w-full max-w-xs" /></div>
         </br>
      <div class="font-bold">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  name="nameForPwd" placeholder="이름을 입력해 주세요" class="input input-bordered w-60 w-full max-w-xs" /></div>
      </br>
      <div class="font-bold">전화번호<input type="text" placeholder="ex)010-0000-0000" name="phoneForPwd" class="input input-bordered w-full max-w-xs" /></div>
       </br>
       <div class="font-bold">이메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" placeholder="example@xxxx.com" name="emailForPwd" class="input input-bordered w-full max-w-xs" /></div>
       </br>
       <div style="margin-right: 50px; display: flex; justify-content: flex-end;">
        <button id="btn-modal-pwd"  onclick="pwdfind_go();"type="button" class="btn btn-block btn-primary col-sm-3" style="height: 40px;">PWD 찾기</button>
       </div>
      </form> 
    
  </div>
</div>
   
     <div style="margin-right:50px;display:flex; justify-content:flex-end;">
       <button onclick="window.close()"class="btn btn-active btn-ghost col-sm-2" style="width:60px; height:40px;">닫기</button>
      </div>
      
         </div>
      
   </div>
</div>
   
   <div id="modal-id" class="modal-overlay">
   <div class="modal-window">
   <div class="card border-success mb-3" style="height:100%;">
    <div class="card-header text-bold text-center text-2xl">아이디를 잊으셨나요?</div>
  <div class="card-body flex items-center">
  <div class="resultid w-full text-center text-2xl text-bold">
        회원님의 찾으신 아이디는
        <br/>
       <p id="reId" class="text-bold text-6xl text-success reId"></p>
        <p class="text-2xl text-bold">
         입니다.
        </p>
  </div>     
    </div>
    <div class="footer-btn flex justify-center">
   <button type="button" class="btn btn-block btn-success btn-sm close-area mr-2" style="width:150px; height:40px;">닫기</button>
   </div>
  </div>
  </div>
   </div>
   
   <div id="modal-pwd" class="modal-overlay">
   <div class="modal-window">
   <div class="card border-success mb-3" style="height:100%;">
    <div class="card-header text-bold text-center text-2xl">비밀번호를 잊으셨나요?</div>
  <div class="card-body flex items-center">
  <div id="resultPwd" class="resultPwd w-full text-center text-2xl text-bold">
        회원님의 찾으신 비밀번호는
        <br/>
        <p id="rePwd"class="text-bold text-6xl text-success rePwd"></p>
        <p class="text-2xl text-bold">
         입니다.
        </p>
  </div>     
    </div>
    <div class="footer-btn flex justify-center">
   <button type="button" class="btn btn-block btn-success btn-sm close-area mr-2" style="width:150px; height:40px;">닫기</button>
   </div>
  </div>
  </div>
   </div>
   
   








<script>
var msg = "${msg}";
if (msg !== null && msg !== "") {
  alert(msg);
}
   

function idfind_go() {
     var name = document.getElementsByName("name")[0].value;
     var phone = document.getElementsByName("phone")[0].value;
     var email = document.getElementsByName("email")[0].value;

     if (name.trim() === "" || phone.trim() === "" || email.trim() === "") {
       alert("이름, 전화번호 및 이메일을 모두 입력해주세요.");
       return;
     }

    
     var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     if (!emailRegex.test(email)) {
       alert("이메일을 올바른 형식으로 입력해주세요. (ex: example@xxxx.com)");
       return;
     }

     $.ajax({
          url: "findId",
          type: "POST",
          dataType: "text",
          data: {
            name: name,
            phone: phone,
            email: email
          },
          success: function(response) {
            console.log(response);

            // 결과를 출력할 요소 선택
            var reIdElement = document.getElementById('reId');
            var resultidElement = document.getElementsByClassName('resultid')[0];

            if (response === 'none-data') {
              // 결과가 없는 경우
              reIdElement.innerHTML = ""; 
              resultidElement.textContent = "일치하는 정보가 없습니다.";
            } else {
              
              var resultHTML =
                 "찾으신 아이디는"+
                 "<p id='reId' class='text-bold text-6xl text-success reId'>" + response + "</p>"
                 +"입니다.";
             
              resultidElement.innerHTML = resultHTML;
              
            }
          },
          error: function(xhr, status, error) {
            console.log("에러 " + error);
          }
        });
      }

   function pwdfind_go() {
     var id = document.getElementsByName("id")[0].value;
     var nameForPwd = document.getElementsByName("nameForPwd")[0].value;
     var phoneForPwd = document.getElementsByName("phoneForPwd")[0].value;
     var emailForPwd = document.getElementsByName("emailForPwd")[0].value;

     if (id.trim() === "" || nameForPwd.trim() === "" || phoneForPwd.trim() === "" || emailForPwd.trim() === "") {
       alert("아이디, 이름, 전화번호 및 이메일을 모두 입력해주세요.");
       return;
     }
     var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     if (!emailRegex.test(emailForPwd)) {
       alert("이메일을 올바른 형식으로 입력해주세요. (ex: example@xxxx.com)");
       return;
     }

     var phoneRegex = /^\d{3}-\d{4}-\d{4}$/;
     if (!phoneRegex.test(phoneForPwd)) {
       alert("전화번호를 형식에 맞게 입력해주세요. (ex: 000-0000-0000)");
       return;
     }

     $.ajax({
          url: "findPwd",
          type: "POST",
          dataType: "text",
          data: {
            id: id,
            nameForPwd: nameForPwd,
            phoneForPwd: phoneForPwd,
            emailForPwd: emailForPwd
          },
          success: function(response) {
            console.log(response);

            // 결과를 출력할 요소 선택
            var rePwdElement = document.getElementById('rePwd');
            var resultPwdElement=document.getElementById('resultPwd');
            
            if (response === 'none-data') {
                // 결과가 없는 경우
                rePwdElement.innerHTML = ""; 
                resultPwdElement.textContent = "일치하는 정보가 없습니다.";
              }else{
                 var resultHTML =
                     "찾으신 비밀번호는"+
                     "<p id='rePwd' class='text-bold text-6xl text-success reId'>" + response + "</p>"
                     +"입니다.";
                 
                  resultPwdElement.innerHTML = resultHTML;
              }

           
          },
          error: function(xhr, status, error) {
            console.log("에러 " + error);
          }
        });
      }


   
const modal = document.getElementById("modal-id")
const btnModal = document.getElementById("btn-modal-id")
btnModal.addEventListener("click", e => {
    modal.style.display = "flex"
})

const closeBtn = modal.querySelector(".close-area")
closeBtn.addEventListener("click", e => {
    modal.style.display = "none"
})

modal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal-overlay")) {
        modal.style.display = "none"
    }
})


const modal2 = document.getElementById("modal-pwd")
const btnModal2 = document.getElementById("btn-modal-pwd")
btnModal2.addEventListener("click", e => {
    modal2.style.display = "flex"
})

const closeBtn2 = modal2.querySelector(".close-area")
closeBtn2.addEventListener("click", e => {
    modal2.style.display = "none"
})

modal2.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal-overlay")) {
        modal2.style.display = "none"
    }
})
   
   
</script>











<%@include file="../include/openfoot.jspf"%>