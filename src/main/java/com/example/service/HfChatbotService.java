package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class HfChatbotService {

  @Value("${hf.api.key}")
  private String apiKey;

  @Value("${hf.base-url}")
  private String baseUrl;

  @Value("${hf.chat.model}")
  private String model;

  private final RestTemplate rest = new RestTemplate();

  /**
   * LOW/MED only. HIGH should be handled in controller (static message, no AI call).
   */
  public String reply(String userText, RiskLevel risk) {
    String url = baseUrl + "/chat/completions";

    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.add("Authorization", "Bearer " + apiKey);

    List<Map<String, String>> messages = new ArrayList<Map<String, String>>();

    // System prompt (personality) — can vary by risk
    Map<String, String> sys = new HashMap<String, String>();
    sys.put("role", "system");
    sys.put("content", buildSystemPrompt(risk));
    messages.add(sys);

    Map<String, String> user = new HashMap<String, String>();
    user.put("role", "user");
    user.put("content", userText);
    messages.add(user);

    Map<String, Object> body = new HashMap<String, Object>();
    body.put("model", model);
    body.put("messages", messages);

    // Tuning
    body.put("temperature", Double.valueOf(risk == RiskLevel.MEDIUM ? 0.6 : 0.7));
    body.put("max_tokens", Integer.valueOf(180));

    try {
      ResponseEntity<Map> res = rest.postForEntity(
        url,
        new HttpEntity<Map<String, Object>>(body, headers),
        Map.class
      );

      String content = extractChatContent(res.getBody());
      content = sanitize(content);

      if (content == null || content.trim().length() == 0) {
        return "Sorry — I couldn’t generate a reply just now. Please try again.";
      }
      return content;

    } catch (Exception e) {
      e.printStackTrace();
      return "Sorry — I’m having trouble replying right now. Please try again in a moment.";
    }
  }

  private String buildSystemPrompt(RiskLevel risk) {
    String base =
      "You are MindReach Assistant, a calm and supportive mental wellbeing companion for students.\n" +
      "Be warm, non-judgmental, and concise.\n" +
      "Do not diagnose. Do not provide medical advice.\n" +
      "Avoid long answers. Ask at most one gentle question.\n" +
      "Never output <think> or any internal reasoning. Only output the final answer.\n";

    if (risk == RiskLevel.MEDIUM) {
      return base +
        "The user may be distressed. Use extra soothing tone.\n" +
        "Offer 1 small grounding step (e.g. slow breathing or name 5 things they see).\n" +
        "Encourage reaching out to a trusted friend or campus counselor if needed.\n";
    }

    // LOW default
    return base;
  }

  @SuppressWarnings("unchecked")
  private String extractChatContent(Map body) {
    if (body == null) return null;

    Object choicesObj = body.get("choices");
    if (!(choicesObj instanceof List)) return null;

    List choices = (List) choicesObj;
    if (choices.isEmpty()) return null;

    Object first = choices.get(0);
    if (!(first instanceof Map)) return null;

    Map firstMap = (Map) first;
    Object messageObj = firstMap.get("message");
    if (!(messageObj instanceof Map)) return null;

    Map msg = (Map) messageObj;
    Object contentObj = msg.get("content");

    if (contentObj instanceof String) {
      return ((String) contentObj).trim();
    }
    return null;
  }

  // Remove <think>...</think> block if model leaks it
  private String sanitize(String text) {
  if (text == null) return "";

  String cleaned = text;

  // case 1: proper <think>...</think>
  cleaned = cleaned.replaceAll("(?s)<think>.*?</think>", "").trim();

  // case 2: leaked <think> without closing tag (remove from <think> to end)
  cleaned = cleaned.replaceAll("(?s)<think>.*$", "").trim();

  // extra: some models leak other tags
  cleaned = cleaned.replaceAll("(?s)<\\/?think>", "").trim();

  return cleaned;
}

}
