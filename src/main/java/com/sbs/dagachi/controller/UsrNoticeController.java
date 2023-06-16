package com.sbs.dagachi.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sbs.dagachi.service.ArticleService;
import com.sbs.dagachi.vo.Article;
import com.sbs.dagachi.vo.Member;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class UsrNoticeController {

	public ArticleService articleService;

	public UsrNoticeController(ArticleService articleService) {
		this.articleService = articleService;
		

	}

	@RequestMapping("/notice/noticeList")
	
	public String showBoard1(HttpSession session,Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "article_title,article_impotrent,article_register") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword){
		
		
		int articleCount = articleService.getArticleboardId1Count(searchKeywordTypeCode, searchKeyword);
		int itemsCountInAPage = 10;
		int pagesCount = (int) Math.ceil((double) articleCount / itemsCountInAPage);
		
		List<Article> borad1 = articleService.getBoardId1(searchKeywordTypeCode, searchKeyword, itemsCountInAPage, page);
		
		model.addAttribute("borad1",borad1);
		model.addAttribute("articleCount",articleCount);
		model.addAttribute("page",page);
		model.addAttribute("pagesCount",pagesCount);
		
		return "/notice/noticeList";
		
	
	}
	
	@RequestMapping("/notice/detail")
	public String showDetail(HttpSession session,Model model,@RequestParam("article_id") String article_id) {
		
		List<Article> board = articleService.getarticlebyarticleid(article_id);
		
		model.addAttribute("board",board);
		
		return "/notice/detail";
		
	}
	
	@GetMapping("/notice/download")
    public void downloadFile(@RequestParam("article_id") int articleId, HttpServletResponse response) {
        Article article = articleService.getArticleById(articleId);

        if (article == null || article.getArticle_attach() == null) {
            return;
        }

        String filePath = "c:/upload/file/" + article.getArticle_attach();

        Resource resource;
        try {
            resource = new UrlResource(new File(filePath).toURI());
        } catch (MalformedURLException e) {
            return;
        }

        if (resource.exists() && resource.isReadable()) {
            response.setContentType("application/octet-stream");
            response.setHeader(HttpHeaders.CONTENT_DISPOSITION,
                    "attachment; filename=\"" + resource.getFilename() + "\"");

            try (InputStream inputStream = resource.getInputStream();
                    OutputStream outputStream = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.flush();
            } catch (IOException e) {
                e.printStackTrace();
                return;
            }
        } else {
            return;
        }
    }
	
	@RequestMapping("/notice/domodify")
	public String showmodify(HttpSession session,Model model,@RequestParam("article_id") String article_id) {
		
		List<Article> board = articleService.getarticlebyarticleid(article_id);
		
		model.addAttribute("board",board);
		return "/notice/modifyFrom";
	}
	
	@RequestMapping(value = "/notice/modify", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String articleModify(HttpSession session,@RequestParam("article_title")String article_title,@RequestParam("article_body")String article_body,@RequestParam(value = "article_attach", required = false)String article_attach,@RequestParam("article_id")String article_id) {
		
		if (article_attach == "") {
			return article_attach = null;
		}
		
		articleService.articleModify(article_title, article_body, article_attach, article_id);
		
		System.out.println("##########"+article_title+article_body+article_id+article_attach);	
		
		return "/notice/noticeList";
	   
	}
	
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	@ResponseBody
	public String deleteArticle(@RequestParam("articleId") String articleId) {
	    articleService.articleDelete(articleId);
	    return "/notice/noticeList";
	}
	
	@RequestMapping("/notice/doinsert")
	public String insertArticle() {
		return "/notice/insert";
	}
	
	@RequestMapping(value = "/notice/insert", method = { RequestMethod.GET, RequestMethod.POST })
    public String insertArticle(HttpSession session,
            @RequestParam(value = "article_register", required = false) String articleRegister,
            @RequestParam(value = "article_title", required = false) String articleTitle,
            @RequestParam(value = "article_body", required = false) String articleBody,
            @RequestParam(value = "article_attach", required = false) MultipartFile articleAttach,
            @RequestParam(value = "article_important", required = false) String articleImportant) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        articleRegister = loginUser.getMember_id();

        // 파일 업로드
        String filename = null;
        String fileContent = null;
        String fileSize = null;
        String fileMimeType = null;
        if (articleAttach != null && !articleAttach.isEmpty()) {
            try {
                filename = articleAttach.getOriginalFilename();
                fileContent = new String(articleAttach.getBytes(), StandardCharsets.UTF_8);
                fileSize = String.valueOf(articleAttach.getSize());
                fileMimeType = articleAttach.getContentType();

                String fileUploadDir = "c:/upload/file/";

                try {

                    Path uploadPath = Paths.get(fileUploadDir);
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }

                    Path filePath = uploadPath.resolve(filename);

                    Files.copy(articleAttach.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                } catch (IOException e) {
                    e.printStackTrace();
                    
                }
            } catch (IOException e) {
                e.printStackTrace();
               
            }
        }

        articleService.articleInsert(articleRegister, articleTitle, articleBody, filename, articleImportant,
                fileSize, fileMimeType);

        return "redirect:/notice/noticeList";
    }





	

}
