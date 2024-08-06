package model;

public class Answer {

    private int id;
    private String content;
    private boolean isCorrect;
    private Question question;

    public Answer() {
    }

    public Answer(int id, String content, boolean isCorrect, Question question) {
        this.id = id;
        this.content = content;
        this.isCorrect = isCorrect;
        this.question = question;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

}
