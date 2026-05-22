<%-- Controlador JSP que recibe el formulario de estudiantes y guarda los datos en la base de datos. --%>
<%-- Utiliza el bean para mapear automáticamente los campos del formulario. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%-- Crear el bean y asignar automáticamente todos los parámetros del formulario --%>
<jsp:useBean id="estudiante" class="udb.biblioteca.EstudianteBean" scope="request"/>
<jsp:setProperty name="estudiante" property="*"/>

<%
    String action = request.getParameter("action");
    String successMessage = "";
    try {
        if ("delete".equals(action)) {
            estudiante.eliminar(conn);
            successMessage = "Estudiante eliminado correctamente.";
        } else if (estudiante.getIdEstudiante() > 0) {
            estudiante.actualizar(conn);
            successMessage = "Estudiante actualizado correctamente.";
        } else {
            estudiante.insertar(conn);
            successMessage = "Estudiante registrado exitosamente.";
        }
    } catch (Exception e) {
        response.sendRedirect("registroEstudiante.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
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
            <div class="detail-item"><strong>Carnet:</strong>
                <span><jsp:getProperty name="estudiante" property="carnet"/></span>
            </div>
            <div class="detail-item"><strong>Nombre:</strong>
                <span><jsp:getProperty name="estudiante" property="nombreEstudiante"/></span>
            </div>
            <div class="detail-item"><strong>Carrera:</strong>
                <span><jsp:getProperty name="estudiante" property="carrera"/></span>
            </div>
            <div class="detail-item"><strong>Teléfono:</strong>
                <span><jsp:getProperty name="estudiante" property="telefono"/></span>
            </div>
        </div>

        <div class="d-flex gap-btn">
            <a href="registroEstudiante.jsp" class="btn-submit">Registrar otro</a>
            <a href="index.jsp" class="btn-udb-secondary ms-2">Inicio</a>
        </div>
    </div>
</div>

</body>
</html>
