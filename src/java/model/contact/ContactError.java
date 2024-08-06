package model.contact;

public class ContactError {

    private String nameErr, phoneErr, emailErr, subjectErr, messageErr;

    public ContactError() {
    }

    public ContactError(String nameErr, String phoneErr, String emailErr, String subjectErr, String messageErr) {
        this.nameErr = nameErr;
        this.phoneErr = phoneErr;
        this.emailErr = emailErr;
        this.subjectErr = subjectErr;
        this.messageErr = messageErr;
    }

    public String getNameErr() {
        return nameErr;
    }

    public void setNameErr(String nameErr) {
        this.nameErr = nameErr;
    }

    public String getPhoneErr() {
        return phoneErr;
    }

    public void setPhoneErr(String phoneErr) {
        this.phoneErr = phoneErr;
    }

    public String getEmailErr() {
        return emailErr;
    }

    public void setEmailErr(String emailErr) {
        this.emailErr = emailErr;
    }

    public String getSubjectErr() {
        return subjectErr;
    }

    public void setSubjectErr(String subjectErr) {
        this.subjectErr = subjectErr;
    }

    public String getMessageErr() {
        return messageErr;
    }

    public void setMessageErr(String messageErr) {
        this.messageErr = messageErr;
    }

}
