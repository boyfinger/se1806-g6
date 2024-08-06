package model.flashcard;

public class Flashcard {
    private int FlashcardSetId;
    private String Name;
    private int SubjectId;
    private String SubjectName;
    private String SubjectCode;
    private int NumQuestions;

    public Flashcard() {
    }

    public Flashcard(int flashcardSetId, String name, int subjectId, String subjectName, String subjectCode, int numQuestions) {
        FlashcardSetId = flashcardSetId;
        Name = name;
        SubjectId = subjectId;
        SubjectName = subjectName;
        SubjectCode = subjectCode;
        NumQuestions = numQuestions;
    }

    public int getFlashcardSetId() {

        return FlashcardSetId;
    }

    public void setFlashcardSetId(int flashcardSetId) {
        FlashcardSetId = flashcardSetId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
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

    public String getSubjectCode() {
        return SubjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        SubjectCode = subjectCode;
    }

    public int getNumQuestions() {
        return NumQuestions;
    }

    public void setNumQuestions(int numQuestions) {
        NumQuestions = numQuestions;
    }
}
