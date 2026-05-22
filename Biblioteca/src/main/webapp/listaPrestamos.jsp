<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.PrestamoBean" %>
<%@ include file="conexion.jsp" %>
<%-- Página que muestra todos los préstamos registrados. --%>
<%-- Incluye estado visual y botón para devolver préstamos activos. --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lista de Préstamos — Biblioteca UDB</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Biblioteca UDB</a>
        <div class="navbar-nav ms-auto d-flex flex-row gap-1">
            <a class="nav-link" href="registroLibro.jsp">Registrar Libro</a>
            <a class="nav-link" href="registroEstudiante.jsp">Registrar Estudiante</a>
            <a class="nav-link" href="registroPrestamo.jsp">Registrar Préstamo</a>
            <a class="nav-link active" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<div class="container mt-page">
    <div class="page-header">
        <h3>📋 Lista de Préstamos</h3>
        <p class="subtitle">Historial de préstamos activos, vencidos y devueltos.</p>
    </div>
    <hr class="section-divider">

    <% if (request.getParameter("devuelto") != null) { %>
    <div class="alert-success-udb mb-3">✅ Devolución registrada correctamente.</div>
    <% } %>
    <% if (request.getParameter("deleted") != null) { %>
    <div class="alert-success-udb mb-3">✅ Registro de préstamo devuelto eliminado correctamente.</div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("error") %></div>
    <% } %>

    <%
        // Obtener todos los préstamos con datos completos de estudiante y libro.
        PrestamoBean prestamoBean = new PrestamoBean();
        List<PrestamoBean> lista = prestamoBean.getListaPrestamos(conn);
    %>

    <div class="table-wrapper">
        <table class="table-udb">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Estudiante</th>
                    <th>Carnet</th>
                    <th>Libro</th>
                    <th>Fecha Préstamo</th>
                    <th>Fecha Devolución</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (PrestamoBean p : lista) {
                    String estadoVisual = p.getEstadoPrestamo();
                    String badgeClass = "badge-active";
                    if (estadoVisual.equals("Vencido"))  badgeClass = "badge-expired";
                    if (estadoVisual.equals("Devuelto")) badgeClass = "badge-returned";
            %>
                <tr>
                    <td><span class="text-muted-udb">#<%= p.getIdPrestamo() %></span></td>
                    <td><strong><%= p.getEstudiante().getNombreEstudiante() %></strong></td>
                    <td><span class="text-muted-udb"><%= p.getEstudiante().getCarnet() %></span></td>
                    <td><%= p.getLibro().getTitulo() %></td>
                    <td><%= p.getFechaPrestamo() %></td>
                    <td><%= p.getFechaDevolucion() %></td>
                    <td><span class="badge-udb <%= badgeClass %>"><%= estadoVisual %></span></td>
                    <td>
                        <%-- Mostrar acción según si el préstamo está activo o ya fue devuelto. --%>
                        <% if (!estadoVisual.equals("Devuelto")) { %>
                            <a href="controllerDevolucion.jsp?idPrestamo=<%= p.getIdPrestamo() %>&idLibro=<%= p.getIdLibro() %>"
                               class="btn-udb-danger"
                               onclick="return confirm('¿Confirmar devolución?')">
                                Devolver
                            </a>
                        <% } else { %>
                            <a href="controllerPrestamo.jsp?action=delete&idPrestamo=<%= p.getIdPrestamo() %>"
                               class="btn-udb-secondary"
                               onclick="return confirm('¿Eliminar este registro de préstamo devuelto?')">
                                Eliminar registro
                            </a>
                        <% } %>
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
