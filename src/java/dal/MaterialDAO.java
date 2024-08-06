package dal;

import model.Material;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MaterialDAO extends DBContext implements Serializable {

    public MaterialDAO() {
    }

    private Material getMaterialInfo(ResultSet rs) throws SQLException {
        Material m = new Material();

        m.setId(rs.getInt("id"));
        String uri = rs.getString("uri");
        m.setUri(uri);

        String[] parts = uri.split("/");
        m.setName(parts[parts.length - 1]);

        return m;
    }

    public ArrayList<Material> getAllMaterialOfALesson(int lessonId) {
        ArrayList<Material> ret = new ArrayList<>();
        String sql = "select * from material where id in ("
                + "select material_id from material_lesson where lesson_id = ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lessonId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Material m = getMaterialInfo(rs);
                ret.add(m);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return ret;
    }

    public boolean isMaterialExist(int lessonId, String uri)
            throws SQLException {
        String sql = "select m.uri as uri "
                + "from material m join material_lesson ml where "
                + "m.id = ml.material_id "
                + "and uri = ? "
                + "and ml.lesson_id = ?; ";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, uri);
        st.setInt(2, lessonId);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return true;
        }
        return false;
    }

    private void insertIntoMaterial(String uri) throws SQLException {
        String sql = "insert into material(uri) values (?);";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, uri);
        st.execute();
    }

    private void insertIntoMaterial_Lesson(int lessonId, String uri) throws SQLException {
        String sql = "insert into material_lesson(lesson_id, material_id)"
                + "values (?,"
                + "(select id from material where uri = ?))";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, lessonId);
        st.setString(2, uri);
        st.execute();
    }

    private boolean getMaterialByUri(String uri) {
        String sql = "select * from material where uri = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, uri);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public void insertMaterial(int lessonId, String uri) throws SQLException {
        if (!getMaterialByUri(uri)) {
            insertIntoMaterial(uri);
        }
        insertIntoMaterial_Lesson(lessonId, uri);
    }

    public void removeFromMaterial_Lesson(int lessonId, int materialId) throws SQLException {
        String sql = "delete from material_lesson where"
                + " lesson_id = ? and material_id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, lessonId);
        st.setInt(2, materialId);
        st.execute();
    }

    public boolean isMaterialUsed(int materialId) throws SQLException {
        String sql = "select * from material_lesson where material_id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, materialId);
        ResultSet rs = st.executeQuery();
        return rs.next();
    }

    public Material getMaterialMatchId(int materialId) throws SQLException {
        String sql = "select * from material where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, materialId);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return getMaterialInfo(rs);
        }
        return null;
    }

    public void removeMaterial(Material m) throws SQLException {
        String sql = "delete from material where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, m.getId());
        st.execute();
    }

}
