<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/head.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>

  .card {
    width: 90%;
    margin:auto;
  
  }
  .search{
  	display:flex;
  	justify-content: flex-end;
  
  
  }
  .form{
  	display:flex;
  	justify-content: flex-end;
  }

 
</style>

<div class="p-4 sm:ml-64">
	    		<h1 class="text-3xl my-2">
	    		
 
      <span style="color: black;">
       ${title}
      </span>
   </h1>
    <div class="card">
    	<div class="card-header">

    		</div>
          <div class="card-body" >
         
            <div class="card">
              <div class="card-body">
              	<div class="search" style="margin-bottom:10px;">
        <form class="form"method="GET" action="list">
              		<input class="one" type="hidden" name="Type" id="Type" value="${Type }"/>
              		<input class="one" type="hidden" name="save" id="save" value="1"/>
              		<input class="one" type="hidden" name="page" id="page" value="1"/>
					<select class="form-control col-ms" name="status" id="status"style="width:90px; font-size:13px;">
					  		<option value="all"${status eq 'all' ? 'selected':'' }>결재상태</option>
					  		<option value="0" ${status eq '0' ? 'selected':''}>대기</option>
					  		<option value="2" ${status eq '2' ? 'selected':''}>반려</option>
					  		<option value="1" ${status eq '1' ? 'selected':''}>완료</option>
					  	</select>						
						<select class="form-control col-ms" name="st" id="st" style="width:90px; font-size:13px;">
							<option value="all"  ${st eq 'all' ? 'selected':'' }>전체</option>
							<option value="title" ${st eq 'title' ? 'selected':'' }>제 목</option>
							<option value="form_name" ${st eq 'form_name' ? 'selected':'' }>양식명</option>
							<%-- <option value="date" ${st eq 'date' ? 'selected':'' }>날짜</option>	 --%>					
						</select>	              		
              		<input  class="form-control" type="text" name="sk" placeholder="검색어를 입력하세요." value="${sk }"/>
              		 <button type="submit" class="w-1/8 bg-blue-300 btn-sm btn">
            	<i class="fas fa-search text-lg"></i>
            </button>
						</form>
              	</div>
              	<c:if test="${approvalList.size() ne 0 }">
                <table class="table table-bordered">
                  <thead style="background-color: #FAFAFA;">
                    <tr style="font-size:15px;">
                      <th style="width:50px;">기안일시</th>
                      <th style="width:60px;">기안양식</th>
                      <th style="width:230px;">제목</th>
                      <th style="width:50px;">작성자</th>
                      <th style="width:50px;">상태</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="approval" items="${approvalList}">
                    <c:if test="${approval.approval_save ne 2 }">
                      <tr style="font-size:15px;" onclick="OpenWindow('../approval/detail?approval_id=${approval.approval_id}','dd','800','800')">
                      </c:if>
                    <c:if test="${approval.approval_save eq 2 }">
                      <tr style="font-size:15px;" onclick="location.href='../approval/registForm?approval_id=${approval.approval_id}'">
                      </c:if>
                        <td>
                          <fmt:formatDate value="${approval.approval_registdate }" pattern="yyyy.MM.dd HH.mm" />
                        </td>
                        <td>
                           <c:forEach var="form" items="${form }">
                          <c:if test="${form.form_id eq approval.form_id }">
                           ${form.form_name }
                          </c:if>
                         </c:forEach>
                        </td>
                        <td>${approval.approval_title } <c:if test="${approval.approval_level eq 1 }"><span class="badge bg-blue-400">긴급</span></c:if></td>
                        <td>
                      <c:forEach items="${memberList }" var="member">
                          <c:if test="${member.member_id eq approval.approval_register }">
                           ${member.member_name } ${member.member_rank }
                          </c:if>
                          </c:forEach>
                        </td>
                        <td>
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
               <div style="display: flex; justify-content: center; align-items: center; width: 90%;height:80vh; background-color: #FAFAFA; margin: auto; border:1px solid #E9E9E9;">
  				 <p style="margin: 0; font-weight:bold; ">표시할 내용이 없습니다.</p>
				</div>
				</c:if>
				  <div class="row">
  <div class="col  text-center">
    <nav aria-label="Contacts Page Navigation" >
      <c:set var="pageMenuArmLen" value="4" />
      <c:set var="startPage" value="${param.page - pageMenuArmLen < 1 ? 1 : param.page - pageMenuArmLen}" />
      <c:set var="endPage" value="${param.page + pageMenuArmLen > pagesCount ? pagesCount : param.page + pageMenuArmLen}" />
      <c:set var="pageBaseUri" value="Type=${empty Type ? '' : Type}&sk=${sk}&st=${st}&save=${save }" />
      <ul class="pagination flex justify-center m-0"  >
        <c:if test="${startPage > 1}">
          <li class="page-item">
            <a class="page-link btn btn-sm" href="?${pageBaseUri}&page=1">1</a>
          </li>
          <c:if test="${startPage > 2}">
            <li class="page-item">
              <a class="page-link btn btn-sm">...</a>
            </li>
          </c:if>
        </c:if>
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
          <li class="page-item ${param.page == i ? 'active' : ''}">
            <a class="page-link btn btn-sm" href="?${pageBaseUri}&page=${i}">${i}</a>
          </li>
        </c:forEach>
        <c:if test="${endPage < pagesCount}">
          <li class="page-item">
            <a class="page-link btn btn-sm">...</a>
          </li>
        </c:if>
        <c:if test="${endPage < pagesCount-1}">
          <li class="page-item">
            <a class="page-link btn btn-sm" href="?${pageBaseUri}&page=${pagesCount}">${pagesCount}</a>
          </li>
        </c:if>
      </ul>
    </nav>
  </div>
</div>
		
                
              </div>
            </div>
          </div>
          		

        </div>
      </div>
    


  
<script>

function main_go(num2){
	
     

}


</script>


<%@include file="../include/foot.jspf" %>