package com.example.controller;

import com.example.model.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.*;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/resources")
public class ResourceController {

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        HttpSession session = req.getSession();
        com.example.model.User user = (com.example.model.User) session.getAttribute("loggedUser");

        if ("POST".equals(req.getMethod())) {
            // Check permissions (Only mhprofessional can manage resources)
            if (user == null || !"mhprofessional".equals(user.getRole())) {
                return new ModelAndView("redirect:resources?error=unauthorized");
            }

            if ("add".equals(action)) {
                String title = req.getParameter("title");
                String description = req.getParameter("description");
                String content = req.getParameter("content");
                String category = req.getParameter("category"); // topic
                String type = req.getParameter("type");

                if (title != null && !title.isEmpty()) {
                    Resource r = new Resource();
                    r.setTitle(title);
                    r.setDescription(description);
                    r.setContent(content);
                    r.setTopic(category);
                    r.setType(type);
                    if ("video".equals(type)) {
                        String duration = req.getParameter("duration");
                        String videoUrl = req.getParameter("videoUrl");
                        r.setDuration((duration != null && !duration.isEmpty()) ? duration : "10 min");
                        if (videoUrl != null && !videoUrl.isEmpty()) {
                            r.setVideoUrl(videoUrl);
                        }
                    }
                    Resource.addResource(r);
                    return new ModelAndView("redirect:resources?status=created");
                }
            } else if ("delete".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                Resource.deleteResource(id);
                return new ModelAndView("redirect:resources?status=deleted");
            }
        }

        if ("GET".equals(req.getMethod())) {
            if ("detail".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                Resource resource = Resource.findById(id);
                if (resource != null) {
                    ModelAndView mv = new ModelAndView();
                    mv.addObject("resource", resource);
                    mv.setViewName("resource-detail");
                    return mv;
                }
            }

            // Filtering
            String q = req.getParameter("q");
            String topic = req.getParameter("topic");

            List<Resource> allResources = Resource.mockResources();
            if (allResources == null) {
                allResources = new java.util.ArrayList<>();
            }
            System.out.println("DEBUG: All Resources Size = " + allResources.size());
            List<Resource> filtered = allResources.stream()
                    .filter(r -> {
                        boolean matchesTopic = topic == null || "all".equals(topic)
                                || r.getTopic().equalsIgnoreCase(topic);
                        boolean matchesSearch = q == null || q.trim().isEmpty() ||
                                r.getTitle().toLowerCase().contains(q.toLowerCase()) ||
                                r.getDescription().toLowerCase().contains(q.toLowerCase());
                        return matchesTopic && matchesSearch;
                    })
                    .collect(Collectors.toList());

            ModelAndView mv = new ModelAndView();
            mv.addObject("resources", filtered);
            mv.addObject("currentTopic", topic == null ? "all" : topic);

            // Role-based View Selection
            if (user != null) {
                if ("admin".equals(user.getRole())) {
                    mv.setViewName("resourcesAdmin");
                } else if ("mhprofessional".equals(user.getRole())) {
                    mv.setViewName("resourcesCounselor");
                } else {
                    mv.setViewName("resources"); // Student or others
                }
            } else {
                mv.setViewName("resources");
            }

            return mv;
        }

        // Default fallback
        return new ModelAndView("redirect:resources");
    }
}
