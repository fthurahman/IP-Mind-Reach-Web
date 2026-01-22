package com.example.controller;

import com.example.model.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/forum")
public class ForumController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.example.model.AnalyticsDAO analyticsDAO;

    @org.springframework.beans.factory.annotation.Autowired
    private com.example.model.ForumDAO forumDAO;

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res,
            java.security.Principal principal) {

        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        // LOGGING: Forum module usage
        if ("GET".equals(req.getMethod())) {
            if (analyticsDAO != null && principal != null) {
                analyticsDAO.logActivityProgress("Forum", principal.getName());
            }
        }

        if ("GET".equals(req.getMethod())) {
            if ("detail".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                Post post = forumDAO.getPostById(id);
                if (post != null) {
                    ModelAndView mv = new ModelAndView();
                    mv.addObject("post", post);
                    mv.setViewName("forum-detail");
                    return mv;
                }
            }
            if ("report".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                Post post = forumDAO.getPostById(id);
                String resultStatus = "reported";
                if (post != null) {
                    boolean isAlreadyReported = post.isReported();
                    // Toggle report status
                    String reportedBy = (principal != null) ? principal.getName() : "Anonymous";
                    forumDAO.updatePostReportStatus(id, !isAlreadyReported, reportedBy);
                    if (isAlreadyReported) {
                        resultStatus = "unreported";
                    }
                }

                // Redirect back to either the list or detail view with status
                String contextPath = req.getContextPath();
                String referer = req.getHeader("Referer");
                try {
                    if (referer != null && referer.contains("action=detail")) {
                        res.sendRedirect(contextPath + "/forum?action=detail&id=" + id + "&status=" + resultStatus);
                    } else {
                        res.sendRedirect(contextPath + "/forum?status=" + resultStatus);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
            if ("new".equals(action)) {
                ModelAndView mv = new ModelAndView();
                mv.setViewName("forum-create");
                return mv;
            }
            if ("search".equals(action)) {
                String q = req.getParameter("q");
                List<Post> filtered;
                if (q != null && !q.trim().isEmpty()) {
                    filtered = forumDAO.searchPosts(q.trim());
                } else {
                    filtered = forumDAO.getAllPosts();
                }
                ModelAndView mv = new ModelAndView();
                mv.addObject("posts", filtered);
                mv.setViewName("forum");
                return mv;
            }
            // Default: list posts
            ModelAndView mv = new ModelAndView();
            mv.addObject("posts", forumDAO.getAllPosts());
            mv.setViewName("forum");
            return mv;
        } else if ("POST".equals(req.getMethod())) {
            if ("create".equals(action)) {
                String author = req.getParameter("author");
                String topic = req.getParameter("topic");
                String content = req.getParameter("content");
                if (author != null && topic != null && content != null &&
                        !author.trim().isEmpty() && !topic.trim().isEmpty() && !content.trim().isEmpty()) {
                    Post newPost = new Post();
                    newPost.setAuthor(author.trim());
                    newPost.setTopic(topic.trim());
                    newPost.setContent(content.trim());
                    newPost.setStatus("active");
                    newPost.setReported(false);
                    // Date set in DAO (NOW())

                    forumDAO.createPost(newPost);

                    // NEW: Update Activity Progress
                    if (analyticsDAO != null && principal != null) {
                        analyticsDAO.updateForumActivityProgress(principal.getName());
                    }
                }
                // Redirect to forum
                try {
                    res.sendRedirect(req.getContextPath() + "/forum?status=created");
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
            // Add comment
            String idStr = req.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                String reply = req.getParameter("reply");
                if (reply != null && !reply.trim().isEmpty()) {
                    com.example.model.Comment c = new com.example.model.Comment();
                    c.setAuthor("Anonymous");
                    c.setContent(reply.trim());
                    forumDAO.addComment(id, c);

                    // NEW: Update Activity Progress
                    if (analyticsDAO != null && principal != null) {
                        analyticsDAO.updateForumActivityProgress(principal.getName());
                    }
                }
                // Redirect to detail
                try {
                    res.sendRedirect(req.getContextPath() + "/forum?action=detail&id=" + id + "&status=commented");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                // Fallback if no ID
                try {
                    res.sendRedirect(req.getContextPath() + "/forum");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return null;
        }

        // Default
        ModelAndView mv = new ModelAndView();
        mv.addObject("posts", forumDAO.getAllPosts());
        mv.setViewName("forum");
        return mv;
    }
}
