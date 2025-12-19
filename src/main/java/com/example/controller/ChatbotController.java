package com.example.controller;

import java.util.ArrayList;
import java.util.List;

import com.example.model.Message;
import com.example.model.QuickReply;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatbotController {

  @GetMapping("/chatbot")
  public ModelAndView chatbot() {
    ModelAndView mv = new ModelAndView("chatbot");

    // initialMessages ikut TSX
    List<Message> initialMessages = new ArrayList<>();

    List<QuickReply> quickReplies = new ArrayList<>();
    quickReplies.add(new QuickReply("😰 Overwhelmed", "stressed"));
    quickReplies.add(new QuickReply("😟 Anxious", "anxious"));
    quickReplies.add(new QuickReply("😴 Can't sleep", "sleep"));
    quickReplies.add(new QuickReply("💬 Just want to talk", "talk"));

    initialMessages.add(new Message(
      "1",
      "bot",
      "Hi there. I'm here to support you. How would you describe today?",
      quickReplies
    ));

    mv.addObject("initialMessages", initialMessages);

    return mv;
  }
}
