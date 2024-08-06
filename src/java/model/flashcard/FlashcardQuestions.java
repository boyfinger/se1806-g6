package model.flashcard;

public class FlashcardQuestions {
    private int FlashcardSetId;
    private int QuestionId;
    private String Term;
    private String Definition;

    public FlashcardQuestions() {
    }

    public FlashcardQuestions(int flashcardSetId, int questionId, String term, String definition) {
        FlashcardSetId = flashcardSetId;
        QuestionId = questionId;
        Term = term;
        Definition = definition;
    }

    public int getFlashcardSetId() {
        return FlashcardSetId;
    }

    public void setFlashcardSetId(int flashcardSetId) {
        FlashcardSetId = flashcardSetId;
    }

    public int getQuestionId() {
        return QuestionId;
    }

    public void setQuestionId(int questionId) {
        QuestionId = questionId;
    }

    public String getTerm() {
        return Term;
    }

    public void setTerm(String term) {
        Term = term;
    }

    public String getDefinition() {
        return Definition;
    }

    public void setDefinition(String definition) {
        Definition = definition;
    }
}
