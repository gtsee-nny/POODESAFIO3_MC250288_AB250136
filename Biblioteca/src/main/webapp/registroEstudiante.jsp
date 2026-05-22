<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar Estudiante</title>
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
    <h3>Registrar Estudiante</h3>
    <hr>

    <%-- Mostrar error si viene redirigido --%>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>

    <!-- Formulario para registrar estudiantes -->
    <form action="controllerEstudiante.jsp" method="POST">
        <div class="mb-3">
            <label class="form-label">Carnet</label>
            <input type="text" name="carnet" class="form-control" maxlength="10" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Nombre completo</label>
            <input type="text" name="nombreEstudiante" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Carrera</label>
            <input type="text" name="carrera" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono</label>
            <input type="text" name="telefono" class="form-control" maxlength="9">
        </div>
        <button type="submit" class="btn btn-dark">Registrar</button>
        <a href="index.jsp" class="btn btn-secondary ms-2">Cancelar</a>
    </form>
</div>

</body>
</html>
