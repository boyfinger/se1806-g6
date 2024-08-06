package model.flashcard;

public class FlashcardAnswer {
    private int QuestionId;
    private String Answer;

    public FlashcardAnswer() {
    }

    public FlashcardAnswer(String answer, int questionId) {
        Answer = answer;
        QuestionId = questionId;
    }

    public int getQuestionId() {
        return QuestionId;
    }

    public void setQuestionId(int questionId) {
        QuestionId = questionId;
    }

    public String getAnswer() {
        return Answer;
    }

    public void setAnswer(String answer) {
        Answer = answer;
    }
}
