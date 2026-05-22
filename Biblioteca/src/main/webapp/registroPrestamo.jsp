<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.EstudianteBean" %>
<%@ page import="udb.biblioteca.LibroBean" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar Préstamo</title>
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
            <a class="nav-link" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>Registrar Préstamo</h3>
    <hr>

    <%-- Mostrar error si el libro no tiene disponibilidad --%>
    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>

    <form action="controllerPrestamo.jsp" method="POST">

        <%-- Select dinámico de estudiantes --%>
        <div class="mb-3">
            <label class="form-label">Estudiante</label>
            <select name="idEstudiante" class="form-select" required>
                <option value="">-- Seleccione un estudiante --</option>
                <%
                    EstudianteBean estBean = new EstudianteBean();
                    List<EstudianteBean> estudiantes = estBean.getListaEstudiantes(conn);
                    for (EstudianteBean e : estudiantes) {
                %>
                    <option value="<%= e.getIdEstudiante() %>">
                        <%= e.getCarnet() %> - <%= e.getNombreEstudiante() %>
                    </option>
                <%
                    }
                %>
            </select>
        </div>

        <%-- Select dinámico de libros (solo los que tienen disponibilidad) --%>
        <div class="mb-3">
            <label class="form-label">Libro</label>
            <select name="idLibro" class="form-select" required>
                <option value="">-- Seleccione un libro --</option>
                <%
                    LibroBean libBean = new LibroBean();
                    List<LibroBean> libros = libBean.getListaLibros(conn);
                    for (LibroBean l : libros) {
                %>
                    <option value="<%= l.getIdLibro() %>"
                        <%= l.getCantidadDisponible() == 0 ? "disabled" : "" %>>
                        <%= l.getTitulo() %> - <%= l.getAutor() %>
                        (<%= l.getCantidadDisponible() %> disponibles)
                    </option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Fecha de préstamo</label>
            <input type="date" name="fechaPrestamo" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Fecha de devolución</label>
            <input type="date" name="fechaDevolucion" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-dark">Registrar</button>
        <a href="index.jsp" class="btn btn-secondary ms-2">Cancelar</a>
    </form>
</div>

</body>
</html>
