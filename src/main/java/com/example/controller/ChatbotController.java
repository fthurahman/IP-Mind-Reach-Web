package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.model.Message;
import com.example.model.QuickReply;
import com.example.service.HfChatbotService;
import com.example.service.RiskDetector;
import com.example.service.RiskLevel;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatbotController {

  private final HfChatbotService hfChatbotService;

  public ChatbotController(HfChatbotService hfChatbotService) {
    this.hfChatbotService = hfChatbotService;
  }

  @org.springframework.beans.factory.annotation.Autowired
  private com.example.model.AnalyticsDAO analyticsDAO;

  @GetMapping("/chatbot")
  public ModelAndView chatbot(javax.servlet.http.HttpServletRequest req, java.security.Principal principal) {
    // LOGGING: Chatbot module usage
    if (analyticsDAO != null && principal != null) {
        analyticsDAO.logActivityProgress("Chatbot", principal.getName());
    }

    ModelAndView mv = new ModelAndView("chatbot");

    List<Message> initialMessages = new ArrayList<Message>();

    List<QuickReply> quickReplies = new ArrayList<QuickReply>();
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

  // AI endpoint (JSP will call this)
  @PostMapping("/chatbot/message")
  @ResponseBody
  public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, String> payload) {
    String userText = payload != null ? payload.get("message") : null;
    if (userText == null) userText = "";
    userText = userText.trim();

    Map<String, Object> resp = new HashMap<String, Object>();

    if (userText.length() == 0) {
      resp.put("error", "Empty message");
      return ResponseEntity.badRequest().body(resp);
    }

    // ✅ Risk detection
    RiskLevel risk = RiskDetector.detect(userText);
    resp.put("risk", risk.name());

    // ✅ HIGH → static message (no AI call)
    if (risk == RiskLevel.HIGH) {
      resp.put("reply", highRiskStaticMessage());
      return ResponseEntity.ok(resp);
    }

    // ✅ LOW/MED → AI
    String reply = hfChatbotService.reply(userText, risk);
    resp.put("reply", reply);
    return ResponseEntity.ok(resp);
  }

  private String highRiskStaticMessage() {
    return "I’m really sorry you’re going through this — but I can’t help with anything related to self-harm.\n\n"
      + "If you feel unsafe or might hurt yourself, please reach out now:\n"
      + "• Emergency: 999\n"
      + "• Befrienders KL (24/7): 03-7627 2929\n"
      + "• Talian HEAL (MOH): 15555\n\n"
      + "If you can answer one thing: are you in immediate danger right now?";
  }
}
