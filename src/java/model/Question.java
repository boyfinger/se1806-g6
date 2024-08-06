package model;

import java.util.Comparator;

public class Question {

    private int id;
    private String content;
    private Lesson lesson;
    private boolean status;

    public Question() {
    }

    public Question(int id, String content, Lesson lesson, boolean status) {
        this.id = id;
        this.content = content;
        this.lesson = lesson;
        this.status = status;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public static class SortByContent implements Comparator<Question> {

        @Override
        public int compare(Question q1, Question q2) {
            return q1.getContent().compareTo(q2.getContent());
        }

    }

    public static class SortByLesson implements Comparator<Question> {

        @Override
        public int compare(Question q1, Question q2) {
            return q1.getLesson().getName()
                    .compareTo(q2.getLesson().getName());
        }
    }

    public static class SortByStatus implements Comparator<Question> {

        @Override
        public int compare(Question q1, Question q2) {
            if (q1.isStatus() == q2.isStatus()) {
                return 0;
            }
            if ((q1.isStatus()) && (!q2.isStatus())) {
                return -1;
            } else {
                return 1;
            }
        }
    }

    public static class SortBySubject implements Comparator<Question> {

        @Override
        public int compare(Question q1, Question q2) {
            return q1.getLesson().getSubject().getCode()
                    .compareTo(q2.getLesson().getSubject().getCode());
        }

    }

}
