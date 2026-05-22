<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%-- Crear el bean y asignar automáticamente todos los parámetros del formulario --%>
<jsp:useBean id="libro" class="udb.biblioteca.LibroBean" scope="request"/>
<jsp:setProperty name="libro" property="*"/>

<%
    // Insertar el libro en la base de datos usando el bean
    try {
        libro.insertar(conn);
    } catch (Exception e) {
        // Si hay error (ej: ISBN duplicado) redirigir con mensaje
        response.sendRedirect("registroLibro.jsp?error=" + e.getMessage());
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Libro Registrado</title>
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
    <div class="alert alert-success">✅ Libro registrado exitosamente.</div>

    <h5>Datos registrados:</h5>
    <ul class="list-group mb-3">
        <li class="list-group-item"><strong>Título:</strong>
            <jsp:getProperty name="libro" property="titulo"/>
        </li>
        <li class="list-group-item"><strong>Autor:</strong>
            <jsp:getProperty name="libro" property="autor"/>
        </li>
        <li class="list-group-item"><strong>ISBN:</strong>
            <jsp:getProperty name="libro" property="isbn"/>
        </li>
        <li class="list-group-item"><strong>Cantidad disponible:</strong>
            <jsp:getProperty name="libro" property="cantidadDisponible"/>
        </li>
    </ul>

    <a href="registroLibro.jsp" class="btn btn-dark">Registrar otro</a>
    <a href="index.jsp" class="btn btn-secondary ms-2">Inicio</a>
</div>

</body>
</html>
