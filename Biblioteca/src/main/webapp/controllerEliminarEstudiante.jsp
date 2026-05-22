<%-- Controlador JSP que maneja la eliminación de estudiantes. --%>
<%-- Verifica si hay préstamos pendientes y puede pedir confirmación antes de borrar. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<%@ page import="udb.biblioteca.EstudianteBean" %>

<%
    String idStr = request.getParameter("idEstudiante");
    if (idStr == null || idStr.isEmpty()) {
        response.sendRedirect("registroEstudiante.jsp?delError=" + java.net.URLEncoder.encode("Seleccione un estudiante.", "UTF-8"));
        return;
    }

    try {
        EstudianteBean est = new EstudianteBean();
        int id = Integer.parseInt(idStr);
        est.setIdEstudiante(id);

        // Obtener nombre del estudiante para mostrar en mensajes
        String studentName = "";
        String sqlName = "SELECT nombre_estudiante FROM estudiantes WHERE id_estudiante = ?";
        try (PreparedStatement psn = conn.prepareStatement(sqlName)) {
            psn.setInt(1, id);
            try (ResultSet rsn = psn.executeQuery()) {
                if (rsn.next()) studentName = rsn.getString("nombre_estudiante");
            }
        }

        String confirm = request.getParameter("confirm");
        // Si llega confirm=true, proceder a eliminar
        if ("true".equals(confirm)) {
            est.eliminar(conn);
            response.sendRedirect("registroEstudiante.jsp?delSuccess=" + java.net.URLEncoder.encode("Estudiante y préstamos asociados eliminados correctamente.", "UTF-8") + "&studentName=" + java.net.URLEncoder.encode(studentName, "UTF-8"));
            return;
        }

        // Si no se confirmó, verificar si tiene préstamos pendientes
        boolean pendientes = est.tienePrestamosPendientes(conn);
        if (pendientes) {
            // Pedir confirmación mostrando advertencia en la UI
            response.sendRedirect("registroEstudiante.jsp?delWarning=" + java.net.URLEncoder.encode("El estudiante tiene préstamos pendientes. Si confirma, el estudiante y sus préstamos asociados serán eliminados de la base de datos y el stock de los libros se ajustará después de su decisión.", "UTF-8") + "&idToConfirm=" + idStr + "&studentName=" + java.net.URLEncoder.encode(studentName, "UTF-8") + "&delOpen=true");
            return;
        }

        // Eliminar estudiante y préstamos asociados
        est.eliminar(conn);
        response.sendRedirect("registroEstudiante.jsp?delSuccess=" + java.net.URLEncoder.encode("Estudiante y préstamos asociados eliminados correctamente.", "UTF-8") + "&studentName=" + java.net.URLEncoder.encode(studentName, "UTF-8"));

    } catch (Exception e) {
        String msg = e.getMessage();
        if (msg == null || msg.isBlank()) msg = "No se pudo eliminar el estudiante.";
        response.sendRedirect("registroEstudiante.jsp?delError=" + java.net.URLEncoder.encode(msg, "UTF-8") + "&delOpen=true");
    }
%>
