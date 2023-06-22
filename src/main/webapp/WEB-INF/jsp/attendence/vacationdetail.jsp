<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/openhead.jspf" %>
<style>
.rounded_div {
  border-radius: 50%;
  background-color:rgb(107, 114, 128);
  color:white; 
  height: 100px;
  width: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
}
.roundeddiv {
  border-radius: 50%;
  background-color: whtie;
  height: 90px;
  width: 40px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
   font-weight: bold;
   font-size:1.5rem;
}

</style>
<div class="flex justify-around mt-10" style="">
  <div class="inner rounded   " style="height: 100px; color: white; font-size: 1.2rem; display: flex;">
    <input type="hidden" name="vacation_member" />

    <div class="rounded_div" style="">
   
            <span style="margin-right:10px;">총 연차 <div style="font-weight: bold;">${vacationYear }</div></span>
            </div><div class="roundeddiv" style="">
            <div style="color:black; height:20px;  text-align:center; ">-</div></div>
            <div class="rounded_div" style="">
            <span >사용 연차<div style="  font-weight: bold;"> ${DelYear }</div></span>
            </div>
            <div class="roundeddiv" style="">
            <div style="color:black; height:20px;  text-align:center;">=</div>
            </div>
            <div class="rounded_div" style="">
            <span class="delYear">잔여 연차<div style="font-weight: bold;"> ${vacationYear -  DelYear }</div></span>
      
    </div>
    </div>
<div class="inner rounded   " style="height: 100px; color: white; font-size: 1.2rem; display: flex;">
    <div class="rounded_div"style="">
    <span >총 월차 <div style="font-weight: bold;">${vacationMonth }</div></span>
    </div>
    <div class="roundeddiv" style="">
            <div style="color:black; height:20px;  text-align:center;">-</div></div>
    <div class="rounded_div" style="">
            <span >사용 월차 <div style="font-weight: bold;">${DelYear }</div></span>
     
    </div>
       <div class="roundeddiv" style="">
            <div style="color:black; height:20px;  text-align:center;">=</div>
            </div>
    <div class="rounded_div" style="">
            <span>잔여 월차 <div style="font-weight: bold;">${vacationMonth - DelMonth }</div></span>
   </div>
   
 
</div>
</div>

<div class="card w-full bg-base-100 shadow-xl">
  <div class="card-body">
    <h2 class="card-title bg-gray-300 ">연/월차 조회</h2>
    <p>
    <table class="table table-fixed w-full">
   <thead>
            <tr>
               <th>연/월차 생성일(생성갯수)</th>
               <th>연/월차 사용일</th>
               <th>연/월차 사용개수</th>
               <th>상태/사유</th>
            </tr>
            </thead>
         <tbody>
            <c:forEach items="${vacation }" var="vacation">
               <tr>
                  <td><fmt:formatDate value="${vacation.year_vacation_regDate }" pattern="yyyy-MM-dd" /><fmt:formatDate value="${vacation.month_vacation_regDate }" pattern="yyyy-MM-dd" />(연차:${vacationYear }개/월차:${vacationMonth }개)</td>
                  <td><fmt:formatDate value="${vacation.vacation_updateDate }" pattern="yyyy-MM-dd" /></td>
                  <td>연차:${vacation.del_year_vacation_count }개/월차:${vacation.del_month_vacation_count }개</td>
                  <td>
                     <c:if test="${vacation.del_year_vacation_count > 0}">
                     <button class="rounded "type="button" style="background-color:#bef78b; border:none;">연차</button>
                     </c:if>
                     <c:if test="${vacation.del_month_vacation_count > 0}">
                     <button class="rounded" type="button" style="background-color:#f8e589; border:none;">월차</button>
                     </c:if>
                  /${vacation.vacation_reason }
                  </td>
               </tr>
            </c:forEach>
            </tbody>

</table>
    </p>
   
  </div>
</div>

   


<%@include file="/WEB-INF/jsp/include/openfoot.jspf" %>