package udb.biblioteca;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JavaBean para la tabla libros.
 * Representa un libro con relación a su categoría y ofrece métodos CRUD.
 */
public class LibroBean {

    private int          idLibro;
    private String       titulo;
    private String       autor;
    private String       isbn;
    private int          idCategoria;          // FK hacia categorias
    private int          cantidadDisponible;
    private CategoriaBean categoria;           // objeto relacionado


    public LibroBean() {
        this.categoria = new CategoriaBean();
    }


    public int getIdLibro() {
        return idLibro;
    }
    public void setIdLibro(int idLibro) {
        this.idLibro = idLibro;
    }

    public String getTitulo() {
        return titulo;
    }
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }
    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getIsbn() {
        return isbn;
    }
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public int getIdCategoria() {
        return idCategoria;
    }
    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getCantidadDisponible() {
        return cantidadDisponible;
    }
    public void setCantidadDisponible(int cantidadDisponible) {
        this.cantidadDisponible = cantidadDisponible;
    }

    public CategoriaBean getCategoria() {
        return categoria;
    }
    public void setCategoria(CategoriaBean categoria) {
        this.categoria = categoria;
    }

    // Métodos de lógica de negocio

    /*
      Retorna el nombre de la categoría asociada al libro.
      Útil para mostrarlo directamente en las vistas JSP.
      @return nombre de la categoría o cadena vacía si no hay categoría asignada
     */
    public String getNombreCategoria() {
        if (categoria != null) {
            return categoria.getNombreCategoria();
        }
        return "";
    }

    /**
     * Retorna todos los libros almacenados en la base de datos,
     * incluyendo el nombre de su categoría mediante un JOIN.
     * @param conn Conexión JDBC activa
     * @return Lista de objetos LibroBean
     * @throws SQLException si ocurre un error al consultar la base de datos
     */
    public List<LibroBean> getListaLibros(Connection conn) throws SQLException {
        List<LibroBean> lista = new ArrayList<>();

        String sql = "SELECT l.id_libro, l.titulo, l.autor, l.isbn, " +
                "       l.id_categoria, l.cantidad_disponible, " +
                "       c.nombre_categoria " +
                "FROM libros l " +
                "LEFT JOIN categorias c ON l.id_categoria = c.id_categoria " +
                "ORDER BY l.titulo";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LibroBean libro = new LibroBean();
                libro.setIdLibro(rs.getInt("id_libro"));
                libro.setTitulo(rs.getString("titulo"));
                libro.setAutor(rs.getString("autor"));
                libro.setIsbn(rs.getString("isbn"));
                libro.setIdCategoria(rs.getInt("id_categoria"));
                libro.setCantidadDisponible(rs.getInt("cantidad_disponible"));

                // Poblar el objeto categoría relacionado
                CategoriaBean cat = new CategoriaBean();
                cat.setIdCategoria(rs.getInt("id_categoria"));
                cat.setNombreCategoria(rs.getString("nombre_categoria"));
                libro.setCategoria(cat);

                lista.add(libro);
            }
        }
        return lista;
    }

    /**
     * Inserta un nuevo libro en la base de datos.
     * @param conn Conexión JDBC activa
     * @throws SQLException si ocurre un error al insertar
     */
    public void insertar(Connection conn) throws SQLException {
        String sql = "INSERT INTO libros (titulo, autor, isbn, id_categoria, cantidad_disponible) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.titulo);
            ps.setString(2, this.autor);
            ps.setString(3, this.isbn);
            ps.setInt(4, this.idCategoria);
            ps.setInt(5, this.cantidadDisponible);
            ps.executeUpdate();
        }
    }

    /**
     * Actualiza los datos de un libro existente.
     */
    public void actualizar(Connection conn) throws SQLException {
        String sql = "UPDATE libros SET titulo = ?, autor = ?, isbn = ?, id_categoria = ?, cantidad_disponible = ? " +
                "WHERE id_libro = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.titulo);
            ps.setString(2, this.autor);
            ps.setString(3, this.isbn);
            ps.setInt(4, this.idCategoria);
            ps.setInt(5, this.cantidadDisponible);
            ps.setInt(6, this.idLibro);
            ps.executeUpdate();
        }
    }

    /**
     * Elimina el libro y sus préstamos asociados de la base de datos.
     */
    public void eliminar(Connection conn) throws SQLException {
        String sqlDeletePrestamos = "DELETE FROM prestamos WHERE id_libro = ?";
        try (PreparedStatement psPrestamos = conn.prepareStatement(sqlDeletePrestamos)) {
            psPrestamos.setInt(1, this.idLibro);
            psPrestamos.executeUpdate();
        }

        String sqlDeleteLibro = "DELETE FROM libros WHERE id_libro = ?";
        try (PreparedStatement psLibro = conn.prepareStatement(sqlDeleteLibro)) {
            psLibro.setInt(1, this.idLibro);
            int updated = psLibro.executeUpdate();
            if (updated == 0) {
                throw new SQLException("No se encontró el libro a eliminar.");
            }
        }
    }

    /**
     * Recupera un libro por su ID para cargarlo en el formulario de edición.
     */
    public LibroBean getLibroPorId(Connection conn, int idLibro) throws SQLException {
        String sql = "SELECT l.id_libro, l.titulo, l.autor, l.isbn, l.id_categoria, l.cantidad_disponible, c.nombre_categoria " +
                "FROM libros l LEFT JOIN categorias c ON l.id_categoria = c.id_categoria WHERE l.id_libro = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLibro);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LibroBean libro = new LibroBean();
                    libro.setIdLibro(rs.getInt("id_libro"));
                    libro.setTitulo(rs.getString("titulo"));
                    libro.setAutor(rs.getString("autor"));
                    libro.setIsbn(rs.getString("isbn"));
                    libro.setIdCategoria(rs.getInt("id_categoria"));
                    libro.setCantidadDisponible(rs.getInt("cantidad_disponible"));

                    CategoriaBean cat = new CategoriaBean();
                    cat.setIdCategoria(rs.getInt("id_categoria"));
                    cat.setNombreCategoria(rs.getString("nombre_categoria"));
                    libro.setCategoria(cat);
                    return libro;
                }
            }
        }
        return new LibroBean();
    }
}
