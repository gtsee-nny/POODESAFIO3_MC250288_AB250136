package udb.biblioteca;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


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
}