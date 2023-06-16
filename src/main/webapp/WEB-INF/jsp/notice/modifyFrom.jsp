<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/jsp/include/head.jspf" %>
<link href="/resource/bootstrap/plugins/summernote/summernote-bs4.min.css" rel="stylesheet"/>
<input type="hidden" name="article_id">
<div class="p-4 sm:ml-64">
    <div class="col-md-12" style="text-align:right; margin-top:15px; margin-bottom:15px;">
        <button class="btn btn-sidebar bg-gray-300" style="width: 100px; "><a href="/notice/noticeList">목록</a></button>
    </div>
    <div class="col-md-12" style="text-align:center;">
        <table class="table w-full">
            <thead>
                <c:forEach var="article" items="${board}">
                    <tr>
                        <th class="font-bold text-lg text-black">공지사항 제목</th>
						<td style="background-color:white;"><input type="text" id="article_title" name="article_title" class="input" value="${article.article_title}"></td>
                    </tr>
                    <tr>
                        <th class="font-bold text-lg text-black">작성자</th>
                        <td class="input" style="background-color:white;">${article.member_name }(${article.member_rank })/${article.member_department1 }&nbsp;&nbsp;${article.member_team1 }</td>
                    </tr>
                    <tr>
                        <th class="font-bold text-lg text-black">등록일</th>
                        <td  class="input" style="background-color:white;">${article.article_regdate.substring(0, 11) }</td>
                    </tr>
                </c:forEach>
            </thead>
        </table>
        
        <div class="contentbox">
            <c:forEach var="article" items="${board}">
                <table class="table w-full">
                    <tr>
                        <th style="text-align: start;">첨부파일</th>
                        <td style="text-align: start;">
                            <c:if test="${article.article_attach != null }">
                                <a class="border border-current p-2"> 💾${article.article_attach}<button class="btn btn-sm bg-red-400 ml-2" onclick="removeAttachment(event)">x</button></a>
                            </c:if>
                            <c:if test="${article.article_attach == null }">
                                <a style="display:none;"class="border border-current p-2"> ${article.article_attach}<button style="display:none;"class="btn btn-sm bg-red-400 ml-2" onclick="removeAttachment(event)">x</button></a>
                            </c:if>
                        </td>
                    </tr>
                </table>

                <div id="article_body_original" style="display: none;">${article.article_body}</div>
                <textarea class="content summernote" style="display: none;" name="article_body" id="article_body">${article.article_body}</textarea>

                <c:if test="${loginUser.member_id eq article.article_register}">
                    <span style="float: right;">
                        <div style="display:none">
                            <input type="hidden" id="article_id" name="article_id" value="${article.article_id}">
                            <input type="hidden" id="article_attach" name="article_attach" value="${article.article_attach}">
                            <input type="hidden" id="article_body_original" name="article_body_original" value="${article.article_body}">
                            <input type="hidden" id="article_title_original" name="article_title_original" value="${article.article_title}">
                        </div>
                        <button onclick="modify();" class="btn btn-sidebar bg-blue-300" style="width: 100px;">수정</button>
                        <button onclick="history_back();" class="btn btn-sidebar bg-red-500" style="width: 100px;">취소</button>
                        <script>
                            function history_back() {
                                history.back();
                            }
                        </script>
                    </span>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>

<script>
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
            url: "/notice/modify",
            data: {
                article_title: articleTitle,
                article_body: articleBody,
                article_attach: articleAttach,
                article_id: articleId
            },
            success: function (response) {
                if (articleAttach === "") {
                    articleAttach = null;
                }
                window.location.href = "/notice/noticeList";
            }
        });
    }

    window.addEventListener('load', function () {
        summernote_go($('.content'), '<%=request.getContextPath()%>');
        $('.note-toolbar').addClass('hidden');
    });

   

    function removeAttachment(event) {
        var attachmentElement = event.target.parentElement;
        attachmentElement.remove();

        
        document.getElementById("article_attach").value = "";

      
        document.getElementById("article_attach").setAttribute("value", "");
    }
</script>

<%@include file="/WEB-INF/jsp/include/foot.jspf" %>
