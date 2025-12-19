package com.example.controller;

import com.example.model.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/forum-monitor")
public class ForumMonitorController {

    // Keep state in memory for the session
    private static List<Post> posts;

    // Initialize if empty using the mock data from Model
    private List<Post> getPosts() {
        if (posts == null) {
            posts = new ArrayList<>(Post.mockPosts());
        }
        return posts;
    }

    private Post findPost(int id) {
        return getPosts().stream().filter(p -> p.getId() == id).findFirst().orElse(null);
    }

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");
        String view = req.getParameter("view"); // e.g., "active" (default) or "archived" (hidden/removed)

        if (action != null && idParam != null) {
            int id = Integer.parseInt(idParam);
            Post post = findPost(id);

            if (post != null) {
                if ("warn".equals(action)) {
                    // Logic for warning (email etc would go here)
                    return new ModelAndView(
                            "redirect:forum-monitor?status=warned" + (view != null ? "&view=" + view : ""));
                } else if ("toggle".equals(action)) {
                    // Toggle between visible and hidden
                    if ("visible".equals(post.getStatus())) {
                        post.setStatus("hidden");
                    } else if ("hidden".equals(post.getStatus())) {
                        post.setStatus("visible");
                    }
                } else if ("remove".equals(action)) {
                    post.setStatus("removed");
                } else if ("restore".equals(action)) {
                    // Restore from removed/hidden back to visible
                    post.setStatus("visible");
                }
            }
            // Redirect to preserve the view state
            return new ModelAndView("redirect:forum-monitor" + (view != null ? "?view=" + view : ""));
        }

        // Filter posts based on view parameter
        List<Post> allPosts = getPosts();
        List<Post> filteredPosts = new ArrayList<>();

        if ("archived".equals(view)) {
            // Show hidden posts only (removed posts are strictly removed)
            // Show hidden AND removed posts
            for (Post p : allPosts) {
                if ("hidden".equals(p.getStatus()) || "removed".equals(p.getStatus())) {
                    filteredPosts.add(p);
                }
            }
        } else {
            // Default: Show visible posts (including reported ones if they are visible)
            for (Post p : allPosts) {
                if ("visible".equals(p.getStatus())) {
                    filteredPosts.add(p);
                }
            }
        }

        ModelAndView mv = new ModelAndView();
        mv.addObject("posts", filteredPosts);
        mv.addObject("currentView", view == null ? "active" : view);
        mv.setViewName("forum-monitor");
        return mv;
    }
}
