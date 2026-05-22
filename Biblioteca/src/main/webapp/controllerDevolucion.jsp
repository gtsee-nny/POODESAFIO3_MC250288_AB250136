<%-- Controlador para procesar la devolución de un préstamo. --%>
<%-- Actualiza el estado del préstamo y retorna el stock del libro. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>
<%@ page import="udb.biblioteca.PrestamoBean" %>
<%
    // Obtener los parámetros enviados por el link de devolución
    int idPrestamo = Integer.parseInt(request.getParameter("idPrestamo"));
    int idLibro    = Integer.parseInt(request.getParameter("idLibro"));

    // Ejecutar la devolución usando el bean
    try {
        PrestamoBean prestamoBean = new PrestamoBean();
        prestamoBean.devolver(conn, idPrestamo, idLibro);
        // Redirigir a la lista con mensaje de éxito
        response.sendRedirect("listaPrestamos.jsp?devuelto=true");
    } catch (Exception e) {
        response.sendRedirect("listaPrestamos.jsp?error=" + e.getMessage());
    }
%>
