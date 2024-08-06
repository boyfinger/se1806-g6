package model.course;

import java.util.StringJoiner;

public class CourseStudentCount {
    private int courseId;
    private int studentCount;

    public CourseStudentCount() {
    }

    public CourseStudentCount(int courseId, int studentCount) {
        this.courseId = courseId;
        this.studentCount = studentCount;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(int studentCount) {
        this.studentCount = studentCount;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", CourseStudentCount.class.getSimpleName() + "[", "]")
                .add("courseId=" + courseId)
                .add("studentCount=" + studentCount)
                .toString();
    }
}
