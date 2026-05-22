<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="udb.biblioteca.CategoriaBean" %>
<%@ page import="udb.biblioteca.LibroBean" %>
<%@ include file="conexion.jsp" %>
<%-- Página de registro de libros en el catálogo. --%>
<%-- Carga categorías y libros desde la base de datos, permite crear/eliminar categorías y editar/eliminar libros existentes. --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar Libro — Biblioteca UDB</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Biblioteca UDB</a>
        <div class="navbar-nav ms-auto d-flex flex-row gap-1">
            <a class="nav-link active" href="registroLibro.jsp">Registrar Libro</a>
            <a class="nav-link" href="registroEstudiante.jsp">Registrar Estudiante</a>
            <a class="nav-link" href="registroPrestamo.jsp">Registrar Préstamo</a>
            <a class="nav-link" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<div class="container mt-page">
    <div class="page-header">
        <h3>📖 Registrar Libro</h3>
        <p class="subtitle">Añade un nuevo libro al catálogo de la biblioteca.</p>
    </div>
    <hr class="section-divider">

    <%
        // Cargar categorías y libros desde la base de datos.
        // Si llega idLibro, obtener los datos para editar ese libro.
        CategoriaBean catBean = new CategoriaBean();
        List<CategoriaBean> categorias = catBean.getListaCategorias(conn);
        List<LibroBean> libros = new LibroBean().getListaLibros(conn);

        LibroBean libroEdit = new LibroBean();
        boolean editingLibro = false;
        String libroIdParam = request.getParameter("idLibro");
        if (libroIdParam != null && !libroIdParam.isEmpty()) {
            try {
                int libroId = Integer.parseInt(libroIdParam);
                libroEdit = libroEdit.getLibroPorId(conn, libroId);
                editingLibro = libroEdit.getIdLibro() > 0;
            } catch (Exception ignored) {
            }
        }
    %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("error") %></div>
    <% } %>
    <% if (request.getParameter("catSuccess") != null) { %>
    <div class="alert-success-udb mb-3">✅ <%= request.getParameter("catSuccess") %></div>
    <% } %>
    <% if (request.getParameter("catError") != null) { %>
    <div class="alert-danger-udb mb-3">⚠️ <%= request.getParameter("catError") %></div>
    <% } %>

    <div class="form-card">
        <form action="controllerLibro.jsp" method="POST">
            <input type="hidden" name="idLibro" value="<%= editingLibro ? libroEdit.getIdLibro() : 0 %>">

            <div class="mb-3">
                <label class="form-label">Título</label>
                <input type="text" name="titulo" class="form-control" placeholder="Ej: Cien años de soledad" required value="<%= editingLibro ? libroEdit.getTitulo() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Autor</label>
                <input type="text" name="autor" class="form-control" placeholder="Ej: Gabriel García Márquez" required value="<%= editingLibro ? libroEdit.getAutor() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">ISBN</label>
                <input type="text" name="isbn" class="form-control" placeholder="Ej: 978-3-16-148410-0" value="<%= editingLibro ? libroEdit.getIsbn() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Categoría</label>
                <select name="idCategoria" class="form-select" required>
                    <option value="">— Seleccione una categoría —</option>
                    <%
                        for (CategoriaBean c : categorias) {
                    %>
                        <option value="<%= c.getIdCategoria() %>" <%= editingLibro && c.getIdCategoria() == libroEdit.getIdCategoria() ? "selected" : "" %>><%= c.getNombreCategoria() %></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="mb-4">
                <label class="form-label">Cantidad Disponible</label>
                <input type="number" name="cantidadDisponible" class="form-control" min="1" value="<%= editingLibro ? libroEdit.getCantidadDisponible() : 1 %>" required>
            </div>

            <div class="d-flex gap-btn">
                <button type="submit" class="btn-submit"><%= editingLibro ? "Guardar cambios" : "Registrar libro" %></button>
                <% if (editingLibro) { %>
                    <a href="registroLibro.jsp" class="btn-udb-secondary">Cancelar edición</a>
                <% } else { %>
                    <a href="index.jsp" class="btn-udb-secondary">Cancelar</a>
                <% } %>
            </div>
        </form>

        <div class="mt-4">
            <button type="button" class="btn-add-category" id="toggleCategoryCard">¿Agregar Categoría?</button>
        </div>
    </div>

    <div class="section-card mt-4">
        <h4>Catálogo de libros</h4>
        <p class="subtitle">Edite o elimine rápidamente un registro de libro existente.</p>
        <div class="table-wrapper">
            <table class="table-udb">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Categoría</th>
                        <th>ISBN</th>
                        <th>Disponibles</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (LibroBean l : libros) {
                    %>
                    <tr>
                        <td><%= l.getTitulo() %></td>
                        <td><%= l.getAutor() %></td>
                        <td><%= l.getNombreCategoria() %></td>
                        <td><%= l.getIsbn() %></td>
                        <td><%= l.getCantidadDisponible() %></td>
                        <td class="d-flex gap-2">
                            <a href="registroLibro.jsp?idLibro=<%= l.getIdLibro() %>" class="btn-udb-secondary">✏️ Editar</a>
                            <a href="controllerLibro.jsp?action=delete&idLibro=<%= l.getIdLibro() %>" class="btn-udb-danger" onclick="return confirm('¿Eliminar este libro y sus préstamos asociados?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="section-card mt-4">
        <h4>Gestión de categorías</h4>
        <p class="subtitle">Elimine categorías que no estén asociadas a ningún libro.</p>
        <div class="table-wrapper">
            <table class="table-udb">
                <thead>
                    <tr>
                        <th>Categoría</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (CategoriaBean c : categorias) {
                    %>
                    <tr>
                        <td><%= c.getNombreCategoria() %></td>
                        <td>
                            <a href="controllerCategoria.jsp?action=delete&idCategoria=<%= c.getIdCategoria() %>" class="btn-udb-danger" onclick="return confirm('¿Eliminar categoría <%= c.getNombreCategoria() %>? Solo si no tiene libros asociados.')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Panel oculto para agregar una nueva categoría sin dejar la página de registro de libros. --%>
    <div class="category-card" id="categoryCard" data-open="<%= request.getParameter("catError") != null ? "true" : "false" %>" data-new-category="<%= request.getParameter("newCategoryName") != null ? java.net.URLEncoder.encode(request.getParameter("newCategoryName"), "UTF-8") : "" %>">
        <h4>Agregar nueva categoría</h4>
        <p class="subtitle">Añade una categoría antes de registrar el libro.</p>
        <form action="controllerCategoria.jsp" method="POST">
            <div class="mb-3">
                <label class="form-label">Nombre de categoría</label>
                <input type="text" name="nombreCategoria" class="form-control" maxlength="50" placeholder="Ej: Novela histórica" required>
            </div>
            <div class="d-flex gap-btn">
                <button type="submit" class="btn-submit">Guardar categoría</button>
                <button type="button" class="btn-udb-secondary" onclick="toggleCategoryCard()">Cerrar</button>
            </div>
        </form>
    </div>

    <script>
        const categoryCard = document.getElementById('categoryCard');
        const toggleCategoryButton = document.getElementById('toggleCategoryCard');

        function toggleCategoryCard() {
            if (!categoryCard) return;
            categoryCard.classList.toggle('active');
            if (categoryCard.classList.contains('active')) {
                categoryCard.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }

        if (categoryCard && categoryCard.dataset.open === 'true') {
            categoryCard.classList.add('active');
        }

        if (toggleCategoryButton) {
            toggleCategoryButton.addEventListener('click', toggleCategoryCard);
        }

        const selectedCategoryName = categoryCard ? decodeURIComponent(categoryCard.dataset.newCategory || '') : '';
        if (selectedCategoryName) {
            const selectElement = document.querySelector('select[name="idCategoria"]');
            if (selectElement) {
                const optionToSelect = Array.from(selectElement.options).find(option =>
                    option.textContent.trim().toLowerCase() === selectedCategoryName.trim().toLowerCase()
                );
                if (optionToSelect) {
                    optionToSelect.selected = true;
                    selectElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        }
    </script>
</div>

</body>
</html>
