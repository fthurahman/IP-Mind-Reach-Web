package com.example.service;

import com.example.model.MoodEntry;
import com.example.model.Activity;
import com.example.model.CounselorTelehealth;
import com.example.model.TimeSlot;
import com.example.model.AppointmentTelehealth;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class MindReachService {

    // Initialize mock mood data
    public List<MoodEntry> initializeMockMoodData() {
        List<MoodEntry> moodData = new ArrayList<>();
        moodData.add(new MoodEntry("11/1", 7, "😊"));
        moodData.add(new MoodEntry("11/2", 6, "🙂"));
        moodData.add(new MoodEntry("11/3", 8, "😄"));
        moodData.add(new MoodEntry("11/4", 5, "😐"));
        moodData.add(new MoodEntry("11/5", 7, "😊"));
        moodData.add(new MoodEntry("11/6", 8, "😄"));
        return moodData;
    }

    // Initialize mock activity data
    public List<Activity> initializeMockActivities() {
        List<Activity> activities = new ArrayList<>();
        activities.add(new Activity("❤️", "Self-Help", 12, 15));
        activities.add(new Activity("📚", "Resources", 8, 10));
        activities.add(new Activity("💬", "Forum Posts", 5, 5));
        activities.add(new Activity("👤", "Counseling", 2, 3));
        return activities;
    }

    // Initialize mock counselors
    public List<CounselorTelehealth> initializeMockCounselors() {
        List<CounselorTelehealth> counselors = new ArrayList<>();

        // Dr. Sarah Mitchell
        List<TimeSlot> slots1 = new ArrayList<>();
        slots1.add(new TimeSlot("1", "2025-11-08", "10:00 AM", true));
        slots1.add(new TimeSlot("2", "2025-11-08", "2:00 PM", true));
        slots1.add(new TimeSlot("3", "2025-11-09", "11:00 AM", true));
        slots1.add(new TimeSlot("4", "2025-11-10", "3:00 PM", true));

        counselors.add(new CounselorTelehealth(
                "1", "Dr. Sarah Mitchell", "Anxiety & Stress Management",
                "Specializes in cognitive behavioral therapy and mindfulness techniques.",
                "https://images.unsplash.com/photo-1632054226752-b1b40867f7a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmZW1hbGUlMjBkb2N0b3IlMjBwcm9mZXNzaW9uYWx8ZW58MXx8fHwxNzYyNDQxNjkyfDA&ixlib=rb-4.1.0&q=80&w=1080",
                slots1));

        // Dr. James Chen
        List<TimeSlot> slots2 = new ArrayList<>();
        slots2.add(new TimeSlot("5", "2025-11-08", "9:00 AM", true));
        slots2.add(new TimeSlot("6", "2025-11-09", "1:00 PM", true));
        slots2.add(new TimeSlot("7", "2025-11-10", "10:00 AM", true));

        counselors.add(new CounselorTelehealth(
                "2", "Dr. James Chen", "Academic Pressure & Performance",
                "Helps students manage academic stress and develop healthy study habits.",
                "https://images.unsplash.com/photo-1740153204804-200310378f2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhc2lhbiUyMGNvdW5zZWxvciUyMHByb2Zlc3Npb25hbHxlbnwxfHx8fDE3NjI1MDkxNTZ8MA&ixlib=rb-4.1.0&q=80&w=1080",
                slots2));

        // Dr. Emily Rodriguez
        List<TimeSlot> slots3 = new ArrayList<>();
        slots3.add(new TimeSlot("8", "2025-11-08", "1:00 PM", true));
        slots3.add(new TimeSlot("9", "2025-11-09", "10:00 AM", true));
        slots3.add(new TimeSlot("10", "2025-11-10", "2:00 PM", true));

        counselors.add(new CounselorTelehealth(
                "3", "Dr. Emily Rodriguez", "Depression & Mood Disorders",
                "Experienced in supporting students through difficult emotional periods.",
                "https://images.unsplash.com/photo-1727299781147-c7ab897883a0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoaXNwYW5pYyUyMGZlbWFsZSUyMHRoZXJhcGlzdHxlbnwxfHx8fDE3NjI1MDkxNjd8MA&ixlib=rb-4.1.0&q=80&w=1080",
                slots3));

        return counselors;
    }

    // Initialize mock appointments for students
    public List<AppointmentTelehealth> initializeStudentAppointments() {
        List<AppointmentTelehealth> appointments = new ArrayList<>();
        appointments.add(new AppointmentTelehealth(
                "1", "1", "Dr. Sarah Mitchell", null,
                "2025-11-07", "2:00 PM", "completed",
                "Discussed coping strategies for exam anxiety. Student showed good progress.",
                "Continue practicing breathing exercises daily. Schedule follow-up in 2 weeks."));
        return appointments;
    }

    // Initialize mock appointments for counselors
    public List<AppointmentTelehealth> initializeCounselorAppointments() {
        List<AppointmentTelehealth> appointments = new ArrayList<>();
        appointments.add(new AppointmentTelehealth(
                "c1", "1", "Dr. Sarah Mitchell", "Alex Johnson",
                "2025-11-08", "10:00 AM", "upcoming", null, null));
        appointments.add(new AppointmentTelehealth(
                "c2", "1", "Dr. Sarah Mitchell", "Jordan Lee",
                "2025-11-09", "2:00 PM", "upcoming", null, null));
        appointments.add(new AppointmentTelehealth(
                "c3", "1", "Dr. Sarah Mitchell", "Taylor Smith",
                "2025-11-05", "11:00 AM", "completed",
                "Student presented concerns about academic workload and time management. We explored practical strategies for prioritizing tasks and setting realistic goals.",
                "Practice the Pomodoro technique for focused study sessions. Keep a daily planner to track assignments and deadlines. Schedule a follow-up in 3 weeks."));
        appointments.add(new AppointmentTelehealth(
                "c4", "1", "Dr. Sarah Mitchell", "Morgan Davis",
                "2025-11-03", "3:00 PM", "completed",
                "Discussed feelings of social isolation and difficulty connecting with peers. Student showed willingness to engage in campus activities.",
                "Join one student organization aligned with personal interests. Practice small talk in low-pressure environments. Check in after 2 weeks."));
        return appointments;
    }

    // Calculate average mood
    public double calculateAverageMood(List<MoodEntry> moodData) {
        if (moodData == null || moodData.isEmpty()) {
            return 0.0;
        }

        double sum = 0;
        for (MoodEntry entry : moodData) {
            sum += entry.getMood();
        }

        return sum / moodData.size();
    }

    // Format date for display
    public String formatDate(String dateStr) {
        try {
            LocalDate date = LocalDate.parse(dateStr);
            return date.format(DateTimeFormatter.ofPattern("MMMM d, yyyy"));
        } catch (Exception e) {
            return dateStr; // Return original if parsing fails
        }
    }
}