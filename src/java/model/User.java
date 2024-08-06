package model;

import java.io.Serializable;
import java.util.Comparator;
import java.util.Date;
import java.util.StringJoiner;

public class User implements Serializable {

    private int id;
    private String name;
    private String email;
    private int role; // Assuming role is an int indicating role
    private String avatar;
    private int status;
    private Role r;
    private Date dateCreated;

    public User() {
    }

    public User(int id, String name, String email, int role, String avatar, int status, Role r, Date dateCreated) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.role = role;
        this.avatar = avatar;
        this.status = status;
        this.r = r;
        this.dateCreated = dateCreated;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Role getR() {
        return r;
    }

    public void setR(Role r) {
        this.r = r;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", User.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("name='" + name + "'")
                .add("email='" + email + "'")
                .add("role=" + role)
                .add("avatar='" + avatar + "'")
                .add("status=" + status)
                .toString();
    }

    public static class SortByEmail implements Comparator<User> {

        @Override
        public int compare(User q1, User q2) {
            return q1.getEmail().compareTo(q2.getEmail());
        }

    }

    public static class SortByName implements Comparator<User> {

        @Override
        public int compare(User q1, User q2) {
            return q1.getName().compareTo(q2.getName());
        }

    }

    public static class SortByRole implements Comparator<User> {

        @Override
        public int compare(User q1, User q2) {
            return q1.getRole() - q2.getRole();
        }

    }

    public static class SortByStatus implements Comparator<User> {

        @Override
        public int compare(User q1, User q2) {
            return q2.getStatus() - q1.getStatus();
        }

    }

}
