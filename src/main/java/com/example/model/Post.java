package com.example.model;

import java.util.*;

public class Post {

    private int id;
    private String author;
    private String content;
    private String topic;
    private String status;
    private boolean reported;
    private String createdAt;
    private List<Comment> comments;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isReported() {
        return reported;
    }

    public void setReported(boolean reported) {
        this.reported = reported;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public static List<Post> mockPosts() {
        if (posts == null) {
            posts = new ArrayList<>();
            Post p1 = new Post();
            p1.setId(1);
            p1.setAuthor("Anonymous Owl");
            p1.setTopic("Stress");
            p1.setContent("Finals week is overwhelming ");
            p1.setStatus("visible");
            p1.setReported(false);
            p1.setCreatedAt("2025-12-18");

            Comment c1 = new Comment();
            c1.setId(1);
            c1.setAuthor("Support");
            c1.setContent("Hang in there!");
            c1.setCreatedAt("2025-12-18");
            p1.setComments(new ArrayList<>(Arrays.asList(c1)));

            posts.add(p1);

            Post p2 = new Post();
            p2.setId(2);
            p2.setAuthor("Worried Student");
            p2.setTopic("Anxiety");
            p2.setContent("I'm feeling really anxious about my grades. Any tips?");
            p2.setStatus("visible");
            p2.setReported(false);
            p2.setCreatedAt("2025-12-17");

            Comment c2 = new Comment();
            c2.setId(1);
            c2.setAuthor("Peer Helper");
            c2.setContent("Try deep breathing exercises. You've got this!");
            c2.setCreatedAt("2025-12-17");
            p2.setComments(new ArrayList<>(Arrays.asList(c2)));

            posts.add(p2);

            Post p3 = new Post();
            p3.setId(3);
            p3.setAuthor("Sleepy Scholar");
            p3.setTopic("Sleep");
            p3.setContent("Not getting enough sleep. How do you balance study and rest?");
            p3.setStatus("visible");
            p3.setReported(false);
            p3.setCreatedAt("2025-12-16");

            Comment c3 = new Comment();
            c3.setId(1);
            c3.setAuthor("Wellness Buddy");
            c3.setContent("Set a consistent sleep schedule and avoid screens before bed.");
            c3.setCreatedAt("2025-12-16");
            p3.setComments(new ArrayList<>(Arrays.asList(c3)));

            posts.add(p3);

            Post p4 = new Post();
            p4.setId(4);
            p4.setAuthor("Motivated Learner");
            p4.setTopic("Motivation");
            p4.setContent("How do you stay motivated during tough times?");
            p4.setStatus("visible");
            p4.setReported(false);
            p4.setCreatedAt("2025-12-15");

            p4.setComments(new ArrayList<>());

            posts.add(p4);
        }
        return posts;
    }

    private static List<Post> posts;

    public static Post findById(int id) {
        return mockPosts().stream().filter(p -> p.getId() == id).findFirst().orElse(null);
    }

    public void addComment(String author, String content) {
        Comment c = new Comment();
        c.setId(this.comments.size() + 1);
        c.setAuthor(author);
        c.setContent(content);
        c.setCreatedAt("2025-12-18");
        this.comments.add(c);
    }
}
