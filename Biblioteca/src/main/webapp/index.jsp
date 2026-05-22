<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Biblioteca UDB</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<!-- Página principal desde donde el usuario entra a las demás opciones -->

<!-- Barra de navegación -->
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

<!-- Contenido principal -->
<div class="container mt-5">
    <h2 class="mb-4">Panel Principal</h2>
    <div class="row">
        <div class="col-md-3">
            <div class="card text-center p-3">
                <h5>Libros</h5>
                <p>Registrar nuevos libros al sistema.</p>
                <a href="registroLibro.jsp" class="btn btn-dark">Ir</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-3">
                <h5>Estudiantes</h5>
                <p>Registrar nuevos estudiantes.</p>
                <a href="registroEstudiante.jsp" class="btn btn-dark">Ir</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-3">
                <h5>Préstamos</h5>
                <p>Registrar un préstamo de libro.</p>
                <a href="registroPrestamo.jsp" class="btn btn-dark">Ir</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center p-3">
                <h5>Lista Préstamos</h5>
                <p>Ver todos los préstamos registrados.</p>
                <a href="listaPrestamos.jsp" class="btn btn-dark">Ir</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
