<%-- Controlador JSP que procesa el registro y eliminación de préstamos. --%>
<%-- Inserta nuevos préstamos y permite borrar registros devueltos. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%-- Crear el bean y asignar automáticamente todos los parámetros del formulario --%>
<jsp:useBean id="prestamo" class="udb.biblioteca.PrestamoBean" scope="request"/>
<jsp:setProperty name="prestamo" property="*"/>

<%
    String action = request.getParameter("action");
    try {
        if ("delete".equals(action)) {
            if (prestamo.getIdPrestamo() == 0) {
                throw new Exception("No se indicó el préstamo a eliminar.");
            }
            prestamo.eliminar(conn);
            response.sendRedirect("listaPrestamos.jsp?deleted=true");
            return;
        }

        // Insertar el préstamo — el bean valida disponibilidad internamente
        prestamo.insertar(conn);
    } catch (Exception e) {
        if ("delete".equals(action)) {
            response.sendRedirect("listaPrestamos.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        } else {
            response.sendRedirect("registroPrestamo.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
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
        <div class="alert-success-udb mb-3">✅ Préstamo registrado exitosamente.</div>

        <h5>Datos registrados:</h5>
        <div class="detail-card mb-3">
            <div class="detail-item"><strong>Fecha de préstamo:</strong>
                <span><jsp:getProperty name="prestamo" property="fechaPrestamo"/></span>
            </div>
            <div class="detail-item"><strong>Fecha de devolución:</strong>
                <span><jsp:getProperty name="prestamo" property="fechaDevolucion"/></span>
            </div>
            <div class="detail-item"><strong>Estado:</strong>
                <span><jsp:getProperty name="prestamo" property="estado"/></span>
            </div>
        </div>

        <div class="d-flex gap-btn">
            <a href="registroPrestamo.jsp" class="btn-submit">Registrar otro</a>
            <a href="listaPrestamos.jsp" class="btn-udb-secondary ms-2">Ver préstamos</a>
        </div>
    </div>
</div>

</body>
</html>
