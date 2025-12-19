package com.example.model;

public class QuickReply {
    private String text;
    private String action;

    public QuickReply() {}

    public QuickReply(String text, String action) {
        this.text = text;
        this.action = action;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
}
