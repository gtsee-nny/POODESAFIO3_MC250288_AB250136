<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.EstudianteBean" %>
<%@ page import="udb.biblioteca.LibroBean" %>
<%@ include file="conexion.jsp" %>
<%-- Página para registrar nuevos préstamos. --%>
<%-- Carga estudiantes y libros desde la base de datos y valida disponibilidad del libro. --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar Préstamo — Biblioteca UDB</title>
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
            <a class="nav-link active" href="registroPrestamo.jsp">Registrar Préstamo</a>
            <a class="nav-link" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<div class="container mt-page">
    <div class="page-header">
        <h3>🔖 Registrar Préstamo</h3>
        <p class="subtitle">Asigna un libro a un estudiante y define el período de préstamo.</p>
    </div>
    <hr class="section-divider">

    <% if (request.getParameter("error") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("error") %></div>
    <% } %>

    <div class="form-card">
        <form action="controllerPrestamo.jsp" method="POST">

            <div class="mb-3">
                <label class="form-label">Estudiante</label>
                <select name="idEstudiante" class="form-select" required>
                    <option value="">— Seleccione un estudiante —</option>
                    <%
                        EstudianteBean estBean = new EstudianteBean();
                        List<EstudianteBean> estudiantes = estBean.getListaEstudiantes(conn);
                        for (EstudianteBean e : estudiantes) {
                    %>
                    <option value="<%= e.getIdEstudiante() %>">
                        <%= e.getCarnet() %> — <%= e.getNombreEstudiante() %>
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Libro</label>
                <select name="idLibro" class="form-select" required>
                    <option value="">— Seleccione un libro —</option>
                    <%
                        LibroBean libBean = new LibroBean();
                        List<LibroBean> libros = libBean.getListaLibros(conn);
                        for (LibroBean l : libros) {
                    %>
                    <option value="<%= l.getIdLibro() %>"
                            <%= l.getCantidadDisponible() == 0 ? "disabled" : "" %>>
                        <%= l.getTitulo() %> — <%= l.getAutor() %>
                        (<%= l.getCantidadDisponible() %> disponibles)
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Fecha de préstamo</label>
                    <input type="date" name="fechaPrestamo" class="form-control" required>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">Fecha de devolución</label>
                    <input type="date" name="fechaDevolucion" class="form-control" required>
                </div>
            </div>

            <div class="d-flex gap-btn">
                <button type="submit" class="btn-submit">Registrar préstamo</button>
                <a href="index.jsp" class="btn-udb-secondary">Cancelar</a>
            </div>

        </form>
    </div>
</div>

</body>
</html>
