package model.google;

public class GooglePojo {

    private String id;
    private String email;
    private boolean verified_email;
    private String name;
    private String given_name;
    private String family_name;
    private String link;
    private String picture;

    public GooglePojo() {
    }

    public GooglePojo(String name, String id, String email, boolean verified_email, String given_name, String family_name, String link, String picture) {
        this.name = name;
        this.id = id;
        this.email = email;
        this.verified_email = verified_email;
        this.given_name = given_name;
        this.family_name = family_name;
        this.link = link;
        this.picture = picture;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isVerified_email() {
        return verified_email;
    }

    public void setVerified_email(boolean verified_email) {
        this.verified_email = verified_email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGiven_name() {
        return given_name;
    }

    public void setGiven_name(String given_name) {
        this.given_name = given_name;
    }

    public String getFamily_name() {
        return family_name;
    }

    public void setFamily_name(String family_name) {
        this.family_name = family_name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("GooglePojo{");
        sb.append("id='").append(id).append('\'');
        sb.append(", email='").append(email).append('\'');
        sb.append(", verified_email=").append(verified_email);
        sb.append(", name='").append(name).append('\'');
        sb.append(", given_name='").append(given_name).append('\'');
        sb.append(", family_name='").append(family_name).append('\'');
        sb.append(", link='").append(link).append('\'');
        sb.append(", picture='").append(picture).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
