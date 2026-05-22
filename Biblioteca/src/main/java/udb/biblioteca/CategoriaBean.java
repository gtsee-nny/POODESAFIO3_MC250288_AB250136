package udb.biblioteca;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;


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

    /*
     Inserta una nueva categoría en la base de datos.
     @param conn Conexión JDBC activa
     @throws SQLException si ocurre un error al insertar
     */

    // Este metodoo inserta una nueva categoría en la base de datos
    public void insertar(Connection conn) throws SQLException {
        String sql = "INSERT INTO categorias (nombre_categoria) VALUES (?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.getNombreCategoria());
            ps.executeUpdate();
        }
    }


}