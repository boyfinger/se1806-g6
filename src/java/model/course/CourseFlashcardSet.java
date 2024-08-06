package model.course;

import java.util.StringJoiner;

public class CourseFlashcardSet {
    private int Id;
    private int SubjectId;
    private String Name;

    public CourseFlashcardSet() {
    }

    public CourseFlashcardSet(int id, int subjectId, String name) {
        Id = id;
        SubjectId = subjectId;
        Name = name;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    public int getSubjectId() {
        return SubjectId;
    }

    public void setSubjectId(int subjectId) {
        SubjectId = subjectId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", CourseFlashcardSet.class.getSimpleName() + "[", "]")
                .add("Id=" + Id)
                .add("SubjectId=" + SubjectId)
                .add("Name='" + Name + "'")
                .toString();
    }
}
