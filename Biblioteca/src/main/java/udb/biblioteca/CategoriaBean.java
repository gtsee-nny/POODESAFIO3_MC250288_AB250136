package udb.biblioteca;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JavaBean que representa la tabla categorias.
 * Contiene atributos simples y métodos para consultar e insertar categorías.
 */
public class CategoriaBean {

    private int    idCategoria;
    private String nombreCategoria;


    public CategoriaBean() {}

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }


    //  Métodos de lógica de negocio

    /*
      Retorna todas las categorías almacenadas en la base de datos.
      @param conn Conexión JDBC activa (obtenida desde conexion.jsp)
      @return Lista de objetos CategoriaBean
      @throws SQLException si ocurre un error al consultar la base de datos
     */

    // Este metodoo obtiene todas las categorías de la BD y las manda a donde se necesiten mostrar
    public List<CategoriaBean> getListaCategorias(Connection conn) throws SQLException {
        List<CategoriaBean> lista = new ArrayList<>();

        String sql = "SELECT id_categoria, nombre_categoria FROM categorias ORDER BY nombre_categoria";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CategoriaBean cat = new CategoriaBean();
                cat.setIdCategoria(rs.getInt("id_categoria"));
                cat.setNombreCategoria(rs.getString("nombre_categoria"));
                lista.add(cat);
            }
        }
        return lista;
    }

    private boolean existeCategoria(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM categorias WHERE LOWER(TRIM(nombre_categoria)) = LOWER(TRIM(?))";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.getNombreCategoria());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total") > 0;
                }
            }
        }
        return false;
    }

    /*
     Inserta una nueva categoría en la base de datos.
     @param conn Conexión JDBC activa
     @throws SQLException si ocurre un error al insertar
     */

    // Este metodoo inserta una nueva categoría en la base de datos
    public void insertar(Connection conn) throws SQLException {
        if (this.getNombreCategoria() == null || this.getNombreCategoria().trim().isEmpty()) {
            throw new SQLException("El nombre de categoría no puede estar vacío.");
        }

        if (existeCategoria(conn)) {
            throw new SQLException("La categoría ya existe.");
        }

        String sql = "INSERT INTO categorias (nombre_categoria) VALUES (?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.getNombreCategoria().trim());
            ps.executeUpdate();
        }
    }

    /**
     * Elimina una categoría si no tiene libros asociados.
     */
    public void eliminar(Connection conn) throws SQLException {
        String sqlCheck = "SELECT COUNT(*) AS total FROM libros WHERE id_categoria = ?";
        try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
            psCheck.setInt(1, this.idCategoria);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next() && rs.getInt("total") > 0) {
                    throw new SQLException("No se puede eliminar la categoría porque tiene libros asociados.");
                }
            }
        }

        String sqlDelete = "DELETE FROM categorias WHERE id_categoria = ?";
        try (PreparedStatement psDelete = conn.prepareStatement(sqlDelete)) {
            psDelete.setInt(1, this.idCategoria);
            int deleted = psDelete.executeUpdate();
            if (deleted == 0) {
                throw new SQLException("Categoría no encontrada.");
            }
        }
    }

}