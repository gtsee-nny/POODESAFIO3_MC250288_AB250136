<%-- Controlador JSP que recibe el formulario de nueva categoría y la inserta en la base de datos. --%>
<%-- Redirige a registroLibro.jsp con mensaje de éxito o de error. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<jsp:useBean id="categoria" class="udb.biblioteca.CategoriaBean" scope="request"/>
<jsp:setProperty name="categoria" property="*"/>

<%
    String action = request.getParameter("action");
    try {
        if ("delete".equals(action)) {
            categoria.eliminar(conn);
            response.sendRedirect("registroLibro.jsp?catSuccess=" + java.net.URLEncoder.encode("Categoría eliminada correctamente.", "UTF-8"));
            return;
        }

        categoria.insertar(conn);
        String nombre = java.net.URLEncoder.encode(categoria.getNombreCategoria().trim(), "UTF-8");
        response.sendRedirect("registroLibro.jsp?catSuccess=Categoria registrada correctamente.&newCategoryName=" + nombre);
    } catch (Exception e) {
        String mensaje = e.getMessage();
        if (mensaje == null || mensaje.isBlank()) {
            mensaje = "No se pudo registrar la categoría. Intente con otro nombre.";
        }
        response.sendRedirect("registroLibro.jsp?catError=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&catOpen=true");
    }
%>
