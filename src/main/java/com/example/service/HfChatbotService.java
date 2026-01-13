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
    body.put("max_tokens", Integer.valueOf(800)); // Generous limit for longer responses when needed

    try {
      ResponseEntity<Map> res = rest.postForEntity(
        url,
        new HttpEntity<Map<String, Object>>(body, headers),
        Map.class
      );

      String content = extractChatContent(res.getBody());
      content = sanitize(content);
      content = trimToLastCompleteSentence(content); // Ensure complete sentences only

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
      "Be warm, non-judgmental, and helpful.\n" +
      "Do not diagnose. Do not provide medical advice.\n" +
      "CRITICAL: Always complete your sentences with proper punctuation (. ! ?).\n" +
      "CRITICAL: Never end mid-sentence. If running out of space, finish your current sentence and stop there.\n" +
      "Keep responses concise when appropriate, but provide step-by-step guidance when needed.\n" +
      "Ask at most one gentle question.\n" +
      "Never output <think> or any internal reasoning. Only output the final answer.\n";

    if (risk == RiskLevel.MEDIUM) {
      return base +
        "The user may be distressed. Use extra soothing tone.\n" +
        "Offer small grounding steps (e.g. slow breathing or name 5 things they see).\n" +
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

  // Remove proper <think>...</think> blocks
  cleaned = cleaned.replaceAll("(?s)<think>.*?</think>", "").trim();

  // If there's an unclosed <think>, remove ONLY the tag itself (not everything after)
  cleaned = cleaned.replaceAll("(?i)</?think>", "").trim();

  return cleaned;
}

  /**
   * Trims the response to the last complete sentence.
   * If the text doesn't end with proper punctuation (. ! ?), 
   * we trim back to the last sentence that does.
   */
  private String trimToLastCompleteSentence(String text) {
    if (text == null || text.trim().isEmpty()) {
      return text;
    }

    String trimmed = text.trim();
    
    // Check if already ends with sentence-ending punctuation
    if (trimmed.matches(".*[.!?]\\s*$")) {
      return trimmed;
    }

    // Find the last occurrence of sentence-ending punctuation
    int lastPeriod = trimmed.lastIndexOf('.');
    int lastExclamation = trimmed.lastIndexOf('!');
    int lastQuestion = trimmed.lastIndexOf('?');
    
    int lastSentenceEnd = Math.max(lastPeriod, Math.max(lastExclamation, lastQuestion));
    
    // If we found a sentence ending, trim to that point
    if (lastSentenceEnd > 0) {
      return trimmed.substring(0, lastSentenceEnd + 1).trim();
    }
    
    // If no sentence ending found at all, return as-is (edge case)
    return trimmed;
  }


}
