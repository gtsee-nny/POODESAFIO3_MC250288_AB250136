<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Página de inicio del sistema de biblioteca. --%>
<%-- Ofrece enlaces a las secciones de registro y listado de préstamos. --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Biblioteca UDB</title>
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
            <a class="nav-link" href="registroEstudiante.jsp">Registrar Estudiante</a>
            <a class="nav-link" href="registroPrestamo.jsp">Registrar Préstamo</a>
            <a class="nav-link" href="listaPrestamos.jsp">Lista de Préstamos</a>
        </div>
    </div>
</nav>

<!-- Contenido principal -->
<div class="container mt-page">

    <div class="page-header">
        <h2>Plataforma de Gestión de Biblioteca</h2>
        <p class="subtitle">Gestiona libros, estudiantes y préstamos de la biblioteca.</p>
    </div>
    <hr class="section-divider">

    <div class="row g-4">

        <!-- Libros -->
        <div class="col-md-6 col-lg-3">
            <div class="udb-card">
                <span class="card-icon">📖</span>
                <span class="card-badge">Catálogo</span>
                <h5>Libros</h5>
                <p>Registrar nuevos libros y gestionar el catálogo de la biblioteca.</p>
                <a href="registroLibro.jsp" class="btn-udb-primary">Ver más</a>
            </div>
        </div>

        <!-- Estudiantes -->
        <div class="col-md-6 col-lg-3">
            <div class="udb-card">
                <span class="card-icon">🎓</span>
                <span class="card-badge">Usuarios</span>
                <h5>Estudiantes</h5>
                <p>Registrar nuevos estudiantes y administrar la base de usuarios activos.</p>
                <a href="registroEstudiante.jsp" class="btn-udb-primary">Ver más</a>
            </div>
        </div>

        <!-- Préstamos -->
        <div class="col-md-6 col-lg-3">
            <div class="udb-card">
                <span class="card-icon">🔖</span>
                <span class="card-badge">Préstamos</span>
                <h5>Préstamos</h5>
                <p>Registrar un nuevo préstamo de libro para un estudiante activo.</p>
                <a href="registroPrestamo.jsp" class="btn-udb-primary">Ver más</a>
            </div>
        </div>

        <!-- Lista préstamos -->
        <div class="col-md-6 col-lg-3">
            <div class="udb-card">
                <span class="card-icon">📋</span>
                <span class="card-badge">Historial</span>
                <h5>Lista Préstamos</h5>
                <p>Consultar todos los préstamos registrados y gestionar devoluciones.</p>
                <a href="listaPrestamos.jsp" class="btn-udb-primary">Ver más</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
