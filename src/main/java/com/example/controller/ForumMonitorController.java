package com.example.controller;

import com.example.demo.model.Post;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import javax.servlet.http.*;

public class ForumMonitorController implements Controller {

    @Override
    public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {

        ModelAndView mv = new ModelAndView();
        mv.addObject("posts", Post.mockPosts());
        mv.setViewName("forum-monitor");
        return mv;
    }
}
