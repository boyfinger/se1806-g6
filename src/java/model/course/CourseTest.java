package model.course;

import java.util.StringJoiner;

public class CourseTest {
    private int Id;
    private int GroupId;

    public CourseTest() {
    }

    public CourseTest(int id, int groupId) {
        Id = id;
        GroupId = groupId;
    }

    public int getGroupId() {
        return GroupId;
    }

    public void setGroupId(int groupId) {
        GroupId = groupId;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", CourseTest.class.getSimpleName() + "[", "]")
                .add("Id=" + Id)
                .add("GroupId=" + GroupId)
                .toString();
    }
}
