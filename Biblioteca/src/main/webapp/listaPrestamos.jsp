<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.PrestamoBean" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lista de Préstamos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Biblioteca UDB</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="registroLibro.jsp">Registrar Libro</a>
            <a class="nav-link" href="registroEstudiante.jsp">Registrar Estudiante</a>
            <a class="nav-link" href="registroPrestamo.jsp">Registrar Préstamo</a>
            <a class="nav-link active" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>Lista de Préstamos</h3>
    <hr>

    <%-- Mensaje de éxito si viene de una devolución --%>
    <% if (request.getParameter("devuelto") != null) { %>
        <div class="alert alert-success">✅ Devolución registrada correctamente.</div>
    <% } %>

    <%
        // Obtener todos los préstamos desde el bean
        PrestamoBean prestamoBean = new PrestamoBean();
        List<PrestamoBean> lista = prestamoBean.getListaPrestamos(conn);
    %>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
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
                // Determinar el estado visual del préstamo
                String estadoVisual = p.getEstadoPrestamo();
                String badgeColor = "bg-success";
                if (estadoVisual.equals("Vencido"))   badgeColor = "bg-danger";
                if (estadoVisual.equals("Devuelto"))  badgeColor = "bg-secondary";
        %>
            <tr>
                <td><%= p.getIdPrestamo() %></td>
                <td><%= p.getEstudiante().getNombreEstudiante() %></td>
                <td><%= p.getEstudiante().getCarnet() %></td>
                <td><%= p.getLibro().getTitulo() %></td>
                <td><%= p.getFechaPrestamo() %></td>
                <td><%= p.getFechaDevolucion() %></td>
                <td><span class="badge <%= badgeColor %>"><%= estadoVisual %></span></td>
                <td>
                    <%-- Mostrar botón de devolución solo si el préstamo está activo --%>
                    <% if (!estadoVisual.equals("Devuelto")) { %>
                        <a href="controllerDevolucion.jsp?idPrestamo=<%= p.getIdPrestamo() %>&idLibro=<%= p.getIdLibro() %>"
                           class="btn btn-sm btn-warning"
                           onclick="return confirm('¿Confirmar devolución?')">
                            Devolver
                        </a>
                    <% } else { %>
                        <span class="text-muted">-</span>
                    <% } %>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
