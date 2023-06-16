//팝업창들 띄우기
//새로운 Window창을 Open할 경우 사용되는 함수 ( arg : 주소, 창타이틀, 넓이 , 길이)
function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
   winleft = (screen.width - WinWidth) / 2;
   wintop = (screen.height - WinHeight) / 2;
   var win = window.open(UrlStr , WinTitle , "scrollbars=yes,width="+ WinWidth+",height="+ WinHeight +",top="+wintop+",left="+ winleft +",resizable=yes" );
   win.focus();
}

function CloseWindow(){
   window.opener.location.reload(true);
   window.close();
}

function list_go(page,url){
   
   if(!url) url="list.do";
   
   $("form#jobForm input[name='page']").val(page);
   $("form#jobForm input[name='perPageNum']").val($('select[name=perPageNum]').val());
   $("form#jobForm input[name='searchType']").val($('select[name=searchType]').val());
   $("form#jobForm input[name='keyword']").val($('div.input-group>input[name=keyword]').val());
   $('form#jobForm').attr({
      action:url,
      method:'get'
   }).submit();
}

function summernote_go(target,context){
      contextPath=context;
      
      target.summernote({
         placeholder:'여기에 내용을 적으세요.',
         lang:'ko-KR',
         height:600,
         dsableResizeEditor: true,
         callbacks:{
            onImageUpload: function(files, editor, welEditalbe){
               for(var file of files){
                  if(file.name.substring(file.name.lastIndexOf(".")+1).toUpperCase() != "JPG"){
                     alert("JPG 이미지 형식만 가능합니다.");
                     return;
                  }
                  if(file.size > 1024*1024*1){
                     alert("이미지는 1MB 미만입니다.");
                     return;
                  }
               }
               
               for (var file of files) {
                  sendFile(file,this);
               }
            },
            onMediaDelete : function(target) {

               deleteFile(target[0].src);
            }
         }
      });
   }

function WirteImgThumb(contextPath){
      for(var target of document.querySelectorAll('.writeImg')){
         var writing_num = target.getAttribute('data-id');
         target.style.backgroundImage="url('"+contextPath+"/writer/write/getimg.do?writing_num="+writing_num+"')";
         target.style.backgroundPosition="center";
         target.style.backgroundRepeat="no-repeat";
         target.style.backgroundSize="cover";
      }
      
    }

function MemberPictureThumb(contextPath){
    for(var target of document.querySelectorAll('.manPicture')){   
       var id = target.getAttribute('data-id');
       
      target.style.backgroundImage="url('"+contextPath+"/getPicture?id="+id+"')";            
      target.style.backgroundPosition="center";
      target.style.backgroundRepeat="no-repeat";
      target.style.backgroundSize="contain";
    }
}
function bookMarkList(){
            $.ajax({
               url:'/usr/home/favList',
               dataType:'text',
               data:'',
               traditional: true,
               success: function(data){
                  $('.favList').html(data);
               }
            
            });
        }
function checkedBookMark(murl){
   $.ajax({
      url: '/usr/home/dupCheck',
      dataType: 'text',
      data:{
         mcode:murl
      },
      traditional: true,
      success:function(data){
        if(data=='no'){
            $('.bookmarkCheck').addClass('text-yellow-300');
         }
      }
   });
}
function registBookMark(murl,pagename){
   $.ajax({
      url:'/usr/home/registFav',
      dataType:'text',
      data: {
         mcode: murl,
         pageTitle: pagename
      },
      traditional: true,
      success: function(data){
         if(data=="ok"){
            $('.bookmarkCheck').addClass('text-yellow-300');
            bookMarkList();
         }else{
            $('.bookmarkCheck').removeClass('text-yellow-300');
            bookMarkList();
         }
      }
   });
}




   