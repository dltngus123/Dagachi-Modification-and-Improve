<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="메인" />

<%@include file="/WEB-INF/jsp/include/head2.jspf" %>
<!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- fullcalendar CDN -->
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js'></script>
  <!-- moment?쓰려고 가져옴 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<style>
  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

  .progress {
    width: 100%;
    background-color: #f1f1f1;
    border-radius: 5px;
  }

  .progress-bar {
    width: 0%;
    height: 20px;
    background-color: #4CAF50;
    border-radius: 5px;
    transition: width 0.5s ease-in-out;
  }
#approval-list-tab
 {
  background-color: rgb(147, 197, 253);
}

#approval-success-list-tab{
 background-color: rgb(252, 211, 77) ;
}

#approval-list-tab:hover
 {

  background-color:lightblue ;
  
}

#approval-success-list-tab:hover{
	background-color:rgb(253, 230, 138);
}


</style>
<script>
  $(document).ready(function() {
    // Hide the "Approval Success List" initially
    $("#approval-success-list").hide();

    // Handle tab click events
    $("#approval-list-tab").click(function() {
      $("#approval-list").show();
      $("#approval-success-list").hide();
    });

    $("#approval-success-list-tab").click(function() {
      $("#approval-list").hide();
      $("#approval-success-list").show();
    });
  });
  
</script>


<div class="p-4 sm:ml-64">
  
  <div class="flex" style="background-color:#FCFCFC" >
    <div class="w-7/12">
      <div class="flex " style="width:100%;">
        <nav class="">
<!--         <div class="tabs">
		  <a class="tab tab-lifted">Tab 1</a> 
		  <a class="tab tab-lifted tab-active">Tab 2</a> 
		  <a class="tab tab-lifted">Tab 3</a>
		</div> -->
<!--           <div class="nav tabs" id="product-tab" role="tablist">
            <a class="" id="approval-list-tab" data-toggle="tab" href="#approval-list" role="tab" aria-controls="approval-list" aria-selected="true">내가 상신한 문서</a>
            <a class="" id="approval-success-list-tab" data-toggle="tab" href="#approval-success-list" role="tab" aria-controls="approval-success-list" aria-selected="false">내가 결재할 문서</a>
          </div> -->
        </nav>
        <div class="tab-content" style="width:100%;" id="nav-tabContent">
                <div class="tabs ">
		  <a class="tab tab-lifted tab-active "id="approval-list-tab" data-toggle="tab" href="#approval-list" role="tab" aria-controls="approval-list" aria-selected="true">내가 상신한 문서</a>
		  <a class="tab tab-lifted tab-active"id="approval-success-list-tab" data-toggle="tab" href="#approval-success-list" role="tab" aria-controls="approval-success-list" aria-selected="false">내가 결재할 문서</a>
		</div>
		 <div class="tab-pane fade show active" id="approval-list" role="tabpanel" aria-labelledby="product-desc-tab">
            <div class="card shadow">
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                 <th style="width:5%;">양식 명</th>
                      <th style="width:40%;">문서 제목</th>
                      <th style="width:20%;">기안자</th>
                      <th style="width:10%;">등록 일시</th>
                      <th style="width:10%;">결재 상태</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${approvalList }" var="approval">
                        <tr onclick="OpenWindow('/approval/detail?approval_id=${approval.approval_id}','dd','800','800')">
                          <td>
                           <c:forEach var="form" items="${form }">
                          <c:if test="${form.form_id eq approval.form_id }">
                           ${form.form_name }
                          </c:if>
                         </c:forEach>
                          </td>
                          <td>${approval.approval_title } <c:if test="${approval.approval_level eq 1 }"><span class="badge bg-blue-400">긴급</span></c:if></td>
                          <td> <c:forEach items="${memberList }" var="member">
                          <c:if test="${member.member_id eq approval.approval_register }">
                           ${member.member_name } ${member.member_rank }
                          </c:if>
                          </c:forEach></td>
                          <td>
                           <fmt:formatDate value="${approval.approval_registdate }" pattern="yyyy.MM.dd HH.mm" />
                          </td>
                          <td>
                           <c:if test="${approval.approval_status eq 0}"><span class="badge bg-yellow-400">대기</span></c:if>
                          <c:if test="${approval.approval_status eq 1}"><span class="badge bg-green-400">완료</span></c:if>
                          <c:if test="${approval.approval_status eq 2}"><span class="badge bg-red-400">반려</span></c:if>
                          </td>
                        </tr>
					</c:forEach>
                    <c:if test="${empty approvalList}">
                      <tr>
                        <td colspan="8">결재 내역이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
           <div class="tab-pane fade" id="approval-success-list" role="tabpanel" aria-labelledby="product-comments-tab">
            <div class="card">
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th style="width:5%;">양식 명</th>
                      <th style="width:40%;">문서 제목</th>
                      <th style="width:20%;">기안자</th>
                      <th style="width:10%;">등록 일시</th>
                      <th style="width:10%;">결재 상태</th>
                    </tr>
                  </thead>
                  <tbody>
    <c:forEach items="${approverList }" var="approval">
                        <tr onclick="OpenWindow('/approval/detail?approval_id=${approval.approval_id}','dd','800','800')">
                          <td>
                           <c:forEach var="form" items="${form }">
                          <c:if test="${form.form_id eq approval.form_id }">
                           ${form.form_name }
                          </c:if>
                         </c:forEach>
                          </td>
                          <td>${approval.approval_title } <c:if test="${approval.approval_level eq 1 }"><span class="badge bg-blue-400">긴급</span></c:if></td>
                            <td> <c:forEach items="${memberList }" var="member">
                          <c:if test="${member.member_id eq approval.approval_register }">
                           ${member.member_name } ${member.member_rank }
                          </c:if>
                          </c:forEach></td>
                          <td>
                           <fmt:formatDate value="${approval.approval_registdate }" pattern="yyyy.MM.dd HH.mm" />
                          </td>
                          <td>
                           <c:if test="${approval.approval_status eq 0}"><span class="badge bg-yellow-400">대기</span></c:if>
                          <c:if test="${approval.approval_status eq 1}"><span class="badge bg-green-400">완료</span></c:if>
                          <c:if test="${approval.approval_status eq 2}"><span class="badge bg-red-400">반려</span></c:if>
                          </td>
                        </tr>
					</c:forEach>
                    <c:if test="${empty approvalList}">
                      <tr>
                        <td colspan="8">결재 내역이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
        </div>
      </div>
      <div class="flex my-2" style="width:100%;">
        <nav class="">
         <!--  <div class="nav nav-tabs" id="product-tab" role="tablist">
            <a class="nav-item nav-link active" id="project-send-tab" data-toggle="tab" href="#project-send" role="tab" aria-controls="project-send" aria-selected="true">받은 요청 목록</a>
            <a class="nav-item nav-link" id="project-receive-tab" data-toggle="tab" href="#project-receive" role="tab" aria-controls="project-receive" aria-selected="false">보낸 요청 목록</a>
          </div> -->
        </nav>
        <div class="tab-content" style="width:100%;" id="nav-tabContent">
                        <div class="tabs ">
		  <a class="tab tab-lifted tab-active " style="background-color: rgb(147, 197, 253);"id="project-send"id="project-send-tab" data-toggle="tab" href="#project-send" role="tab" aria-controls="project-send" aria-selected="true">받은 요청 목록</a>
		</div>
          <div class="tab-pane fade show active" id="project-send" role="tabpanel" aria-labelledby="product-desc-tab">
            <div class="card shadow">
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th style="width:5%;">요청 번호</th>
                      <th>요청 제목</th>
                      <th style="width:10%;">마감기한</th>
                      <th style="width:10%;">요청자</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:set var="count" value="0" />

                    <c:forEach var="test" items="${psList}">
                      <c:if test="${count lt 5}">
                        <tr>
                          <td>${test.ps_Id}</td>
                          <td><a href="/dagachi/projectS/list" onclick="" style="color:black;">${test.ps_title}</a></td>
                          <fmt:formatDate value="${test.ps_EndDate}" var="endDate" pattern="yyyy.MM.dd"/>
                          <td>${endDate}</td>
                          <c:forEach items="${memberList }" var="member">
                          <c:if test="${test.ps_Sender eq member.member_id }">
                          <td>${member.member_name}</td>
                          </c:if>
                          </c:forEach>
                        </tr>
                        <c:set var="count" value="${count + 1}" />
                      </c:if>
                    </c:forEach>
                    <c:if test="${empty psList}">
                      <tr>
                        <td colspan="8">받은 요청이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
<%--           <div class="tab-pane fade" id="project-receive" role="tabpanel" aria-labelledby="product-comments-tab">
            <div class="card">
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th style="width:5%;">요청 번호</th>
                      <th>요청 제목</th>
                      <th style="width:10%;">요청 날자</th>
                      <th style="width:5%;">첨부파일</th>
                      <th style="width:10%;">요청자</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:set var="count" value="0" />

                    <c:forEach var="test" items="${tests}">
                      <c:if test="${count lt 5}">
                        <tr>
                          <td>${test.tno}</td>
                          <td><a href="" onclick="" style="color:black;">${test.title}</a></td>
                          <td>${test.date}</td>
                          <td style="text-align:center;">
                            <c:if test="${test.type ne null}">
                              <i class='fa fa-file'></i> <!-- Add your file icon element here -->
                            </c:if>
                          </td>
                          <td>${test.name}</td>
                        </tr>
                        <c:set var="count" value="${count + 1}" />
                      </c:if>
                    </c:forEach>
                    <c:if test="${empty tests}">
                      <tr>
                        <td colspan="8">보낸 요청이 없습니다.</td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div> --%>
                  <div class="w-full pl-0 my-2">
          <div class="card shadow">
            <div class="card-header">
				<div class="tabs ">
		  			  <a class="tab tab-lifted tab-active project" id="tab" style="background-color: rgb(147, 197, 253);">업무 진행도</a>
				</div>
            </div>
            <div class="card-body table-responsive p-0">
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th>제목</th>
                    <th>진척도</th>
                  </tr>
                </thead>
                <tbody>
                  <c:set var="count" value="0" />

                  <c:forEach var="pl" items="${plList}">
                    <c:if test="${count lt 5}">
                      <tr>
                        <td><a href="/dagachi/projectM/list" onclick="" style="color:black;">${pl.pl_Name}</a></td>
                        <td>
                          <div class="progress">
                            <div class="progress-bar" style="width: ${pl.plProgress}%;" title="${test.progress}% 완료"></div>
                          </div>
                        </td>
                      </tr>
                      <c:set var="count" value="${count + 1}" />
                    </c:if>
                  </c:forEach>
                  <c:if test="${empty plList}">
                    <tr>
                      <td colspan="8">업무가 없습니다.</td>
                    </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        </div>
      </div>
           
      
    </div>
    <div class="w-5/12">
      <div class="flex ">

        <div id='calendar'></div>

      </div>
      
<div class="flex ">
        <div class="w-6/12 pl-0 ">
     <div class="flex justify-center w-auto m-4 shadow rounded-xl">
        <div class="card card-flex card-secondary w-100 m-4 h-100 ">
          <div class="card-header bordered">
            <h3 class="card-title">
              오늘 할일
            </h3>
          </div>
<div class="card-body">
    <div class="card card-info card-outline">
        <div class="card-body" style="text-align:left; font-weight: bold;">
            <div id="todayCheckbox"></div>
            <div id="message"></div>
        </div>
    </div>
</div>
        </div>
      </div>
        </div>
        <div class="w-6/12 pr-0 my-2">
<div class="card shadow" >
  <div class="card-header">
    				<div class="tabs ">
          <a class="tab tab-lifted tab-active notice" style="background-color: rgb(147, 197, 253);">공지사항</a>
				</div>
  </div>

  <div class="card-body table-responsive p-0">
    <table class="table table-hover text-nowrap">
      <thead>
        <tr>
          <th >번호</th>
          <th>제목</th>
          <th>작성날짜</th>
        </tr>
      </thead>
      <tbody id="noticeTableBody">
       <c:forEach var="article" items="${borad1}" >
       <tr>
       	<td>${article.article_id }</td>
       	<td><a href="/notice/detail?article_id=${article.article_id }">${article.article_title }</a></td>
       	<td>${article.article_regdate.substring(0, 11)}</td>
       </tr>
       </c:forEach>
      </tbody>
    </table>
  </div>
</div>
        </div>
      </div>
      
    </div>
    
  </div>





<script>
$.ajax({
    url: "/getPersonalCalendar",
    type: "GET",
    dataType: "json",
    success: function(data) {
        var today = new Date(); // Get today's date
        var project_s = "";

        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            var title = item.title;
            var start = new Date(item.start);

            // Check if the start date is the same as today's date
            if (start.toDateString() === today.toDateString()) {
                var formattedDate = formatDate(start);
                project_s += '<p>' + title + ' - ' + formattedDate + '</p>';
            }
        }

        if (project_s === "") {
            $("#message").text("업무가 없습니다.");
        } else {
            $("#todayCheckbox").html(project_s);
        }
    },
    error: function(xhr, status, error) {
        console.log("Error: " + error);
    }
});

function formatDate(date) {
    return date.toLocaleString("en-US", { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' });
}
</script>


 <script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      headerToolbar: {
        left: 'prev,next addEventButton',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      navLinks: true,
      selectable: true,
      nowIndicator: true,
      dayMaxEvents: true,
      locale: 'ko',
      selectMirror: true,
      select: function(arg) {
    	  var title = prompt('Event Title:');
    	  if (title) {
    	    var schedule_code = arg.schedule_code;
    	    var title = arg.title;
    	    var content = arg.content;
    	    var start = arg.start;
    	    var end = arg.end;
    	    var writer = arg.writer;
    	    // Prompt the user for the schedule_code value
    	    var schedule_code = prompt('schedule_code:');
          // Send the event data to the server and save it in the database
          $.ajax({
            url: '/getCommonlCalendar',
            method: 'GET',
            data: {
            	schedule_code : arg.schedule_code,
                title : arg.title,
                content : arg.content,
                start : arg.start,
                end : arg.end,
                writer : arg.writer
            },
            success: function(response) {
              // If the event is saved successfully, add it to the calendar
              var eventData = JSON.parse(response);
			
            },
            error: function() {
              alert('저장 실패.');
            }
          });
        }
        calendar.unselect();
      },
      events: function(fetchInfo, successCallback, failureCallback) {
        $.ajax({
          url: '/getCommonCalendar',
          method: 'GET',
          dataType: 'json',
          success: function(data) {
            var loginUser = '${loginUser.member_id}';
            var events = data.map(function(event) {
            var eventData = {
            	schedule_code:event.schedule_code,
                title: event.title,
                content:event.content,
                start: event.start,
                end: event.end,
                schedule_code : event.schedule_code
              };
              

                return eventData;

            });

            successCallback(events);
          },
          error: function() {
            failureCallback({ message: '서버에서 이벤트를 불러오는 데 실패했습니다.' });
          }
        });
      },
      customButtons: {
        addEventButton: {
          text: '일정 추가',
          click: function() {
              // Server-side condition
              var memberAuth = ${loginUser.member_auth};
              if (memberAuth !== 1) {
            	location.href='/schedule/commonCal';
            	
              } else {
            	 
                alert("공용 일정 등록 권한이 없습니다.");
                if (confirm("공용일정 페이지로 이동하시겠습니까?")) {
                	location.href='/schedule/commonCal';
                }
            }
          }
        }
      },
      // other calendar options...
    });
    calendar.on('eventClick', function(info) {
         // Get the event data
         var event = info.event;
         var eventData = event.extendedProps;
         var startFormatted = moment(event.start).format('YYYY-MM-DD HH:mm');
         var endFormatted = moment(event.end).format('YYYY-MM-DD HH:mm');

         // Set the values in the modal inputs
         //상세
         $("#schedule_title_detail").val(event.title);
         $("#schedule_content_detail").val(eventData.content);
         $("#schedule_start_detail").val(startFormatted);
         $("#schedule_end_detail").val(endFormatted);
         $("#schedule_code").val(eventData.schedule_code);

         $("#modifyButton").show();
         $("#deleteButton").show();
         
         //삭제
         $("#deleteButton").click(function() {
             if (confirm("정말 삭제하시겠습니까?")) {
                
            	  $("#schedule_code").val(eventData.schedule_code);

                 $.ajax({
                     url: "<%=request.getContextPath()%>/schedule/delete",
                     type: "POST",
                     data: { schedule_code: eventData.schedule_code },
                     success: function(response) {
                         alert("정상적으로 삭제되었습니다.");
                         location.reload();
                     },
                     error: function(error) {
                         alert("삭제 중에 오류가 발생했습니다.");
                     }
                 });
             }
         });
   		

         // Show the modal
         $("#calendarDetailModal").modal("show");
         
         //수정
	 $("#modifyButton").click(function() {
	  // Get the event data
	
	  // Set the values in the calendarModifyModal inputs
	  $("#schedule_title_modify").val(event.title);
	  $("#schedule_content_modify").val(eventData.content);
	  $("#schedule_start_modify").val(startFormatted);
	  $("#schedule_end_modify").val(endFormatted);
	  $("#schedule_code").val(eventData.schedule_code);
	  
	  // Get the schedule_code value
	  var schedule_code = $("#schedule_code").val();

            // Show the calendarModifyModal
            $("#calendarModifyModal").modal("show");
            
            $("#confirmModifyButton").click(function(e) {
            	e.stopPropagation()
                // Get the updated values from the calendarModifyModal inputs
                var title = $("#schedule_title_modify").val();
                var content = $("#schedule_content_modify").val();
                var start = $("#schedule_start_modify").val();
                var end = $("#schedule_end_modify").val();
                var scheduleCode = $("#schedule_code").val();
				
                
                // Construct the data object to be sent to the server
                var updatedData = {
                    title: title,
                    content: content,
                    start: start,
                    end: end,
                    schedule_code: scheduleCode
                };

                // Make an AJAX request to update the database
                $.ajax({
                    url: "/schedule/modify",
                    type: "POST",
                    data: JSON.stringify(updatedData),
                    contentType: "application/json",
                    success: function(response) {
                        alert("정상적으로 수정 되었습니다.");
                        location.reload();
                    },
                    error: function(error) {
                        // Handle the error response
                        console.error("Error updating event:", error);
                        // Display an error message
                        alert("수정에러/수정에러/수정에러");
                    }
                });

                // Hide the calendarModifyModal
                $("#calendarModifyModal").modal("hide");
            });
          });
       });
    
    calendar.render();
   

    $("#addCalendar").on("click", function() {
        var title = $("#schedule_title").val();
        var content = $("#schedule_content").val();
        var start = $("#schedule_start").val();
        var end = $("#schedule_end").val();
        var register = '${loginUser.member_id}';

        if (!title || title === "") {
            alert("제목을 입력하세요.");
        } else if (!start || !end) {
            alert("날짜를 입력하세요.");
        } else if (new Date(end) < new Date(start)) {
            alert("종료일이 시작일보다 빠릅니다.");
        } else {
            var regtime = new Date();

            // Perform validation checks on the server side
            $.ajax({
                url: '<%=request.getContextPath()%>/schedule/common/saveEvent',
                method: 'POST',
                data: {
                	title : title,
                	content : content,
                	start : start,
                	end : end,
                	register : register,
                	regtime : regtime
                },
                success: function(response) {
                    if (response === "success") {
                        // If the event is saved successfully, add it to the calendar
                        var eventData = {
                            title: content,
                            content : content,
                            start: reservation_start,
                            end: reservation_end,

                        };
                        calendar.addEvent(eventData);
                        $("#calendarModal").modal("hide");
                        // Reload the window
                    }
                    $("#calendarModal").modal("hide");
                },
                error: function(error) {
                    // Handle the error response
                    console.error("Error updating event:", error);
                    // Display an error message
                    alert("등록에러/등록에러/등록에러");
                    return false;
                }
            });
            window.location.reload();
        }
    });


    

    $(".room-button").click(function() {
      var room_code = $(this).data("room-code");
      showEvents(room_code);
    });
  });
  

</script>


  <%@include file="/WEB-INF/jsp/include/foot.jspf" %>