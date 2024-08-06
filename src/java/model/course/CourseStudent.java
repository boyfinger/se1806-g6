package model.course;

import java.util.StringJoiner;

public class CourseStudent {
    private int id;
    private String FullName;
    private String Email;

    public CourseStudent() {
    }

    public CourseStudent(int id, String fullName, String email) {
        this.id = id;
        FullName = fullName;
        Email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String fullName) {
        FullName = fullName;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", CourseStudent.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("FullName='" + FullName + "'")
                .add("Email='" + Email + "'")
                .toString();
    }
}
