<%-- Esta página crea la conexión con la base de datos para que los demás JSP la puedan usar --%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = null;
    ResultSet  rs   = null;
    PreparedStatement st = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/bibliotecaudb" +
            "?useSSL=false&serverTimezone=America/El_Salvador" +
            "&allowPublicKeyRetrieval=true",
            "root", ""
        );
    } catch (Exception e) {
        throw new RuntimeException("Error de conexion: " + e.getMessage());
    }
%>
