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
            if ("search".equals(action)) {
                String q = req.getParameter("q");
                List<Resource> allResources = Resource.mockResources();
                List<Resource> filtered = allResources;
                if (q != null && !q.trim().isEmpty()) {
                    filtered = allResources.stream()
                            .filter(r -> r.getTitle().toLowerCase().contains(q.toLowerCase()) ||
                                    r.getDescription().toLowerCase().contains(q.toLowerCase()) ||
                                    r.getTopic().toLowerCase().contains(q.toLowerCase()))
                            .collect(Collectors.toList());
                }
                ModelAndView mv = new ModelAndView();
                mv.addObject("resources", filtered);
                mv.setViewName("resources");
                return mv;
            }
            // Default: list resources
            ModelAndView mv = new ModelAndView();
            mv.addObject("resources", Resource.mockResources());
            mv.setViewName("resources");
            return mv;
        }

        // Default
        ModelAndView mv = new ModelAndView();
        mv.addObject("resources", Resource.mockResources());
        mv.setViewName("resources");
        return mv;
    }
}
