package model.course;

import java.util.StringJoiner;

public class CourseAnnouncement {
    private int Id;
    private int GroupId;
    private String announcement;

    public CourseAnnouncement() {
    }

    public CourseAnnouncement(int id, int groupId, String announcement) {
        Id = id;
        GroupId = groupId;
        this.announcement = announcement;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    public int getGroupId() {
        return GroupId;
    }

    public void setGroupId(int groupId) {
        GroupId = groupId;
    }

    public String getAnnouncement() {
        return announcement;
    }

    public void setAnnouncement(String announcement) {
        this.announcement = announcement;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", CourseAnnouncement.class.getSimpleName() + "[", "]")
                .add("Id=" + Id)
                .add("GroupId=" + GroupId)
                .add("announcement='" + announcement + "'")
                .toString();
    }
}
