package model;

public class Material {

    int id;
    String uri, name, webUri;

    public Material() {
    }

    public Material(int id, String uri, String name, String webUri) {
        this.id = id;
        this.uri = uri;
        this.name = name;
        this.webUri = webUri;
    }

    public String getWebUri() {
        return webUri;
    }

    public void setWebUri(String webUri) {
        this.webUri = webUri;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
