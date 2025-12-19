package com.example.demo.model;

import java.util.*;

public class Resource {

    private int id;
    private String title;
    private String description;
    private String type;
    private String topic;
    private String content;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public static List<Resource> mockResources() {
        if (resources == null) {
            resources = new ArrayList<>();
            Resource r1 = new Resource();
            r1.setId(1);
            r1.setTitle("Managing Exam Stress");
            r1.setDescription("Tips to cope with academic pressure");
            r1.setType("Article");
            r1.setTopic("Stress Management");
            r1.setContent("Exam stress is common among students. Here are some tips: 1. Prepare a study schedule. 2. Take breaks. 3. Eat healthy. 4. Get enough sleep. 5. Talk to someone if needed.");

            resources.add(r1);

            Resource r2 = new Resource();
            r2.setId(2);
            r2.setTitle("Sleep Hygiene Guide");
            r2.setDescription("Improve your sleep quality");
            r2.setType("Guide");
            r2.setTopic("Sleep");
            r2.setContent("Good sleep hygiene includes: Maintain a consistent sleep schedule. Create a relaxing bedtime routine. Avoid screens before bed. Keep your bedroom cool and dark. Limit caffeine intake.");

            resources.add(r2);

            Resource r3 = new Resource();
            r3.setId(3);
            r3.setTitle("Anxiety Reduction Techniques");
            r3.setDescription("Practical methods to reduce anxiety");
            r3.setType("Video");
            r3.setTopic("Anxiety");
            r3.setContent("Watch this video for breathing exercises and mindfulness techniques to reduce anxiety. Practice deep breathing: Inhale for 4 counts, hold for 4, exhale for 4.");

            resources.add(r3);

            Resource r4 = new Resource();
            r4.setId(4);
            r4.setTitle("Building Self-Confidence");
            r4.setDescription("Strategies to boost your self-esteem");
            r4.setType("Article");
            r4.setTopic("Motivation");
            r4.setContent("To build self-confidence: Set small goals. Celebrate achievements. Surround yourself with positive people. Practice self-care. Challenge negative thoughts.");

            resources.add(r4);
        }
        return resources;
    }

    private static List<Resource> resources;

    public static Resource findById(int id) {
        return mockResources().stream().filter(r -> r.getId() == id).findFirst().orElse(null);
    }
}
