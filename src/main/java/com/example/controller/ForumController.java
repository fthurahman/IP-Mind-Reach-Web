package com.example.controller;

import com.example.model.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/forum")
public class ForumController {

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {

        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        if ("GET".equals(req.getMethod())) {
            if ("detail".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                Post post = Post.findById(id);
                if (post != null) {
                    ModelAndView mv = new ModelAndView();
                    mv.addObject("post", post);
                    mv.setViewName("forum-detail");
                    return mv;
                }
            }
            if ("report".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                Post post = Post.findById(id);
                String resultStatus = "reported";
                if (post != null) {
                    boolean isAlreadyReported = post.isReported();
                    post.setReported(!isAlreadyReported);
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
                List<Post> allPosts = Post.mockPosts();
                List<Post> filtered = allPosts;
                if (q != null && !q.trim().isEmpty()) {
                    filtered = allPosts.stream()
                            .filter(p -> p.getContent().toLowerCase().contains(q.toLowerCase()) ||
                                    p.getAuthor().toLowerCase().contains(q.toLowerCase()) ||
                                    p.getTopic().toLowerCase().contains(q.toLowerCase()))
                            .collect(Collectors.toList());
                }
                ModelAndView mv = new ModelAndView();
                mv.addObject("posts", filtered);
                mv.setViewName("forum");
                return mv;
            }
            // Default: list posts
            ModelAndView mv = new ModelAndView();
            mv.addObject("posts", Post.mockPosts());
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
                    newPost.setId(Post.mockPosts().size() + 1);
                    newPost.setAuthor(author.trim());
                    newPost.setTopic(topic.trim());
                    newPost.setContent(content.trim());
                    newPost.setStatus("active");
                    newPost.setReported(false);
                    newPost.setCreatedAt("2025-12-18");
                    newPost.setComments(new ArrayList<>());
                    Post.mockPosts().add(newPost);
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
            int id = Integer.parseInt(req.getParameter("id"));
            String reply = req.getParameter("reply");
            Post post = Post.findById(id);
            if (post != null && reply != null && !reply.trim().isEmpty()) {
                post.addComment("Anonymous", reply.trim());
            }
            // Redirect to detail
            try {
                res.sendRedirect(req.getContextPath() + "/forum?action=detail&id=" + id + "&status=commented");
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // Default
        ModelAndView mv = new ModelAndView();
        mv.addObject("posts", Post.mockPosts());
        mv.setViewName("forum");
        return mv;
    }
}
