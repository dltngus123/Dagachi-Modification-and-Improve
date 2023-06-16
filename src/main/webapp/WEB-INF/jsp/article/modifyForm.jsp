<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>
<link href="/resource/bootstrap/plugins/summernote/summernote-bs4.min.css" rel="stylesheet"/>
<input type="hidden" name="article_id">
<div class="p-4 sm:ml-64">
    <div class="col-md-12" style="text-align:right; margin-top:15px; margin-bottom:15px;">
         <button class="btn btn-sidebar bg-gray-300" style="width: 100px; "><a href="/article/list">목록</a></button>
    </div>
    <div class="col-md-12" style="text-align:center;">
        <table class="table w-full">
            <thead>
                <c:forEach var="article" items="${board}">
                    <tr>
                        <th class="font-bold text-lg text-black"> 제목</th>
                         <div id="article_title_original" style="display: none;">${article.article_title}</div>
                  <td style="background-color:white;"><input class="input" type="text" id="article_title" name="article_title" value="${article.article_title}"></td>
                    </tr>
                    <tr>
                        <th class="font-bold text-lg text-black">작성자</th>
                        <td class="input" style="background-color:white;">${article.member_name }</td>
                    </tr>
                    <tr>
                        <th class="font-bold text-lg text-black">등록일</th>
                        <td class="input" style="background-color:white;">${article.article_regdate.substring(0, 11) }</td>
                    </tr>
                </c:forEach>
            </thead>
        </table>

        <div class="contentbox">
            <c:forEach var="article" items="${board}">
                <div id="article_body_original" style="display: none;">${article.article_body}</div>
                <table class="table w-full">
                    <tr>
                        <th style="text-align: start;">첨부파일</th>
                        <td style="text-align: start;">
                            <a class="border border-current p-2" href="${article.article_attach}" download>💾${article.article_attach}</a>
                        </td>
                    </tr>
                </table>
                <textarea class="content summernote" name="article_body" id="article_body">${article.article_body}</textarea>

              
                    <span style="float: right;">
                        <input type="hidden" id="article_id" name="article_id" value="${article.article_id}">
                        <input type="hidden" id="article_attach" name="article_attach" value="${article.article_attach}">
                        <input type="hidden" id="article_body_original" name="article_body_original" value="${article.article_body}">

                        <button onclick="modify();" class="btn btn-sidebar bg-blue-300" style=" width: 100px;">수정</button>
                        <button onclick="history.back();" class="btn btn-sidebar bg-red-500" style="width: 100px;">취소</button>

                   
                    </span>
                
            </c:forEach>
        </div>

    </div>
</div>

<script>
   /*  $(document).ready(function () {
        $('.summernote').summernote({
            height: 500
        });
    }); */
    window.addEventListener('load', function () {
        summernote_go($('.content'), '<%=request.getContextPath()%>');
        $('.note-toolbar').addClass('hidden');
    });

    
    function modify() {
        
        var articleTitle = document.getElementById("article_title").value;
        var articleBody = $('.summernote').summernote('code');
        var articleAttach = document.getElementById("article_attach").value;
        var articleId = document.getElementById("article_id").value;
      
        var articleTitleOriginal = document.getElementById("article_title_original").value;
        var articleBodyOriginal = document.getElementById("article_body_original").innerText;
        var hasChanged = (articleTitle !== articleTitleOriginal) || (articleBody !== articleBodyOriginal);
       
        if (!hasChanged) {
            alert("변경된 내용이 없습니다.");
            return;
        }
        
        if (articleAttach === "") {
            articleAttach = null;
        }
        
        $.ajax({
            type: "POST",
            url: "/article/modify",
            data: {
                article_title: articleTitle,
                article_body: articleBody,
                article_attach: articleAttach,
                article_id: articleId
            },
            success: function (response) {
               
                window.location.href = "/article/detail?article_id=${param.article_id}";
            }
        });
    }
</script>

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>