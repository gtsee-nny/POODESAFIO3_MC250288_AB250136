<%-- Este controlador recibe los datos del préstamo y los manda al Bean para guardarlos --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%-- Crear el bean y asignar automáticamente todos los parámetros del formulario --%>
<jsp:useBean id="prestamo" class="udb.biblioteca.PrestamoBean" scope="request"/>
<jsp:setProperty name="prestamo" property="*"/>

<%
    // Insertar el préstamo — el bean valida disponibilidad internamente
    try {
        prestamo.insertar(conn);
    } catch (Exception e) {
        // Si no hay disponibilidad u otro error, redirigir con mensaje
        response.sendRedirect("registroPrestamo.jsp?error=" + e.getMessage());
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Préstamo Registrado</title>
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
    <div class="alert alert-success">✅ Préstamo registrado exitosamente.</div>

    <h5>Datos registrados:</h5>
    <ul class="list-group mb-3">
        <li class="list-group-item"><strong>Fecha de préstamo:</strong>
            <jsp:getProperty name="prestamo" property="fechaPrestamo"/>
        </li>
        <li class="list-group-item"><strong>Fecha de devolución:</strong>
            <jsp:getProperty name="prestamo" property="fechaDevolucion"/>
        </li>
        <li class="list-group-item"><strong>Estado:</strong>
            <jsp:getProperty name="prestamo" property="estado"/>
        </li>
    </ul>

    <a href="registroPrestamo.jsp" class="btn btn-dark">Registrar otro</a>
    <a href="listaPrestamos.jsp" class="btn btn-secondary ms-2">Ver préstamos</a>
</div>

</body>
</html>
