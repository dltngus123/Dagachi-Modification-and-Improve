<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>
<style>
#bar{
 width: 50px;

}
</style>
<script>
   window.onload=function(){
      bookMarkList();
      checkedBookMark("/reservation/list");
   }
   
</script>


<div class="p-4 sm:ml-64">

<div class="col-md-12">
<div class="content-header">
    		<h1>
   <a href='javascript:registBookMark("/reservation/list", "회의실 예약 메인")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      회의실 예약
      </span>
   </h1>
</div>
	</div>
		<c:if test="${loginUser.member_auth eq 2 or loginUser.member_auth eq 3}">
  <div id="btngroup" >
    <div class="insertbtn" style="margin: 10px;">
      <button type="button" style="background-color:#717cfa; height:40px;  border-radius:5px; border:0.3px solid;" data-toggle="modal" data-target="#insertroom">신규 회의실 등록</button>
    </div>
    <div class="modifybtn" style="margin: 10px;">
      <button type="button" style="background-color:#ffd865;height:40px; border-radius:5px; border:0.3px solid;" data-toggle="modal" data-target="#modifyroom">회의실 정보 수정</button>
    </div>
  </div>
</c:if>

<div class="col-md-12" style="item-align:end;">
 <div id="baritem" style="display:flex; justify-content:end; margin-top:20px;">
      <div id="bar"style="background-color: red; height: 25px; margin-right:5px;"></div>
      <div style="width:100px;">예약 불가</div>
      
      <div id="bar"style="background-color: green; height: 25px;margin-right:5px;"></div>
      <div style="width:100px;">나의 예약</div>
      </div>
</div>

<div class="container">
  <div class="" style="margin-top: 10px; display: flex;">
          
    <div style="flex-grow: 1; display: flex; flex-direction: column; align-items: center; width:200px;">
      <div style="flex-grow: 1;"></div>
      <c:forEach var="room" items="${room}">
        <button class="btn room-button bg-primary btn-default" style="font-size:0.8rem; height:40px; margin-top:5px; margin-right:20px;border-radius:5px; "data-room-code="${room.room_code}" onclick="showEvents('${room.room_code}')">${room.room_name}</button>
      </c:forEach>
      <div style="flex-grow: 1;"></div>
    </div>
    <div id="calendar" style="width: 1800px; "></div>
  
  </div>
</div>
  

	

</div>

  

<!-- modal 추가 -->

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
          <label for="calendar_user" class="col-form-label">사용자</label>
          <input type="text" class="form-control" id="calendar_user" name="reservation_member" value="${loginUser.member_id}">
          <label for="room_code" class="col-form-label">회의실 명</label>
          <select class="form-control" id="room_code" name="room_code">
            <c:forEach var="room" items="${room}">
              <option value="${room.room_code}">${room.room_name}</option>
            </c:forEach>
          </select>
          <label for="taskId" class="col-form-label">일정 사유</label>
          <input type="text" class="form-control" id="calendar_content" name="reservation_title">
          <label for="taskId" class="col-form-label">시작 날짜</label>
          <input type="datetime-local" class="form-control" id="reservation_start" name="reservation_start">
          <label for="taskId" class="col-form-label">종료 날짜</label>
          <input type="datetime-local" class="form-control" id="reservation_end" name="reservation_end">
         	<input type="hidden" id="reservation_start" name="reservation_start">
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
          <label for="calendar_user_detail" class="col-form-label">사용자</label>
          <input type="text" class="form-control" id="calendar_user_detail" name="reservation_member" readonly>
          <label for="room_name_detail" class="col-form-label">회의실 명</label>
          <input type="text" class="form-control" id="room_name_detail" name="room_name" readonly>
          <label for="calendar_content_detail" class="col-form-label">일정 사유</label>
          <input type="text" class="form-control" id="calendar_content_detail" name="reservation_title" readonly>
          <label for="reservation_start_modify" class="col-form-label">시작 날짜</label>
          <input type="text" class="form-control" id="reservation_start_detail" name="reservation_start" readonly>
          <label for="reservation_end_detail" class="col-form-label">종료 날짜</label>
          <input type="text" class="form-control" id="reservation_end_detail" name="reservation_end" readonly>
           <input type="hidden" id="reservation_code" name="reservation_code"value="">
        </div>
      </div>
      <div class="modal-footer">
      	
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	    <c:if test="${loginUser.member_id ne reservation_member }">
		    <button type="button" class="btn btn-warning" id="modifyButton" data-dismiss="modal">수정</button>
		    <button type="button" class="btn btn-danger" id="deleteButton" data-dismiss="modal">삭제</button>
	  </c:if>
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
          <label for="calendar_user_modify" class="col-form-label">사용자</label>
          <input type="text" class="form-control" id="calendar_user_modify" name="reservation_member" readonly>
          <label for="room_code_modify" class="col-form-label">회의실 명</label>
            <select class="form-control" id="room_code_modify" name="room_code" >
            <c:forEach var="room" items="${room}">
              <option value="${room.room_code}">${room.room_name}</option>
            </c:forEach>
          </select>
          <label for="calendar_content_modify" class="col-form-label">일정 사유</label>
          <input type="text" class="form-control" id="calendar_content_modify" name="reservation_title" value="">
           <label for="reservation_start_modify" class="col-form-label">시작 날짜</label>
          <input type="datetime-local" class="form-control" id="reservation_start_modify" name="reservation_start"value="">
          <label for="reservation_end_modify" class="col-form-label">종료 날짜</label>
          <input type="datetime-local" class="form-control" id="reservation_end_modify" name="reservation_end"value="">
          <input type="hidden" id="reservation_code" name="reservation_code"value="">
        </div>
      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-warning" id="confirmModifyButton" data-dismiss="modal">수정</button>

      </div>
    </div>
  </div>
</div>



<!-- 신규회의실생성 -->
<div class="modal fade" id="insertroom" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
  <div class="card card-primary card-outline direct-chat direct-chat-primary" style="maring-top:10px;">
    <div class="card-header">
      <h3 class="card-title">신규 회의실 생성</h3>
      <div class="card-tools">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
		</div>
		</div>
		<div class="card-body">
			<div class="direct-chat-messages">
				<div class="direct-chat-msg">
					<div class="direct-chat-infos clearfix"></div>
					<form method="POST" action="../reservation/insert" id="room-form">
						<div style="display: flex; justify-content: center; align-items: center; margin-top: 50px;">
							<input type="hidden" name="room_code" />
							<label for="room_name" style="margin-right: 10px;">회의실 이름:</label>
							<input type="text" id="room_name" name="room_name" placeholder="회의실 이름을 입력하세요">
						</div>
							<div style="display: flex; justify-content: flex-end; margin-top: 100px;">
								<input type="submit" class="btn btn-primary"style="background-color: #5865F2; color: white; border: none;" value="등록" />
							</div>
					</form>
				</div>
	</div>
</div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>



<div class="modal fade" id="modifyroom" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <h3 class="card-title">회의실 정보 수정</h3>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <br/>
        <hr/>
          <input type="hidden" name="room_code" id="selectedRoomCode" style="margin-top:15px;">
          <label for="room_code" class="col-form-label">회의실을 선택하세요</label>
          <select class="form-control" id="roomCodeSelect" name="room_code">
            <c:forEach var="room" items="${room}">
              <option value="${room.room_code}">${room.room_name}</option>
            </c:forEach>
          </select>
          <br/>
          <label for="room_name" class="col-form-label">변경할 회의실 명을 입력하세요:</label>
          <input type="text" name="room_name" id="roomNameInput">
      </div>
      <div style="text-align:center;">*삭제시 회의실을 선택후 삭제 버튼을 눌려주세요.*</div>
      <div class="modal-footer">
		<script>
		  function submitRoomChanges() {
		    var roomCode = document.getElementById("roomCodeSelect").value;
		    var roomName = document.getElementById("roomNameInput").value;
		
		    $.ajax({
		      url: "/reservation/roommodify",
		      method: "POST",
		      data: {
		        room_code: roomCode,
		        room_name: roomName
		      },
		      success: function(response) {
		       alert("정상적으로 수정이 되었습니다.");
		       location.reload();
		      },
		      error: function(error) {
		       alert("수정중 오류가 발생했습니다. 다시 시도해 주세요.");
		      }
		    });
		  }
		</script>
		<button type="button" class="btn btn-warning" data-dismiss="modal" onclick="submitRoomChanges()">수정</button>
		<script>
		  function confirmDelete() {
		    if (confirm("정말 삭제하시겠습니까?")) {
		      var roomCode = document.getElementById("roomCodeSelect").value;
		
		      $.ajax({
		        url: "/reservation/roomdelete",
		        method: "POST",
		        data: {
		          room_code: roomCode
		        },
		        success: function(response) {
		          alert("삭제가 완료 되었습니다.");
		          location.reload(); 
		        },
		        error: function(error) {
		          alert("삭제중 오류가 발생했습니다. 다시 시도해 주세요.");
		        }
		      });
		    }
		  }
		</script>
		<button type="button" class="btn btn-danger" id="deleteButton" data-dismiss="modal" onclick="confirmDelete()">삭제</button>
      </div>
    </div>
  </div>
</div>



<script>

    document.querySelector('#room-form').addEventListener('submit', function(e) {
        e.preventDefault(); 
        fetch('../reservation/insert', {
            method: 'POST',
            body: new FormData(document.querySelector('#room-form'))
        }).then(function(response) {
            if (response.ok) {
                window.close();
                location.reload();
            } else {
            	window.close();
            	location.reload();
            }
        }).catch(function(error) {
            alert('등록 중 오류가 발생했습니다.');
		    location.reload();
        });
    });
    
</script>




<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	  initialView: 'dayGridMonth',
          headerToolbar: {
              left: 'prev,next addEventButton addAllselect',
              center: 'title',
              right: 'dayGridMonth,timeGridWeek,timeGridDay'
          },
          slotMinTime: '08:00',
          slotMaxTime: '22:00',
          navLinks: true,
          selectable: true,
          nowIndicator: true,
          dayMaxEvents: true,
          locale: 'ko',
          selectMirror: true,
      select: function(arg) {
        var title = prompt('Event Title:');
        if (title) {
          var room_code = $("#room_code").val();
          var reservation_start = arg.startStr;
          var reservation_end = arg.endStr;
          var reservation_code = prompt('Reservation Code:');

       
          $.ajax({
            url: '/reservation/getCalendar',
            method: 'GET',
            data: {
              room_code: room_code,
              title: title,
              reservation_start: reservation_start,
              reservation_end: reservation_end,
              reservation_code: reservation_code
            },
            success: function(response) {
           
              var eventData = JSON.parse(response);
              var loginUser = ${loginUser.member_id}
              
              if (eventData.reservation_member === loginUser) {
                  eventData.backgroundColor = 'green';
                  eventData.color='green';
                  eventData.textColor = 'black';
                } else {
                  eventData.backgroundColor = 'red';
                  eventData.color='red';
                  eventData.textColor = 'black';
                }

                return eventData;

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
          url: '/reservation/getCalendar',
          method: 'GET',
          dataType: 'json',
          success: function(data) {
            var loginUser = '${loginUser.member_id}';
            var events = data.map(function(event) {
              var eventData = {
                title: event.title,
                start: event.start,
                end: event.end,
                room_code: event.room_code,
                reservation_member: event.member,
                reservation_code: event.reservation_code
                
              };
              
              if (eventData.reservation_member === loginUser) {
                  eventData.backgroundColor = '#39D039';
                  eventData.color='#39D039';
                  eventData.textColor = 'white';
                } else {
                  eventData.backgroundColor = '#f44336';
                  eventData.color='#f44336';
                  eventData.textColor = 'white';
                }

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
          text: '예약 하기',
          click: function() {
            $("#calendarModal").modal("show");
          }
        },
        addAllselect: { 
          text: '전체보기',
          click: function() {
            location.reload();
          }
        }
      },
 
    });
    calendar.on('eventClick', function(info) {
    	  
    	  var event = info.event;
    	  var eventData = event.extendedProps;

    	  var startFormatted = moment(event.start).format('YYYY-MM-DD HH:mm');
    	  var endFormatted = moment(event.end).format('YYYY-MM-DD HH:mm');

    
    	  $("#calendar_user_detail").val(eventData.reservation_member);
    	  $("#room_name_detail").val(eventData.room_code);
    	  $("#calendar_content_detail").val(event.title);
    	  $("#reservation_start_detail").val(startFormatted);
    	  $("#reservation_end_detail").val(endFormatted);
    	  $("#reservation_code").val(eventData.reservation_code);


    	
    	  var loginUser = "${loginUser.member_id}";
    	  var reservationMember = $("#calendar_user_detail").val();

    	  if (loginUser === reservationMember) {
    		    $("#modifyButton").show();
    		    $("#deleteButton").show();
    		  } else {
    		    $("#modifyButton").hide();
    		    $("#deleteButton").hide();
    		  }

    	
    	  $("#calendarDetailModal").modal("show");
    	  
    	  $("#deleteButton").click(function() {
    		    if (confirm("정말 삭제하시겠습니까?")) {
    		       
    		        var reservation_code = $("#reservation_code").val();

    		        $.ajax({
    		            url: "<%=request.getContextPath()%>/reservation/delete",
    		            type: "POST",
    		            data: { reservation_code: reservation_code },
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
    	  
    	  $("#modifyButton").click(function() {
    		   
    		    $("#calendar_user_modify").val(eventData.reservation_member);
    		    $("#room_code_modify").val(eventData.room_code);
    		    $("#calendar_content_modify").val(event.title);
    		    $("#reservation_start_modify").val(startFormatted);
    		    $("#reservation_end_modify").val(endFormatted);
    		    $("#reservation_code").val(eventData.reservation_code);

    		  
    		    $("#calendarModifyModal").modal("show");
    		});

    	  $("#confirmModifyButton").click(function() {
    		    var reservationMember = $("#calendar_user_modify").val();
    		    var roomCode = $("#room_code_modify").val();
    		    var reservationTitle = $("#calendar_content_modify").val();
    		    var reservationStart = $("#reservation_start_modify").val();
    		    var reservationEnd = $("#reservation_end_modify").val();
    		    var reservationCode = $("#reservation_code").val();

    		    var updatedData = {
    		        reservation_member: reservationMember,
    		        room_code: roomCode,
    		        reservation_start: reservationStart,
    		        reservation_end: reservationEnd,
    		        reservation_title: reservationTitle,
    		        reservation_code: reservationCode
    		    };

    		    $.ajax({
    		        url: "<%=request.getContextPath()%>/reservation/modify",
    		        type: "POST",
    		        data: JSON.stringify(updatedData),
    		        contentType: "application/json",
    		        success: function(response) {
    		            if (response === "success") {
    		                var eventData = {
    		                    title: reservationTitle,
    		                    start: reservationStart,
    		                    end: reservationEnd
    		                };
    		                calendar.addEvent(eventData);
    		                alert("정상적으로 수정 되었습니다.")
    		                $("#calendarModifyModal").modal("hide");
    		                location.reload();
    		            } else if (response === "isOverlappingEventserror") {
    		                alert("해당 회의실은 이미 예약된 시간과 겹칩니다. 다시 선택해주세요.");
    		                $("#calendarModifyModal").modal("show");
    		            } else if (response === "isOverlappingEventserror") {
    		                alert("해당 회의실에는 이미 예약된 사람이 있습니다. 다시 선택해주세요.");
    		                $("#calendarModifyModal").modal("show");
    		            } else {
    		                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
    		                $("#calendarModifyModal").modal("hide");
    		                location.reload();
    		            }
    		        },
    		        error: function(xhr, textStatus, errorThrown) {
    		            if (xhr.status !== 200) {
    		                alert("해당 회의실은 이미 예약된 시간과 겹치거나 이미 예약된 정보가 있습니다. 다시 선택해주세요.");
    		            }
    		        }
    		    });
    		});



    	});

    calendar.render();
   

    $("#addCalendar").on("click", function() {
        var user = $("#calendar_user").val();
        var room_code = $("#room_code").val();
        var content = $("#calendar_content").val();
        var reservation_start = $("#reservation_start").val();
        var reservation_end = $("#reservation_end").val();

        if (!content || content === "") {
            alert("내용을 입력하세요.");
        } else if (!reservation_start || !reservation_end) {
            alert("날짜를 입력하세요.");
        } else if (new Date(reservation_end) < new Date(reservation_start)) {
            alert("종료일이 시작일보다 빠릅니다.");
        } else {
            var regtime = new Date();

           
            $.ajax({
                url: '<%=request.getContextPath()%>/reservation/saveEvent',
                method: 'POST',
                data: {
                    user: user,
                    room_code: room_code,
                    title: content,
                    reservation_start: reservation_start,
                    reservation_end: reservation_end,
                    reservation_regtime: regtime
                },
                success: function(response) {
                    if (response === "success") {
                       
                        var eventData = {
                            title: content,
                            start: reservation_start,
                            end: reservation_end
                        };
                        calendar.addEvent(eventData);
                        $("#calendarModal").modal("hide"); 
                        location.reload();
                    } else if (response === "isOverlappingEventserror") {
                        alert("해당 회의실은 이미 예약된 시간과 겹칩니다. 다시 선택해주세요.");
                        
                    } else if (response === "hasExistingReservationserror") {
                        alert("해당 회의실에는 이미 예약된 사람이 있습니다. 다시 선택해주세요.");
                    } else {
                      
                    }
                    $("#calendarModal").modal("hide");
                    location.reload();
                   
                },
                error: function(xhr, textStatus, errorThrown) {
                    if (xhr.status !== 200) {
                        alert("해당 회의실은 이미 예약된 시간과 겹치거나 이미 예약된 정보가 있습니다. 다시 선택해주세요.");
                    }
                }
              
                   
            });
        }
    });


    function showEvents(room_code) {
      $.ajax({
        url: '/reservation/getCalendar',
        method: 'GET',
        data: {
          searchKeywordTypeCode: 'room_code',
          searchKeyword: room_code
        },
        success: function(data) {
          var loginUser = '${loginUser.member_id}';
          var events = data.map(function(event) {
            var eventData = {
              title: event.title,
              start: event.start,
              end: event.end,
              room_code: event.room_code,
              reservation_member: event.member
            };
            if (eventData.reservation_member === loginUser) {
                eventData.backgroundColor = '#39D039';
                eventData.color='#39D039';
                eventData.textColor = 'white';
              } else {
                eventData.backgroundColor = '#f44336';
                eventData.color='#f44336';
                eventData.textColor = 'white';
              }

            return eventData;
          });

          calendar.removeAllEvents();
          calendar.addEventSource(events);
        },
        error: function() {
          alert('서버에서 이벤트를 불러오는 데 실패했습니다.');
        }
      });
    }

    $(".room-button").click(function() {
      var room_code = $(this).data("room-code");
      showEvents(room_code);
    });
  });
  

</script>







<%@include file="/WEB-INF/jsp/include/foot.jspf" %>