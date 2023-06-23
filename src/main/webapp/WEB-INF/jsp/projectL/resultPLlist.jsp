<%@page import="java.util.List"%>
<%@page import="com.sbs.dagachi.vo.PM"%>
<%@page import="com.sbs.dagachi.service.ProjectLService"%>
<%@page import="com.sbs.dagachi.service.PMService"%>
<%@page import="com.sbs.dagachi.vo.ProjectL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<c:forEach var="pl" items="${plList }">
<c:set var="pmList" value="${pl.extra_pmList }"></c:set>

<%
   List<PM>pmList=(List<PM>)pageContext.getAttribute("pmList");
   double pmCnt=pmList.size();
   double comPmCnt=0;
   for(PM pm:pmList){
      if(pm.getPm_status()==2){
         comPmCnt++;
      }
   }
   
   int percent= (int)(comPmCnt/pmCnt*100.0);
   pageContext.setAttribute("percent", percent);
%>

<c:set var="percent" value="${pageScope.percent }"></c:set>

<div class="mb-4">
      <div class="w-full h-full">
         <div class="info-box bg-gray-300 rounded-3xl p-2">
         <input type="hidden" name="pl_id_value" value="" />
            <div class="">
               <h3 class="text-lg font-bold">${pl.pl_Name }</h3>
               <span>전체 진행율 ${percent }%</span>
               <div class="progress">
                  <div class="progress-bar" style="width: ${percent}%"></div>
               </div>
               <div class="row">
                  <fmt:formatDate var="endDate" value="${pl.pl_EndDate }" pattern="yyyy년 MM월 dd일"/>
                  <div class="col-sm-6">마감기한: ${endDate }</div>
                  <div class="col-sm-6 text-right" >
                  <a href="javascript:OpenWindow('moveAnotherTeamForm?pl_id=${pl.pl_Id }','업무관리',800,700)" style="color:white;">
                     업무 설정
                  </a>
                  
                  </div><!-- 여기다가 클릭시 다른 업무로 업무 파싱하기 -->
               </div>
               <div class="row">
               
               <div class="col-12">
                  <div class="card card-warning collapsed-card">
                  <div class="card-header flex justify-between">
                  <h3 class="card-title">업무 상세보기(${fn:length(pl.extra_pmList) })</h3>
                  <div class="card-tools">
                  <button type="button" class="btn btn-sm btn-tool" data-card-widget="collapse" onclick="aaa('${pl.pl_Id }')">
                  <i class="fas fa-plus"></i>
                  </button>
                  </div>
                  
                  </div>
                  
                  <div class="card-body p-2" data-id="${pl.pl_Id }"style="display: none; color:black;">
                     <ul class="bg-white p-2 rounded-3xl"style="">
                           <c:forEach var="pm" items="${pmList }">
                              <li class="" style="list-style: none;">
                                 <div class="flex justify-between flex-nowrap">
                                    <div class="w-2/3 font-bold">
                                       ${pm.pm_name }
                                    </div>
                                    <div class="w-1/6">
                                       ${pm.extra_pm_manager_name }
                                    </div>
                                    <div class="w-1/6">
                        
                                       <c:if test="${pm.pm_status eq '0'}">
                                          <span class="badge bg-blue-300">
                                          대기
                                          </span>
                                       </c:if>
                                       <c:if test="${pm.pm_status eq '1'}">
                                          <span class="badge bg-yellow-300">
                                          진행
                                          </span>
                                       </c:if>
                                       <c:if test="${pm.pm_status eq '2'}">
                                          <span class="badge bg-green-300">
                                          완료
                                          </span>
                                       </c:if>
                                       
                                    </div>
                                 </div>   
                              </li>
                           </c:forEach>
                        
                           
                     </ul>
                  </div>
                  
                  </div>
                  
                  </div>
               </div>
            
            </div>
         
         </div>
      
      </div>
   </div>

            
</c:forEach>
