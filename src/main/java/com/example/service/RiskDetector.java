package com.example.service;

import java.util.regex.Pattern;

public class RiskDetector {

  // High-risk phrases (English + common slang)
  private static final Pattern HIGH = Pattern.compile(
    "(?i)\\b(" +
      "suicid(e|al)|kill\\s*myself|end\\s*my\\s*life|take\\s*my\\s*life|" +
      "want\\s*to\\s*die|wanna\\s*die|i\\s*want\\s*to\\s*die|" +
      "self\\s*harm|self-harm|hurt\\s*myself|" +
      "kms|kys|" +
      "overdose|od\\b|jump\\s*off|hang\\s*myself" +
    ")\\b"
  );

  // Medium-risk: distress but not explicit self-harm intent
  private static final Pattern MED = Pattern.compile(
    "(?i)\\b(" +
      "hopeless|worthless|can't\\s*go\\s*on|cant\\s*go\\s*on|" +
      "nothing\\s*matters|panic|anxious|anxiety|depressed|depression|" +
      "breakdown|overwhelmed|burnout|insomnia|can't\\s*sleep|cant\\s*sleep" +
    ")\\b"
  );

  private RiskDetector() {}

  public static RiskLevel detect(String text) {
    if (text == null) return RiskLevel.LOW;
    String t = text.trim();
    if (t.length() == 0) return RiskLevel.LOW;

    if (HIGH.matcher(t).find()) return RiskLevel.HIGH;
    if (MED.matcher(t).find()) return RiskLevel.MEDIUM;
    return RiskLevel.LOW;
  }
}
