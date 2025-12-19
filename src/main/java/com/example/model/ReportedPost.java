package com.example.model;

import java.util.Date;

public class ReportedPost {
  private String id;
  private String content;
  private String author;
  private String reason;
  private String reportedBy;
  private Date date;
  private String status; // pending | resolved | removed (kau decide)

  public ReportedPost() {}

  public ReportedPost(
      String id,
      String content,
      String author,
      String reason,
      String reportedBy,
      Date date,
      String status
  ) {
    this.id = id;
    this.content = content;
    this.author = author;
    this.reason = reason;
    this.reportedBy = reportedBy;
    this.date = date;
    this.status = status;
  }

  public String getId() { return id; }
  public void setId(String id) { this.id = id; }

  public String getContent() { return content; }
  public void setContent(String content) { this.content = content; }

  public String getAuthor() { return author; }
  public void setAuthor(String author) { this.author = author; }

  public String getReason() { return reason; }
  public void setReason(String reason) { this.reason = reason; }

  public String getReportedBy() { return reportedBy; }
  public void setReportedBy(String reportedBy) { this.reportedBy = reportedBy; }

  public Date getDate() { return date; }
  public void setDate(Date date) { this.date = date; }

  public String getStatus() { return status; }
  public void setStatus(String status) { this.status = status; }
}
