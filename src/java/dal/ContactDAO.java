package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.contact.Contact;

public class ContactDAO extends DBContext {

    public void newContact(Contact c) throws SQLException {
        String sql = "insert into contact(name, email, subject, message) values (?,?,?,?);";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, c.getName());
        st.setString(2, c.getEmail());
        st.setString(3, c.getSubject());
        st.setString(4, c.getMessage());
        st.execute();
    }
}
