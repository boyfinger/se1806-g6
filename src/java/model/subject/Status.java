package model.subject;

public enum Status {

    active, inactive;

    public static String getStringFromInt(int status) {
        switch (getStatusFromInt(status)) {
            case inactive:
                return "Inactive";
            case active:
                return "Active";
            default:
                throw new AssertionError();
        }
    }

    public static Status getStatusFromInt(int status) {
        switch (status) {
            case 0:
                return inactive;
            case 1:
                return active;
            default:
                throw new AssertionError();
        }
    }

}
