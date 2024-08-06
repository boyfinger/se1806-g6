package model.course;

import java.util.StringJoiner;

public class CourseDetail {
    private int id;
    private String InstructorName;
    private int SubjectId;
    private String SubjectName;
    private int ClassId;
    private String ClassName;

    public CourseDetail() {
    }

    public CourseDetail(int id, String instructorName, int subjectId, String subjectName, int classId, String className) {
        this.id = id;
        InstructorName = instructorName;
        SubjectId = subjectId;
        SubjectName = subjectName;
        ClassId = classId;
        ClassName = className;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInstructorName() {
        return InstructorName;
    }

    public void setInstructorName(String instructorName) {
        InstructorName = instructorName;
    }

    public int getSubjectId() {
        return SubjectId;
    }

    public void setSubjectId(int subjectId) {
        SubjectId = subjectId;
    }

    public String getSubjectName() {
        return SubjectName;
    }

    public void setSubjectName(String subjectName) {
        SubjectName = subjectName;
    }

    public int getClassId() {
        return ClassId;
    }

    public void setClassId(int classId) {
        ClassId = classId;
    }

    public String getClassName() {
        return ClassName;
    }

    public void setClassName(String className) {
        ClassName = className;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", CourseDetail.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("InstructorName='" + InstructorName + "'")
                .add("SubjectId=" + SubjectId)
                .add("SubjectName='" + SubjectName + "'")
                .add("ClassId=" + ClassId)
                .add("ClassName='" + ClassName + "'")
                .toString();
    }
}
