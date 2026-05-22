<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.CategoriaBean" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar Libro</title>
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

<!-- Formulario que envía los datos del libro hacia controllerLibro.jsp -->
<div class="container mt-4">
    <h3>Registrar Libro</h3>
    <hr>
    <form action="controllerLibro.jsp" method="POST">
        <div class="mb-3">
            <label class="form-label">Título</label>
            <input type="text" name="titulo" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Autor</label>
            <input type="text" name="autor" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">ISBN</label>
            <input type="text" name="isbn" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">Categoría</label>
            <select name="idCategoria" class="form-select" required>
                <option value="">-- Seleccione --</option>
                <%
                    // Cargar categorías dinámicamente desde la BD
                    CategoriaBean catBean = new CategoriaBean();
                    List<CategoriaBean> categorias = catBean.getListaCategorias(conn);
                    for (CategoriaBean c : categorias) {
                %>
                    <option value="<%= c.getIdCategoria() %>"><%= c.getNombreCategoria() %></option>
                <%
                    }
                %>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Cantidad Disponible</label>
            <input type="number" name="cantidadDisponible" class="form-control" min="1" value="1" required>
        </div>
        <button type="submit" class="btn btn-dark">Registrar</button>
        <a href="index.jsp" class="btn btn-secondary ms-2">Cancelar</a>
    </form>
</div>

</body>
</html>
