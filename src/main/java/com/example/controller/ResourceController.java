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

    @org.springframework.beans.factory.annotation.Autowired
    private com.example.model.AnalyticsDAO analyticsDAO;

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res,
            java.security.Principal principal) {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        HttpSession session = req.getSession();
        com.example.model.User user = (com.example.model.User) session.getAttribute("loggedUser");

        System.out.println("DEBUG: ResourceController handleRequest");
        System.out.println("DEBUG: Method: " + req.getMethod());
        System.out.println("DEBUG: Action: " + action);
        System.out.println("DEBUG: User Role: " + (user != null ? user.getRole() : "null"));

        // LOGGING: General module usage when visiting main page or detail

        if ("POST".equals(req.getMethod())) {
            // Check permissions (Only mhprofessional can manage resources)
            // Note: For permission check, we still use the session 'user' object if it
            // contains role info,
            // or we could fetch it from DB using principal. For now, we trust session for
            // Role, but Principal for Logging identity.
            if (user == null || !"mhprofessional".equals(user.getRole())) {
                return new ModelAndView("redirect:resources?error=unauthorized");
            }

            if ("add".equals(action)) {
                String title = req.getParameter("title");
                String description = req.getParameter("description");
                String content = req.getParameter("content");
                String category = req.getParameter("category"); // topic
                String type = req.getParameter("type");

                System.out.println("DEBUG: ResourceController POST add action triggered");
                System.out.println("DEBUG: Title received: " + title);

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
                    System.out.println("DEBUG: Calling Resource.addResource...");
                    Resource.addResource(r);
                    System.out.println("DEBUG: Resource added, redirecting...");
                    return new ModelAndView("redirect:resources?status=created");
                } else {
                    System.out.println("DEBUG: Title missing, cannot add resource");
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
                    // LOGGING: Specific resource view
                    if (analyticsDAO != null) {
                        String emailToLog = "anonymous";
                        if (user != null) {
                            emailToLog = user.getEmail();
                        } else if (principal != null) {
                            emailToLog = principal.getName();
                        }

                        if (!"anonymous".equals(emailToLog)) {
                            analyticsDAO.logResourceView(resource.getTitle(), emailToLog);
                        }
                    }

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
