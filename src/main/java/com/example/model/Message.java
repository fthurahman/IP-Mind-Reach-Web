package com.example.model;

import java.util.List;

public class Message {
  private String id;
  private String type;     // bot | user
  private String content;
  private List<QuickReply> quickReplies;

  public Message() {}

  public Message(String id, String type, String content, List<QuickReply> quickReplies) {
    this.id = id;
    this.type = type;
    this.content = content;
    this.quickReplies = quickReplies;
  }

  public String getId() { return id; }
  public void setId(String id) { this.id = id; }

  public String getType() { return type; }
  public void setType(String type) { this.type = type; }

  public String getContent() { return content; }
  public void setContent(String content) { this.content = content; }

  public List<QuickReply> getQuickReplies() { return quickReplies; }
  public void setQuickReplies(List<QuickReply> quickReplies) { this.quickReplies = quickReplies; }
}
