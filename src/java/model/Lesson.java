package model;

import java.util.Comparator;
import model.subject.Subject;

public class Lesson {

    int id, subjectId, order;
    String name;
    boolean status;
    Subject subject;

    public Lesson() {
    }

    public Lesson(int id, int subjectId, int order, String name, boolean status, Subject subject) {
        this.id = id;
        this.subjectId = subjectId;
        this.order = order;
        this.name = name;
        this.status = status;
        this.subject = subject;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public static class SortByName implements Comparator<Lesson> {

        @Override
        public int compare(Lesson l1, Lesson l2) {
            return l1.getName().compareTo(l2.getName());
        }

    }

    public static class SortByStatus implements Comparator<Lesson> {

        @Override
        public int compare(Lesson l1, Lesson l2) {
            if (l1.isStatus() == l2.isStatus()) {
                return 0;
            }
            if (l1.isStatus() && !l2.isStatus()) {
                return -1;
            }
            return 1;
        }

    }

    public static class SortByOrder implements Comparator<Lesson> {

        @Override
        public int compare(Lesson l1, Lesson l2) {
            return l1.getOrder() - l2.getOrder();
        }
    }

}
