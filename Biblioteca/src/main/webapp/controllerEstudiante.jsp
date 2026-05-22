<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%-- Crear el bean y asignar automáticamente todos los parámetros del formulario --%>
<jsp:useBean id="estudiante" class="udb.biblioteca.EstudianteBean" scope="request"/>
<jsp:setProperty name="estudiante" property="*"/>

<%
    // Insertar el estudiante en la base de datos usando el bean
    try {
        estudiante.insertar(conn);
    } catch (Exception e) {
        // Si hay error (ej: carnet duplicado) redirigir con mensaje
        response.sendRedirect("registroEstudiante.jsp?error=El carnet ya existe o hubo un error.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Estudiante Registrado</title>
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
    <div class="alert alert-success">✅ Estudiante registrado exitosamente.</div>

    <h5>Datos registrados:</h5>
    <ul class="list-group mb-3">
        <li class="list-group-item"><strong>Carnet:</strong>
            <jsp:getProperty name="estudiante" property="carnet"/>
        </li>
        <li class="list-group-item"><strong>Nombre:</strong>
            <jsp:getProperty name="estudiante" property="nombreEstudiante"/>
        </li>
        <li class="list-group-item"><strong>Carrera:</strong>
            <jsp:getProperty name="estudiante" property="carrera"/>
        </li>
        <li class="list-group-item"><strong>Teléfono:</strong>
            <jsp:getProperty name="estudiante" property="telefono"/>
        </li>
    </ul>

    <a href="registroEstudiante.jsp" class="btn btn-dark">Registrar otro</a>
    <a href="index.jsp" class="btn btn-secondary ms-2">Inicio</a>
</div>

</body>
</html>
