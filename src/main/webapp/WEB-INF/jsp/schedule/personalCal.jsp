<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="캘린더" />
<%@page import="com.sbs.dagachi.vo.ScheduleVO"%>
<%@include file="../include/head.jspf"%>

  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- fullcalendar CDN -->
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js'></script>
  <!-- moment?쓰려고 가져옴 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
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
            url: '/getPersonalCalendar',
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
          url: '/getPersonalCalendar',
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
            $("#calendarModal").modal("show");
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
                url: '<%=request.getContextPath()%>/schedule/personal/saveEvent',
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

<script>
   window.onload=function(){
      bookMarkList();
      checkedBookMark("/schedule/personalCal");
   }
   
</script>

<div class="p-4 sm:ml-64">
<div>
<div class="content-header">
	    		<h1>
   <a href='javascript:registBookMark("/schedule/personalCal", "개인 일정")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      개인 일정
      </span>
   </h1>
</div>
</div>
  <div id="calendar" class="mx-auto" style="max-height: 600px; max-width:1000px;"></div>

<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <div class="form-group">
          <label for="schedule_title" class="col-form-label">일정 제목</label>
          <input type="text" class="form-control" id="schedule_title" name="schedule_title" >
          <label for="schedule_content" class="col-form-label float-left">일정 내용</label>
          <input type="text" class="form-control" id="schedule_content" name="schedule_content" >
          <label for="schedule_start" class="col-form-label">시작 시간 설정</label>
          <input type="datetime-local" class="form-control" id="schedule_start" name="schedule_start">
          <label for="schedule_end" class="col-form-label">종료 시간 설정</label>
          <input type="datetime-local" class="form-control" id="schedule_end" name="schedule_end">
          <input type="hidden" id="schedule_start" name="schedule_start">
          <input type="hidden" id="reservation_end" name="reservation_end">
          
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-warning" id="addCalendar">추가</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
      </div>
    </div>
  </div>
</div>

<!-- 상세  -->
<div class="modal fade" id="calendarDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 상세 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="schedule_title_detail" class="col-form-label">일정 제목</label>
          <input type="text" class="form-control" id="schedule_title_detail" name="schedule_title" readonly>
          <label for="schedule_content_detail" class="col-form-label float-left">일정 내용</label>
          <input type="text" class="form-control" id="schedule_content_detail" name="schedule_content" readonly>
          <label for="schedule_start_detail" class="col-form-label">시작 시간 설정</label>
          <input type="text" class="form-control" id="schedule_start_detail" name="schedule_start" readonly>
          <label for="schedule_end_detail" class="col-form-label">종료 시간 설정</label>
          <input type="text" class="form-control" id="schedule_end_detail" name="schedule_end" readonly>
          <input type="hidden" id="schedule_code" name="schedule_code"/>
        </div>
      </div>
      <div class="modal-footer">
         
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
          <button type="button" class="btn btn-warning" id="modifyButton" data-dismiss="modal">수정</button>
          <button type="button" class="btn btn-danger" id="deleteButton" data-dismiss="modal">삭제</button>

      </div>
    </div>
  </div>
</div>



<!-- 수정,삭제  -->
<div class="modal fade" id="calendarModifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 상세 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
        <label for="schedule_title_modify" class="col-form-label">일정 제목</label>
          <input type="text" class="form-control" id="schedule_title_modify" name="schedule_title" >
          <label for="schedule_content_modify" class="col-form-label float-left">일정 내용</label>
          <input type="text" class="form-control" id="schedule_content_modify" name="schedule_content" >
          <label for="schedule_start_modify" class="col-form-label">시작 시간 설정</label>
          <input type="datetime-local" class="form-control" id="schedule_start_modify" name="schedule_start">
          <label for="schedule_end_modify" class="col-form-label">종료 시간 설정</label>
          <input type="datetime-local" class="form-control" id="schedule_end_modify" name="schedule_end">
          <input type="hidden" id="schedule_code" name="schedule_code"/>

        </div>
      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-warning" id="confirmModifyButton" data-dismiss="modal">완료</button>
        <button type="button" class="btn btn-danger" id="deleteButton" data-dismiss="modal">취소</button>

      </div>
    </div>
  </div>
</div>
</div>




<%@include file="../include/foot.jspf"%>