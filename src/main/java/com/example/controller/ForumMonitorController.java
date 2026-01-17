package com.example.controller;

import com.example.model.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/forum-monitor")
public class ForumMonitorController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.example.model.ForumDAO forumDAO;

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");
        String view = req.getParameter("view"); // e.g., "active" (default) or "archived" (hidden/removed)

        if (action != null && idParam != null) {
            int id = Integer.parseInt(idParam);
            Post post = forumDAO.getPostById(id);

            if (post != null) {
                if ("warn".equals(action)) {
                    // Logic for warning (email etc would go here)
                    return new ModelAndView(
                            "redirect:forum-monitor?status=warned" + (view != null ? "&view=" + view : ""));
                } else if ("toggle".equals(action)) {
                    // Toggle between visible and hidden
                    if ("visible".equals(post.getStatus())) {
                        forumDAO.updatePostStatus(id, "hidden");
                    } else if ("hidden".equals(post.getStatus())) {
                        forumDAO.updatePostStatus(id, "visible");
                    }
                } else if ("remove".equals(action)) {
                    forumDAO.updatePostStatus(id, "removed");
                } else if ("restore".equals(action)) {
                    // Restore from removed/hidden back to visible
                    forumDAO.updatePostStatus(id, "visible");
                }
            }
            // Redirect to preserve the view state
            return new ModelAndView("redirect:forum-monitor" + (view != null ? "?view=" + view : ""));
        }

        // Filter posts based on view parameter
        List<Post> filteredPosts;

        if ("archived".equals(view)) {
            // Show hidden posts only (removed posts are strictly removed)
            // Show hidden AND removed posts
            filteredPosts = forumDAO.getPostsByStatus(List.of("hidden", "removed"));
        } else {
            // Default: Show visible posts (including reported ones if they are visible)
            filteredPosts = forumDAO.getPostsByStatus(List.of("visible", "active", "reported"));
            // Note: 'active' and 'reported' might be statuses used in creation/logic,
            // ensuring we catch them.
            // Ideally we should normalize statuses.
        }

        ModelAndView mv = new ModelAndView();
        mv.addObject("posts", filteredPosts);
        mv.addObject("currentView", view == null ? "active" : view);
        mv.setViewName("forum-monitor");
        return mv;
    }
}
