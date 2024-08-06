package model.course;

import java.util.StringJoiner;

public class Course {
    private int id;
    private int classId;
    private String className;
    private int subjectId;
    private String subjectCode;
    private String subjectName;
    private int instructorId;
    private String instructorName;

    public Course() {
    }

    public Course(int id, int classId, String className, int subjectId, String subjectCode, String subjectName, int instructorId, String instructorName) {
        this.id = id;
        this.classId = classId;
        this.className = className;
        this.subjectId = subjectId;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.instructorId = instructorId;
        this.instructorName = instructorName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getInstructorId() {
        return instructorId;
    }

    public void setInstructorId(int instructorId) {
        this.instructorId = instructorId;
    }

    public String getInstructorName() {
        return instructorName;
    }

    public void setInstructorName(String instructorName) {
        this.instructorName = instructorName;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", Course.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("classId=" + classId)
                .add("className='" + className + "'")
                .add("subjectId=" + subjectId)
                .add("subjectCode='" + subjectCode + "'")
                .add("subjectName='" + subjectName + "'")
                .add("instructorId=" + instructorId)
                .add("instructorName='" + instructorName + "'")
                .toString();
    }
}
