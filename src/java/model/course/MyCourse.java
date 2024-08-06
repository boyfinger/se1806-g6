package model.course;


import java.util.ArrayList;

public class MyCourse {
    private CourseDetail courseDetail;
    private ArrayList<CourseAnnouncement> announcements;
    private ArrayList<CourseLesson> lessons;
    private ArrayList<CourseTest> tests;
    private ArrayList<CourseFlashcardSet> flashcardSets;

    public MyCourse() {
    }

    public MyCourse(CourseDetail courseDetail, ArrayList<CourseAnnouncement> announcements, ArrayList<CourseLesson> lessons, ArrayList<CourseTest> tests, ArrayList<CourseFlashcardSet> flashcardSets) {
        this.courseDetail = courseDetail;
        this.announcements = announcements;
        this.lessons = lessons;
        this.tests = tests;
        this.flashcardSets = flashcardSets;
    }

    public CourseDetail getCourseDetail() {
        return courseDetail;
    }

    public void setCourseDetail(CourseDetail courseDetail) {
        this.courseDetail = courseDetail;
    }

    public ArrayList<CourseAnnouncement> getAnnouncements() {
        return announcements;
    }

    public void setAnnouncements(ArrayList<CourseAnnouncement> announcements) {
        this.announcements = announcements;
    }

    public ArrayList<CourseLesson> getLessons() {
        return lessons;
    }

    public void setLessons(ArrayList<CourseLesson> lessons) {
        this.lessons = lessons;
    }

    public ArrayList<CourseTest> getTests() {
        return tests;
    }

    public void setTests(ArrayList<CourseTest> tests) {
        this.tests = tests;
    }

    public ArrayList<CourseFlashcardSet> getFlashcardSets() {
        return flashcardSets;
    }

    public void setFlashcardSets(ArrayList<CourseFlashcardSet> flashcardSets) {
        this.flashcardSets = flashcardSets;
    }
}
