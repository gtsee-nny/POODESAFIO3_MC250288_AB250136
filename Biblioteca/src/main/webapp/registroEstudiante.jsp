<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.EstudianteBean" %>
<%@ include file="conexion.jsp" %>
<%-- Página para registrar y eliminar estudiantes. --%>
<%-- Muestra formulario de registro y un panel/modal de eliminación con confirmación. --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar Estudiante — Biblioteca UDB</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Biblioteca UDB</a>
        <div class="navbar-nav ms-auto d-flex flex-row gap-1">
            <a class="nav-link" href="registroLibro.jsp">Registrar Libro</a>
            <a class="nav-link active" href="registroEstudiante.jsp">Registrar Estudiante</a>
            <a class="nav-link" href="registroPrestamo.jsp">Registrar Préstamo</a>
            <a class="nav-link" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<div class="container mt-page">
    <div class="page-header">
        <h3>🎓 Registrar Estudiante</h3>
        <p class="subtitle">Añade un estudiante al sistema de la biblioteca.</p>
    </div>
    <hr class="section-divider">

    <%
        EstudianteBean estudianteEdit = new EstudianteBean();
        boolean editingEstudiante = false;
        String estudianteIdParam = request.getParameter("idEstudiante");
        if (estudianteIdParam != null && !estudianteIdParam.isEmpty()) {
            try {
                int estudianteId = Integer.parseInt(estudianteIdParam);
                estudianteEdit = estudianteEdit.getEstudiantePorId(conn, estudianteId);
                editingEstudiante = estudianteEdit.getIdEstudiante() > 0;
            } catch (Exception ignored) {
            }
        }
        List<EstudianteBean> estudiantes = new EstudianteBean().getListaEstudiantes(conn);
    %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("error") %></div>
    <% } %>
    <% if (request.getParameter("delSuccess") != null) { %>
    <div class="alert-success-udb mb-3">✅ <%= request.getParameter("delSuccess") %>
        <% if (request.getParameter("studentName") != null) { %>
            — <strong><%= request.getParameter("studentName") %></strong>
        <% } %>
    </div>
    <script>
        // Cerrar paneles de eliminación si hay éxito
        document.addEventListener('DOMContentLoaded', function(){
            const deleteCard = document.getElementById('deleteCard');
            const confirmCard = document.getElementById('confirmDeleteCard');
            if (deleteCard) deleteCard.classList.remove('active');
            if (confirmCard) confirmCard.classList.remove('active');
        });
    </script>
    <% } %>
    <% if (request.getParameter("delWarning") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("delWarning") %></div>
    <% } %>
    <% if (request.getParameter("delError") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("delError") %></div>
    <% } %>

    <div class="form-card">
        <form action="controllerEstudiante.jsp" method="POST">
            <input type="hidden" name="idEstudiante" value="<%= editingEstudiante ? estudianteEdit.getIdEstudiante() : 0 %>">

            <div class="mb-3">
                <label class="form-label">Carnet</label>
                <input type="text" name="carnet" class="form-control" maxlength="10" placeholder="Ej: UDB-2024-01" required value="<%= editingEstudiante ? estudianteEdit.getCarnet() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Nombre completo</label>
                <input type="text" name="nombreEstudiante" class="form-control" placeholder="Ej: Juan Carlos Pérez" required value="<%= editingEstudiante ? estudianteEdit.getNombreEstudiante() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Carrera</label>
                <input type="text" name="carrera" class="form-control" placeholder="Ej: Ingeniería en Sistemas" required value="<%= editingEstudiante ? estudianteEdit.getCarrera() : "" %>">
            </div>

            <div class="mb-4">
                <label class="form-label">Teléfono</label>
                <input type="text" name="telefono" class="form-control" maxlength="9" placeholder="Ej: 7123-4567" value="<%= editingEstudiante ? estudianteEdit.getTelefono() : "" %>">
            </div>

            <div class="d-flex gap-btn">
                <button type="submit" class="btn-submit"><%= editingEstudiante ? "Guardar cambios" : "Registrar estudiante" %></button>
                <% if (editingEstudiante) { %>
                    <a href="registroEstudiante.jsp" class="btn-udb-secondary">Cancelar edición</a>
                <% } else { %>
                    <a href="index.jsp" class="btn-udb-secondary">Cancelar</a>
                <% } %>
            </div>

        </form>
    </div>

    <div class="section-card mt-4">
        <h4>Lista de estudiantes</h4>
        <p class="subtitle">Edita o elimina un estudiante registrado.</p>
        <div class="table-wrapper">
            <table class="table-udb">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Carnet</th>
                        <th>Carrera</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (EstudianteBean e : estudiantes) {
                    %>
                    <tr>
                        <td><%= e.getNombreEstudiante() %></td>
                        <td><%= e.getCarnet() %></td>
                        <td><%= e.getCarrera() %></td>
                        <td><%= e.getTelefono() %></td>
                        <td class="d-flex gap-2">
                            <a href="registroEstudiante.jsp?idEstudiante=<%= e.getIdEstudiante() %>" class="btn-udb-secondary">✏️ Editar</a>
                            <a href="controllerEliminarEstudiante.jsp?idEstudiante=<%= e.getIdEstudiante() %>" class="btn-udb-danger" onclick="return confirm('¿Eliminar estudiante <%= e.getNombreEstudiante() %>?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Panel de eliminación que muestra la lista de estudiantes y permite iniciar el flujo de borrado. --%>
    <div class="category-card" id="deleteCard" data-open="<%= request.getParameter("delOpen") != null ? "true" : "false" %>">
        <h4>Eliminar estudiante</h4>
        <p class="subtitle">Selecciona el estudiante que deseas eliminar.</p>
        <form action="controllerEliminarEstudiante.jsp" method="POST">
            <div class="mb-3">
                <label class="form-label">Estudiante</label>
                <select name="idEstudiante" class="form-select" required>
                    <option value="">— Seleccione un estudiante —</option>
                    <%
                        for (EstudianteBean e : estudiantes) {
                    %>
                    <option value="<%= e.getIdEstudiante() %>"><%= e.getCarnet() %> — <%= e.getNombreEstudiante() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="d-flex gap-btn">
                <button type="submit" class="btn-udb-danger">Eliminar estudiante</button>
                <button type="button" class="btn-udb-secondary" onclick="toggleDeleteCard()">Cerrar</button>
            </div>
        </form>
    </div>

    <% if (request.getParameter("idToConfirm") != null) { %>
    <!-- Modal de confirmación (aparece cuando controller devuelve idToConfirm) -->
    <div id="confirmModalOverlay" style="position:fixed;left:0;top:0;width:100%;height:100%;background:rgba(0,0,0,0.5);display:flex;align-items:center;justify-content:center;z-index:1200;">
        <div class="form-card" style="max-width:640px;padding:1.5rem;">
            <h4>Confirmar eliminación</h4>
            <div class="alert-danger-udb mb-3">⚠️ Atención: el estudiante seleccionado tiene préstamos pendientes.
                <% if (request.getParameter("studentName") != null) { %>
                    <br>Estudiante: <strong><%= request.getParameter("studentName") %></strong>
                <% } %>
                <br>Si confirma, el estudiante y sus préstamos asociados se eliminarán de la base de datos y se ajustará el stock de los libros después de su decisión. ¿Continuar?
            </div>

            <form action="controllerEliminarEstudiante.jsp" method="POST" style="margin-bottom:0;">
                <input type="hidden" name="idEstudiante" value="<%= request.getParameter("idToConfirm") %>">
                <input type="hidden" name="confirm" value="true">
                <div class="d-flex gap-btn">
                    <button type="submit" class="btn-udb-danger">Confirmar eliminación</button>
                    <a href="registroEstudiante.jsp" class="btn-udb-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function(){
            const overlay = document.getElementById('confirmModalOverlay');
            if (overlay) {
                document.body.style.overflow = 'hidden';
            }
        });
    </script>
    <% } %>

</div>

</body>
</html>
