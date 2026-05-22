package udb.biblioteca;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JavaBean que representa la tabla estudiantes.
 * Proporciona métodos para listar, insertar y eliminar estudiantes.
 */
public class EstudianteBean {

    private int    idEstudiante;
    private String carnet;
    private String nombreEstudiante;
    private String carrera;
    private String telefono;

    public EstudianteBean() {}


    public int getIdEstudiante() {
        return idEstudiante;
    }
    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public String getCarnet() {
        return carnet;
    }
    public void setCarnet(String carnet) {
        this.carnet = carnet;
    }

    public String getNombreEstudiante() {
        return nombreEstudiante;
    }
    public void setNombreEstudiante(String nombreEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
    }

    public String getCarrera() {
        return carrera;
    }
    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getTelefono() {
        return telefono;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    // Métodos de lógica de negocio

    /*
      Retorna todos los estudiantes registrados en la base de datos.
      @param conn Conexión JDBC activa
      @return Lista de objetos EstudianteBean
      @throws SQLException si ocurre un error al consultar
     */

    // Obtiene la lista de estudiantes para mostrarla en formularios o tablas
    public List<EstudianteBean> getListaEstudiantes(Connection conn) throws SQLException {
        List<EstudianteBean> lista = new ArrayList<>();

        String sql = "SELECT id_estudiante, carnet, nombre_estudiante, carrera, telefono " +
                "FROM estudiantes ORDER BY nombre_estudiante";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                EstudianteBean est = new EstudianteBean();
                est.setIdEstudiante(rs.getInt("id_estudiante"));
                est.setCarnet(rs.getString("carnet"));
                est.setNombreEstudiante(rs.getString("nombre_estudiante"));
                est.setCarrera(rs.getString("carrera"));
                est.setTelefono(rs.getString("telefono"));
                lista.add(est);
            }
        }
        return lista;
    }

    /*
     Inserta un nuevo estudiante en la base de datos.
     @param conn Conexión JDBC activa
     @throws SQLException si ocurre un error al insertar
     */

    // Inserta un estudiante nuevo en la base de datos
    public void insertar(Connection conn) throws SQLException {
        String sql = "INSERT INTO estudiantes (carnet, nombre_estudiante, carrera, telefono) " +
                "VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.carnet);
            ps.setString(2, this.nombreEstudiante);
            ps.setString(3, this.carrera);
            ps.setString(4, this.telefono);
            ps.executeUpdate();
        }
    }

    /**
     * Elimina el estudiante identificado por `idEstudiante` junto con sus préstamos.
     * Si el estudiante tiene préstamos activos, restaura la cantidad disponible de los libros.
     * @param conn Conexión JDBC activa
     * @throws SQLException si hay un error al eliminar
     */
    public void eliminar(Connection conn) throws SQLException {
        // Ajustar stock para libros que estén prestados y asociados al estudiante
        String sqlSelectPrestamos = "SELECT id_libro, estado FROM prestamos WHERE id_estudiante = ?";
        try (PreparedStatement psSelect = conn.prepareStatement(sqlSelectPrestamos)) {
            psSelect.setInt(1, this.idEstudiante);
            try (ResultSet rs = psSelect.executeQuery()) {
                while (rs.next()) {
                    String estadoPrestamo = rs.getString("estado");
                    if ("Activo".equalsIgnoreCase(estadoPrestamo)) {
                        int idLibro = rs.getInt("id_libro");
                        String sqlUpdateLibro = "UPDATE libros SET cantidad_disponible = cantidad_disponible + 1 WHERE id_libro = ?";
                        try (PreparedStatement psUpdateLibro = conn.prepareStatement(sqlUpdateLibro)) {
                            psUpdateLibro.setInt(1, idLibro);
                            psUpdateLibro.executeUpdate();
                        }
                    }
                }
            }
        }

        // Borrar los préstamos del estudiante antes de eliminar el estudiante
        String sqlDeletePrestamos = "DELETE FROM prestamos WHERE id_estudiante = ?";
        try (PreparedStatement psDeletePrestamos = conn.prepareStatement(sqlDeletePrestamos)) {
            psDeletePrestamos.setInt(1, this.idEstudiante);
            psDeletePrestamos.executeUpdate();
        }

        String sqlDeleteEstudiante = "DELETE FROM estudiantes WHERE id_estudiante = ?";
        try (PreparedStatement psDeleteEstudiante = conn.prepareStatement(sqlDeleteEstudiante)) {
            psDeleteEstudiante.setInt(1, this.idEstudiante);
            int updated = psDeleteEstudiante.executeUpdate();
            if (updated == 0) {
                throw new SQLException("No se encontró el estudiante a eliminar.");
            }
        }
    }

    /**
     * Actualiza los datos del estudiante existente.
     */
    public void actualizar(Connection conn) throws SQLException {
        String sql = "UPDATE estudiantes SET carnet = ?, nombre_estudiante = ?, carrera = ?, telefono = ? " +
                "WHERE id_estudiante = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, this.carnet);
            ps.setString(2, this.nombreEstudiante);
            ps.setString(3, this.carrera);
            ps.setString(4, this.telefono);
            ps.setInt(5, this.idEstudiante);
            ps.executeUpdate();
        }
    }

    /**
     * Obtiene un estudiante por su ID para cargarlo en el formulario de edición.
     */
    public EstudianteBean getEstudiantePorId(Connection conn, int idEstudiante) throws SQLException {
        String sql = "SELECT id_estudiante, carnet, nombre_estudiante, carrera, telefono " +
                "FROM estudiantes WHERE id_estudiante = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EstudianteBean est = new EstudianteBean();
                    est.setIdEstudiante(rs.getInt("id_estudiante"));
                    est.setCarnet(rs.getString("carnet"));
                    est.setNombreEstudiante(rs.getString("nombre_estudiante"));
                    est.setCarrera(rs.getString("carrera"));
                    est.setTelefono(rs.getString("telefono"));
                    return est;
                }
            }
        }
        return new EstudianteBean();
    }

    /**
     * Indica si el estudiante tiene préstamos activos (pendientes).
     * @param conn Conexión JDBC activa
     * @return true si hay préstamos con estado 'Activo'
     * @throws SQLException si ocurre un error de BD
     */
    public boolean tienePrestamosPendientes(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM prestamos WHERE id_estudiante = ? AND estado = 'Activo'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, this.idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total") > 0;
                }
            }
        }
        return false;
    }
}