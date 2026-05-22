<%-- Controlador JSP que recibe el formulario de registro de libros y guarda el libro en la base de datos. --%>
<%-- Usa `jsp:useBean` y `jsp:setProperty` para poblar el bean con los datos del formulario. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%-- Crear el bean y asignar automáticamente todos los parámetros del formulario --%>
<jsp:useBean id="libro" class="udb.biblioteca.LibroBean" scope="request"/>
<jsp:setProperty name="libro" property="*"/>

<%
    String action = request.getParameter("action");
    String successMessage = "";
    try {
        if ("delete".equals(action)) {
            if (libro.getIdLibro() == 0) {
                throw new Exception("No se indicó el libro a eliminar.");
            }
            libro.eliminar(conn);
            successMessage = "Libro eliminado correctamente.";
        } else if (libro.getIdLibro() > 0) {
            libro.actualizar(conn);
            successMessage = "Libro actualizado correctamente.";
        } else {
            libro.insertar(conn);
            successMessage = "Libro registrado exitosamente.";
        }
    } catch (Exception e) {
        response.sendRedirect("registroLibro.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
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
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<nav class="navbar navbar-expand-lg">
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

<div class="container mt-page">
    <div class="form-card">
        <div class="alert-success-udb mb-3">✅ <%= successMessage %></div>

        <h5>Datos registrados:</h5>
        <div class="detail-card mb-3">
            <div class="detail-item"><strong>Título:</strong>
                <span><jsp:getProperty name="libro" property="titulo"/></span>
            </div>
            <div class="detail-item"><strong>Autor:</strong>
                <span><jsp:getProperty name="libro" property="autor"/></span>
            </div>
            <div class="detail-item"><strong>ISBN:</strong>
                <span><jsp:getProperty name="libro" property="isbn"/></span>
            </div>
            <div class="detail-item"><strong>Cantidad disponible:</strong>
                <span><jsp:getProperty name="libro" property="cantidadDisponible"/></span>
            </div>
        </div>

        <div class="d-flex gap-btn">
            <a href="registroLibro.jsp" class="btn-submit">Registrar otro</a>
            <a href="index.jsp" class="btn-udb-secondary ms-2">Inicio</a>
        </div>
    </div>
</div>

</body>
</html>
