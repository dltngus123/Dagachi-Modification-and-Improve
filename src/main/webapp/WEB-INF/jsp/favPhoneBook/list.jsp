<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../include/head.jspf"%>
<script>
   window.onload=function(){
      bookMarkList();
      checkedBookMark("/dagachi/favPhoneBook/favList");
   }
   
</script>
 <div class="p-4 sm:ml-64">
   <div class="content-header">
  <h1>
   <a href='javascript:registBookMark("/dagachi/favPhoneBook/favList", "중요 연락처")'>
   <i class="fas fa-star bookmarkCheck"></i>
   </a>
      <span style="color: black;">
      중요 연락처
      </span>
   </h1>
   </div>
	<div class="col-12">
	  <div class="card">
	    <div class="card-header row">
	      <!-- <h3 class="card-title"></h3> -->
	      <div class="btns col-sm-6">
	      	<button type="button" class="btn bg-gradient" style="background: #5865F2; color:#ffffff;" onclick="removeChecked();">중요 주소록 해제</button>
	      </div>
	      <div class="card-tools col-sm-6">
	        <form action="showList" class="">
	        <div class="input-group input-group-sm ">
	          <select name="searchType">
	          	<option value="" disabled="disabled" selected="selected">검색구분</option>
	          	<option value="name" ${searchType eq 'name' ? 'selected':'' }>이름</option>
	          	<option value="dep" ${searchType eq 'dep' ? 'selected':'' }>부서</option>
	          	<option value="tag" ${searchType eq 'tag' ? 'selected':'' }>태그</option>
	          </select>
	          <input
	            type="text"
	            name="keyword"
	            class="form-control float-right"
	            placeholder="Search"
	            value="${keyword }"
	          />
	       
	          <div class="input-group-append">
	            <button type="button" class="btn btn-default" onclick="">
	              <i class="fas fa-search"></i>
	            </button>
	          </div>
	          <input type="hidden" name="phone_book_type" value="${param.phone_book_type }" />
	        </div>
	        </form>
	      </div>
	    </div> 
	
	    <div class="card-body table-responsive p-0">
	      <table class="table table-hover text-nowrap">
	        <thead>
	          <tr>
	          	<th><input type="checkbox" name="all" class="check-all"/></th>
	          	<th><i class="fas fa-star"></i></th>
	            <th>이름</th>
	           	<th>전화번호</th>
	           	<th>이메일</th>
	           	<th>회사</th>
	           	<th>태그</th>
	          </tr> 
	        </thead>
	        <tbody id="ListTable">
	        	<c:forEach var="sharePhone" items="${phoneBookList }">
	          <tr>
	           <td>
	           		<input type="checkbox" class="ab" value="${sharePhone.fav_Phone_Book_Id }"/>
	           </td>
	           
	           <td>
		           <a class="text-yellow" href="javascript:removeFavPhone('${sharePhone.fav_Phone_Book_Id }')">
			           <i class="fas fa-star "></i>
		           </a>
	           </td>
	           
	           <td>
	           	<a href="javascript:OpenWindow('detail?favId=${sharePhone.fav_Phone_Book_Id }','주소록 상세조회',800,800);">
	           		${sharePhone.phone_Book_Name }
	           	</a>
	           </td>
	           
	           <td>${sharePhone.phone_Book_Phone }</td>
	           
	           <td>${sharePhone.phone_Book_Email }</td>
	           
	           <td>${sharePhone.phone_Book_Company }</td>
	           
	           <td>
	           		<c:if test="${fn:contains(sharePhone.phone_Book_Tag,',') }">
		           		<c:forEach items="${fn:split(sharePhone.phone_Book_Tag, ',') }" var="tag">
		           			<a href="showList?searchType=tag&phone_book_type=${phoneBookType}&keyword=${tag }">
		           				${tag }
		           			</a>
		           		</c:forEach>
	           		</c:if>
	           		<c:if test="${not fn:contains(sharePhone.phone_Book_Tag,',') }">
		           			<a href="showList?searchType=tag&phone_book_type=${phoneBookType}&keyword=${sharePhone.phone_Book_Tag }">
		           				${sharePhone.phone_Book_Tag}
		           			</a>
	           		</c:if>
	           		
	           </td>
	          </tr>
	        </c:forEach>
	        </tbody>
	      </table>
	      
	    </div>
	  </div>
	</div>
	
   </div>

   
	<form name="removeCb" action="removeFavPhoneCb">
		<input type="hidden" name="checkedId" value=""/>
	</form>
	<%-- <form name="eliminateCb" action="eliminateCb">
		<input type="hidden" name="checked_EId" value=""/>
	</form> --%>
	
<%@include file="../include/foot.jspf"%>
<script>
function removeFavPhone(dex){
	//alert(dex);
	$.ajax({
		
		url:"removeFavPhone",
		type:"post",
		dataType:"text",
		data:{favId: dex
			  },
		traditional:true,
		success:function(data){
			$('#ListTable').html(data);
			
			},
		error:function(error){
			alert(error);
			console.log(error);
		}
	});
}
function removeChecked(){
	const arr=[]
	$('.ab').each(function (index) {
		if($(this).is(":checked")==true){
			//alert($(this).val());
			arr.push($(this).val());
			//alert(arr);
			
	    }
	});
	
	$.ajax({
		url:"removeCb",
		type:"post",
		dataType:"text",
		data:{
			favIdArr:arr
			},
		traditional:true,
		success:function(data){
			$('#ListTable').html(data);
		},
		error:function(error){
			alert(error);
		}
	});
}


function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
	winleft = (screen.width - WinWidth) / 2;
	wintop = (screen.height - WinHeight) / 2;
	var win = window.open(UrlStr , WinTitle , "scrollbars=yes,width="+ WinWidth+",height="+ WinHeight +",top="+wintop+",left="+ winleft +",resizable=yes" );
	win.focus();
}
//체크박스 전부 선택
$( document ).ready( function() {
	  $( '.check-all' ).click( function() {
	    $( '.ab' ).prop( 'checked', this.checked );
	  });
	});
	
	
function deleteChecked(){
	const arr=[]
	$('.ab').each(function (index) {
		if($(this).is(":checked")==true){
			//alert($(this).val());
			arr.push($(this).val());
			//alert(arr);
			$('input[name=checkedId]').val(arr);
			//alert($('input[name=checkedId]').val());
			if(!confirm("해당 정보를 삭제 하시겠습니까?")){
				
			}else{
				$('form[name=deleteCb]').submit();
				alert("해당 정보는 휴지통으로 이동되었으며 30일 경과 후 자동으로 삭제됩니다.");
			}
	    }
	});
	
}

function eliminateChecked(){
	const arr=[]
	$('.ab').each(function (index) {
		if($(this).is(":checked")==true){
			//alert($(this).val());
			arr.push($(this).val());
	    }
	});
	//alert(arr);
	$('input[name=checked_EId]').val(arr);
	//alert($('input[name=checkedId]').val());
	if(!confirm("해당 주소록을 삭제 시 영구히 삭제됩니다. 삭제 하시겠습니까?")){
		
	}else{
		$('form[name=eliminateCb]').submit();
		alert("선택하신 정보가 영구삭제 되었습니다.");
	}
} 
</script>