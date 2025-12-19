package com.example.model;

import java.util.*;

public class Resource {

    private int id;
    private String title;
    private String description;
    private String type;
    private String topic;
    private String content;
    private String duration; // Optional, for videos

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    private String videoUrl;

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public static List<Resource> mockResources() {
        if (resources == null) {
            resources = new ArrayList<>();
            Resource r1 = new Resource();
            r1.setId(1);
            r1.setTitle("Understanding Anxiety: What You Need to Know");
            r1.setDescription("Learn about the causes, symptoms, and coping strategies for anxiety.");
            r1.setType("article");
            r1.setTopic("anxiety");
            r1.setContent("Anxiety is a natural response to stress...");
            resources.add(r1);

            Resource r2 = new Resource();
            r2.setId(2);
            r2.setTitle("Mindfulness Meditation for Beginners");
            r2.setDescription("A step-by-step guide to starting your mindfulness practice.");
            r2.setType("video");
            r2.setTopic("mindfulness");
            r2.setDuration("12 min");
            r2.setContent("Video content about mindfulness meditation...");
            resources.add(r2);

            Resource r3 = new Resource();
            r3.setId(3);
            r3.setTitle("Managing Stress During Exams");
            r3.setDescription("Practical tips and techniques to handle academic pressure.");
            r3.setType("article");
            r3.setTopic("stress");
            r3.setContent("Exam periods can be stressful...");
            resources.add(r3);

            Resource r4 = new Resource();
            r4.setId(4);
            r4.setTitle("Sleep Hygiene: Getting Better Rest");
            r4.setDescription("Improve your sleep quality with these evidence-based strategies.");
            r4.setType("article");
            r4.setTopic("sleep");
            r4.setContent("Good sleep is essential for mental health...");
            resources.add(r4);

            Resource r5 = new Resource();
            r5.setId(5);
            r5.setTitle("Building Self-Esteem and Confidence");
            r5.setDescription("Techniques to develop a healthier relationship with yourself.");
            r5.setType("video");
            r5.setTopic("self-esteem");
            r5.setDuration("15 min");
            r5.setContent("Video about building confidence...");
            resources.add(r5);

            Resource r6 = new Resource();
            r6.setId(6);
            r6.setTitle("Dealing with Depression: A Guide");
            r6.setDescription("Understanding depression and when to seek professional help.");
            r6.setType("article");
            r6.setTopic("depression");
            r6.setContent("Depression is more than feeling sad...");
            resources.add(r6);
        }
        return resources;
    }

    private static List<Resource> resources;

    public static Resource findById(int id) {
        return mockResources().stream().filter(r -> r.getId() == id).findFirst().orElse(null);
    }

    public static void addResource(Resource r) {
        mockResources();
        if (r != null) {
            System.out.println("DEBUG: Adding resource: " + r.getTitle());
            // Generate ID
            int maxId = resources.stream().mapToInt(Resource::getId).max().orElse(0);
            r.setId(maxId + 1);
            resources.add(0, r); // Add to top
            System.out.println("DEBUG: Resource added. New size: " + resources.size());
        }
    }

    public static void deleteResource(int id) {
        mockResources().removeIf(r -> r.getId() == id);
    }
}
