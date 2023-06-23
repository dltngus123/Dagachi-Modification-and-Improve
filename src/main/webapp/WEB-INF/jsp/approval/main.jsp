<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
  .card-body {
    width: 90%;
    margin: auto;
    height: 400px;
    padding:none;
    overflow-x: auto;
    gap:0 !important;
  }
 .card-body.override {
    gap: 0;
}
  table {
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
  }
  thead {
  position: stikey;
  top: 0;
  z-index: 1;
}

  th {
    font-size: 15px;
    font-weight: bold;
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    position: sticky;
    top: 0;

  }

  td {
    font-size: 15px;
    padding: 10px;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    border-bottom: 1px solid #ddd;
  }
</style>
<%@ include file="../include/head.jspf" %>
<script>
   
   window.addEventListener('load', function(){
        checkedBookMark("/approval/main");
         
      })
   
</script>

<div class="p-4 sm:ml-64">
<div class="content-header">
<h1 class="text-3xl my-2">
   <a href='javascript:registBookMark("/approval/main", "전자결재 메인")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
       전자 결재
      </span>
   </h1>

</div>
  <div>
    <div class="card" >
	<div class="infobox" style="display:flex; justify-content:center; width:90%; margin:auto; margin-bottom:10px; margin-top:10px;">
    <div class="rounded-xl ml-2 text-lg"style="width:25%; height:150px;background-color:#60A5FA;"onmouseout="this.style.backgroundColor= '#60A5FA';this.style.color='#f1f1f1'"
                                    onmouseover="this.style.backgroundColor= '#93c5fd';this.style.color='#f1f1f1'">
        <a href="../approval/list?Type=approval&status=0&save=1">
            <p style="font-size:13px; padding:10px;color:#f1f1f1;">결재 대기 중 문서🔍</p>
            <p style="text-align:center; font-size:25px; color:black;">${num }</p>
        </a>
    </div>	
    <div class="rounded-xl ml-2 text-lg"style="width:25%; height:150px; background-color:#60A5FA;"onmouseout="this.style.backgroundColor= '#60A5FA';this.style.color='#f1f1f1'"
                                    onmouseover="this.style.backgroundColor= '#93c5fd';this.style.color='#f1f1f1'">
        <a href="../approval/list?Type=approver&status=0&save=1">
            <p style="font-size:13px; padding:10px;color:#f1f1f1;">결재해야 할 문서🔍</p>
            <p style="text-align:center; font-size:25px; color:black;">${num2 }</p>
        </a>
    </div>
    <div class="rounded-xl ml-2 text-lg"style="width:25%; height:150px; background-color:#60A5FA;"onmouseout="this.style.backgroundColor= '#60A5FA';this.style.color='#f1f1f1'"
                                    onmouseover="this.style.backgroundColor= '#93c5fd';this.style.color='#f1f1f1'">
        <a href="../approval/list?Type=approval&status=2&save=1">
            <p style="font-size:13px; padding:10px;color:#f1f1f1;">반려된 문서🔍</p>
            <p style="text-align:center; font-size:25px;color:black;">${num3 }</p>
        </a>
    </div>
    <div class="rounded-xl ml-2 text-lg"style="width:25%; height:150px;background-color:#60A5FA;"onmouseout="this.style.backgroundColor= '#60A5FA';this.style.color='#f1f1f1'"
                                    onmouseover="this.style.backgroundColor= '#93c5fd';this.style.color='#f1f1f1'">
        <a href="../approval/list?Type=save&save=2" >
            <p style="font-size:13px; padding:10px;color:#f1f1f1;">임시저장한 문서🔍</p>
            <p style="text-align:center; font-size:25px;color:black;">${num4 }</p>
        </a>
    </div>
</div>
	
            <div class="card override" style="height:100vh;!important; grap:none;">
              <div class="card-body override" style="width:90%;  height:25%; !important; grap:none;">
           <a href="list?Type=approval&save=1" class="mb-0" style="grap:none;"><button style="font-weight:bold; border:1px solid #6ee7b7 " class="bg-green-200 rounded-t-md mb-0 p-2" >내가 상신한 문서</button></a>
              <c:if test ="${approvalList.size() ne 0 }">
                <table class="table table-bordered mt-0" id="approvalList">
                  <thead style="background-color: #FAFAFA;">
                    <tr style="font-size:15px;">
                      <th  style="width:15%;">기안일시</th>
                      <th style="width:10%;">기안양식</th>
                      <th style="width:45%;">제목</th>
                      <th style="width:15%;">작성자</th>
                      <th style="width:15%;">상태</th>
                    </tr>
                  </thead>
                  <tbody > 
                    <c:forEach var="approval" items="${approvalList}" begin="0" end="4">
                         <tr style="font-size:15px;" onclick="OpenWindow('../approval/detail?approval_id=${approval.approval_id}','dd','800','800')" >
                      
                        <td >
                          <fmt:formatDate value="${approval.approval_registdate }" pattern="yyyy.MM.dd HH.mm" />
                        </td>
                        <td>
                         <c:forEach var="form" items="${form }">
                          <c:if test="${form.form_id eq approval.form_id }">
                           ${form.form_name }
                          </c:if>
                         </c:forEach>
                        </td>
                    
                        <td>${approval.approval_title }<c:if test="${approval.approval_level eq 1 }"><span class="badge bg-blue-400">긴급</span></c:if></td>
                        <td >
                       <c:forEach items="${memberList }" var="member">
                          <c:if test="${member.member_id eq approval.approval_register }">
                           ${member.member_name } ${member.member_rank }
                          </c:if>
                          </c:forEach>
                        </td>
                        <td >
                          <c:if test="${approval.approval_status eq 0}"><span class="badge bg-yellow-400">대기</span></c:if>
                          <c:if test="${approval.approval_status eq 1}"><span class="badge bg-green-400">완료</span></c:if>
                          <c:if test="${approval.approval_status eq 2}"><span class="badge bg-red-400">반려</span></c:if>
                        </td>
                    
                      </tr> 
                 
                    </c:forEach>
                  </tbody>
                  
                </table>
                </c:if>
                <c:if test="${approvalList.size() eq 0 }">
               <div style="display: flex; justify-content: center; align-items: center; width: 90%; height: 90%; background-color: #FAFAFA; margin: auto; border:1px solid #E9E9E9;">
  				 <p style="margin: 0; font-weight:bold; ">표시할 내용이 없습니다.</p>
				</div>
				</c:if>
              </div>
              
                <div class="card-body " style="width:90%; height:25%;!important; grap:none; ">
             <a href="list?Type=approver&save=1"><button style="font-weight:bold; border:1px solid #f87171 " class=" bg-red-300 rounded-t-md mb-0 p-2">내가 결재한/결재할 문서</button></a>
              
              <c:if test="${approverList.size() ne 0 }">
                <table class="table table-bordered" id="approverList">
                  <thead style="background-color: #FAFAFA;">
                    <tr style="font-size:15px;">
                      <th  style="width:15%;">기안일시</th>
                      <th style="width:10%;">기안양식</th>
                      <th style="width:45%;">제목</th>
                      <th style="width:15%;">작성자</th>
                      <th style="width:15%;">상태</th>
                    </tr>
                  </thead>
                  <tbody > 
                    <c:forEach var="approver" items="${approverList}" begin="0" end="4">
                      <tr style="font-size:15px;" onclick="OpenWindow('../approval/detail?approval_id=${approver.approval_id}','dd','800','800')">
                        <td >
                          <fmt:formatDate value="${approver.approval_registdate }" pattern="yyyy.MM.dd HH.mm" />
                        </td>
                        <td  >
                         <c:forEach var="form" items="${form }">
                          <c:if test="${form.form_id eq approver.form_id }">
                           ${form.form_name }
                          </c:if>
                         </c:forEach>
                        </td>
                        <td>${approver.approval_title }<c:if test="${approvel.approval_level eq 1 }"><span class="badge bg-blue-400">긴급</span></c:if></td>
                        <td >
                        <c:forEach items="${memberList }" var="member">
                          <c:if test="${member.member_id eq approver.approval_register }">
                           ${member.member_name } ${member.member_rank }
                          </c:if>
                          </c:forEach>
                        </td>
                        <td >
                          <c:if test="${approver.approval_status eq 0}"><span class="badge bg-yellow-400">대기</span></c:if>
                          <c:if test="${approver.approval_status eq 1}"><span class="badge bg-green-400">완료</span></c:if>
                          <c:if test="${approver.approval_status eq 2}"><span class="badge bg-red-400">반려</span></c:if>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                  
                </table>
                </c:if>
                <c:if test="${approverList.size() eq 0 }">
               <div style="display: flex; justify-content: center; align-items: center; width: 90%; height: 90%; background-color: #FAFAFA; margin: auto; border:1px solid #E9E9E9;">
  				 <p style="margin: 0; font-weight:bold; ">표시할 내용이 없습니다.</p>
				</div>
				</c:if>
              </div>
            </div>
      </div>
    </div>
  </div>
  
<%@include file="../include/foot.jspf" %>