package com.example.controller;

import com.example.model.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/forum-monitor")
public class ForumMonitorController {

    @RequestMapping
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {

        ModelAndView mv = new ModelAndView();
        mv.addObject("posts", Post.mockPosts());
        mv.setViewName("forum-monitor");
        return mv;
    }
}
