package udb.biblioteca;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * JavaBean que representa la entidad Prestamo.
 * Corresponde a la tabla 'prestamoss' en la base de datos bibliotecaudb.
 * Incluye objetos LibroBean y EstudianteBean para representar las relaciones FK.
 */
public class PrestamoBean {

    private int            idPrestamo;
    private int            idEstudiante;       // FK hacia estudiantes
    private int            idLibro;            // FK hacia libros
    private String         fechaPrestamo;      // formato YYYY-MM-DD
    private String         fechaDevolucion;    // formato YYYY-MM-DD
    private String         estado;             // 'Activo' | 'Devuelto'

    // Objetos relacionados (no mapeados directamente al formulario)
    private EstudianteBean estudiante;
    private LibroBean      libro;

    public PrestamoBean() {
        this.estado     = "Activo";
        this.estudiante = new EstudianteBean();
        this.libro      = new LibroBean();
    }


    public int getIdPrestamo() {
        return idPrestamo;
    }
    public void setIdPrestamo(int idPrestamo) {
        this.idPrestamo = idPrestamo;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }
    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public int getIdLibro() {
        return idLibro;
    }
    public void setIdLibro(int idLibro) {
        this.idLibro = idLibro;
    }

    public String getFechaPrestamo() {
        return fechaPrestamo;
    }
    public void setFechaPrestamo(String fechaPrestamo) {
        this.fechaPrestamo = fechaPrestamo;
    }

    public String getFechaDevolucion() {
        return fechaDevolucion;
    }
    public void setFechaDevolucion(String fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }

    public EstudianteBean getEstudiante() {
        return estudiante;
    }
    public void setEstudiante(EstudianteBean estudiante) {
        this.estudiante = estudiante;
    }

    public LibroBean getLibro() {
        return libro;
    }
    public void setLibro(LibroBean libro) {
        this.libro = libro;
    }

    //Métodos de lógica de negocio

    /**
     * Determina si el préstamo está vigente o vencido comparando la fecha
     * de devolución con la fecha actual del sistema.
     * Solo aplica a préstamos con estado 'Activo'.
     *
     * @return "Devuelto" si el préstamo fue devuelto,
     *         "Vigente"  si la fecha de devolución es hoy o futura,
     *         "Vencido"  si la fecha de devolución ya pasó y aún no fue devuelto.
     */
    public String getEstadoPrestamo() {
        if ("Devuelto".equalsIgnoreCase(this.estado)) {
            return "Devuelto";
        }
        if (this.fechaDevolucion == null || this.fechaDevolucion.isEmpty()) {
            return "Sin fecha";
        }

        LocalDate hoy        = LocalDate.now();
        LocalDate devolucion = LocalDate.parse(this.fechaDevolucion);

        return devolucion.isBefore(hoy) ? "Vencido" : "Vigente";
    }

    /**
     * Registra un nuevo préstamo en la base de datos.
     * Antes de insertar verifica que el libro tenga unidades disponibles;
     * si no las tiene lanza una excepción para evitar el préstamo.
     * Al insertar, descuenta una unidad del stock del libro.
     *
     * @param conn Conexión JDBC activa
     * @throws SQLException   si ocurre un error de base de datos
     * @throws Exception      si el libro no tiene unidades disponibles
     */
    public void insertar(Connection conn) throws Exception {

        // ── 1. Verificar disponibilidad del libro ───────────────────────────
        String sqlStock = "SELECT cantidad_disponible FROM libros WHERE id_libro = ?";
        int disponible = 0;

        try (PreparedStatement psStock = conn.prepareStatement(sqlStock)) {
            psStock.setInt(1, this.idLibro);
            try (ResultSet rs = psStock.executeQuery()) {
                if (rs.next()) {
                    disponible = rs.getInt("cantidad_disponible");
                }
            }
        }

        if (disponible <= 0) {
            throw new Exception("No hay unidades disponibles del libro seleccionado.");
        }

        // ── 2. Insertar el préstamo ─────────────────────────────────────────
        String sqlInsert = "INSERT INTO prestamos " +
                "(id_estudiante, id_libro, fecha_prestamo, fecha_devolucion, estado) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sqlInsert)) {
            ps.setInt(1, this.idEstudiante);
            ps.setInt(2, this.idLibro);
            ps.setString(3, this.fechaPrestamo);
            ps.setString(4, this.fechaDevolucion);
            ps.setString(5, this.estado);
            ps.executeUpdate();
        }

        // ── 3. Descontar una unidad del stock del libro ─────────────────────
        String sqlUpdate = "UPDATE libros SET cantidad_disponible = cantidad_disponible - 1 " +
                "WHERE id_libro = ?";

        try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
            psUpdate.setInt(1, this.idLibro);
            psUpdate.executeUpdate();
        }
    }

    /**
     * Marca un préstamo como 'Devuelto' e incrementa el stock del libro.
     *
     * @param conn       Conexión JDBC activa
     * @param idPrestamo ID del préstamo a devolver
     * @param idLibro    ID del libro asociado al préstamo
     * @throws SQLException si ocurre un error de base de datos
     */
    public void devolver(Connection conn, int idPrestamo, int idLibro) throws SQLException {

        // ── 1. Actualizar estado del préstamo a 'Devuelto' ──────────────────
        String sqlEstado = "UPDATE prestamos SET estado = 'Devuelto' WHERE id_prestamo = ?";

        try (PreparedStatement ps = conn.prepareStatement(sqlEstado)) {
            ps.setInt(1, idPrestamo);
            ps.executeUpdate();
        }

        // ── 2. Incrementar la cantidad disponible del libro ──────────────────
        String sqlStock = "UPDATE libros SET cantidad_disponible = cantidad_disponible + 1 " +
                "WHERE id_libro = ?";

        try (PreparedStatement psStock = conn.prepareStatement(sqlStock)) {
            psStock.setInt(1, idLibro);
            psStock.executeUpdate();
        }
    }

    /**
     * Retorna todos los préstamos con los datos completos del estudiante y libro,
     * usando JOINs para poblar los objetos relacionados.
     *
     * @param conn Conexión JDBC activa
     * @return Lista de objetos PrestamoBean completamente poblados
     * @throws SQLException si ocurre un error al consultar
     */
    public List<PrestamoBean> getListaPrestamos(Connection conn) throws SQLException {
        List<PrestamoBean> lista = new ArrayList<>();

        String sql = "SELECT p.id_prestamo, p.id_estudiante, p.id_libro, " +
                "       p.fecha_prestamo, p.fecha_devolucion, p.estado, " +
                "       e.carnet, e.nombre_estudiante, e.carrera, " +
                "       l.titulo, l.autor, l.isbn, l.cantidad_disponible " +
                "FROM prestamos p " +
                "JOIN estudiantes e ON p.id_estudiante = e.id_estudiante " +
                "JOIN libros      l ON p.id_libro      = l.id_libro " +
                "ORDER BY p.fecha_prestamo DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PrestamoBean p = new PrestamoBean();
                p.setIdPrestamo(rs.getInt("id_prestamo"));
                p.setIdEstudiante(rs.getInt("id_estudiante"));
                p.setIdLibro(rs.getInt("id_libro"));
                p.setFechaPrestamo(rs.getString("fecha_prestamo"));
                p.setFechaDevolucion(rs.getString("fecha_devolucion"));
                p.setEstado(rs.getString("estado"));

                // Poblar estudiante relacionado
                EstudianteBean est = new EstudianteBean();
                est.setIdEstudiante(rs.getInt("id_estudiante"));
                est.setCarnet(rs.getString("carnet"));
                est.setNombreEstudiante(rs.getString("nombre_estudiante"));
                est.setCarrera(rs.getString("carrera"));
                p.setEstudiante(est);

                // Poblar libro relacionado
                LibroBean lib = new LibroBean();
                lib.setIdLibro(rs.getInt("id_libro"));
                lib.setTitulo(rs.getString("titulo"));
                lib.setAutor(rs.getString("autor"));
                lib.setIsbn(rs.getString("isbn"));
                lib.setCantidadDisponible(rs.getInt("cantidad_disponible"));
                p.setLibro(lib);

                lista.add(p);
            }
        }
        return lista;
    }
}