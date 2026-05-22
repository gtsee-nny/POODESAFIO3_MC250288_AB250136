-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-05-2026 a las 01:52:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bibliotecaudb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre_categoria`) VALUES
(1, 'Programación'),
(2, 'Bases de Datos'),
(3, 'Redes'),
(4, 'Matemática'),
(5, 'Inteligencia Artificial'),
(6, 'Desarrollo Web'),
(7, 'Ciberseguridad'),
(8, 'Electrónica'),
(9, 'Física'),
(10, 'Química'),
(11, 'Administración'),
(12, 'Contabilidad'),
(13, 'Diseño Gráfico'),
(14, 'Marketing'),
(15, 'Programación Avanzada'),
(16, 'Algoritmos'),
(17, 'Estructura de Datos'),
(18, 'Sistemas Operativos'),
(19, 'Machine Learning'),
(20, 'Big Data'),
(21, 'Cloud Computing'),
(22, 'Arquitectura de Computadoras'),
(23, 'Desarrollo Móvil'),
(24, 'Análisis de Sistemas'),
(25, 'Robótica'),
(26, 'Telecomunicaciones'),
(27, 'Estadística'),
(28, 'Geometría'),
(29, 'Investigación'),
(30, 'Tecnología');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id_estudiante` int(11) NOT NULL,
  `carnet` varchar(10) NOT NULL,
  `nombre_estudiante` varchar(100) NOT NULL,
  `carrera` varchar(80) NOT NULL,
  `telefono` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id_estudiante`, `carnet`, `nombre_estudiante`, `carrera`, `telefono`) VALUES
(1, 'AB123456', 'María José Hernández López', 'Ingeniería en Computación', '78901234'),
(2, 'CD234567', 'Carlos Eduardo Martínez Rivas', 'Ingeniería Industrial', '72345678'),
(3, 'EF345678', 'Sofía Alejandra González Díaz', 'Ingeniería en Computación', '76543210'),
(4, 'MC250288', 'Concepción', 'Ingenieria en Computación', '70244341'),
(5, 'IJ567890', 'Andrea Carolina López', 'Ingeniería Industrial', '70010002'),
(6, 'KL678901', 'José Manuel Castro', 'Ingeniería en Computación', '70010003'),
(7, 'MN789012', 'Valeria Rodríguez', 'Diseño Gráfico', '70010004'),
(8, 'OP890123', 'Kevin Hernández', 'Marketing', '70010005'),
(9, 'QR901234', 'Daniela Flores', 'Administración', '70010006'),
(10, 'ST012345', 'Ricardo Molina', 'Ingeniería Industrial', '70010007'),
(11, 'UV123456', 'Gabriela Ramírez', 'Ingeniería en Computación', '70010008'),
(12, 'WX234567', 'Fernando Aguilar', 'Diseño Gráfico', '70010009'),
(13, 'YZ345678', 'Melissa Torres', 'Marketing', '70010010'),
(14, 'AA456789', 'Óscar Benítez', 'Ingeniería Industrial', '70010011'),
(15, 'BB567890', 'Natalia Cruz', 'Ingeniería en Computación', '70010012'),
(16, 'CC678901', 'Samuel Díaz', 'Administración', '70010013'),
(17, 'DD789012', 'Paola Herrera', 'Diseño Gráfico', '70010014'),
(18, 'EE890123', 'Hugo Rivera', 'Marketing', '70010015'),
(19, 'FF901234', 'Camila Ortiz', 'Ingeniería en Computación', '70010016'),
(20, 'GG012345', 'Eduardo Navarro', 'Ingeniería Industrial', '70010017'),
(21, 'HH123456', 'Tatiana Silva', 'Administración', '70010018'),
(22, 'II234567', 'Javier Morales', 'Ingeniería en Computación', '70010019'),
(23, 'JJ345678', 'Lucía Campos', 'Diseño Gráfico', '70010020'),
(24, 'KK456789', 'Mauricio Reyes', 'Marketing', '70010021'),
(25, 'LL567890', 'Carla Mendoza', 'Ingeniería Industrial', '70010022'),
(26, 'MM678901', 'Diego Fuentes', 'Ingeniería en Computación', '70010023'),
(27, 'NN789012', 'Alejandra Vega', 'Administración', '70010024'),
(28, 'OO890123', 'Cristian Romero', 'Diseño Gráfico', '70010025'),
(29, 'PP901234', 'Isabella Castillo', 'Marketing', '70010026'),
(30, 'QQ012345', 'Miguel Salazar', 'Ingeniería en Computación', '70010027');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `id_libro` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `cantidad_disponible` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id_libro`, `titulo`, `autor`, `isbn`, `id_categoria`, `cantidad_disponible`) VALUES
(1, 'Java Básico', 'Deitel', 'ISBN001', 1, 6),
(2, 'MySQL Fácil', 'Oracle', 'ISBN002', 2, 3),
(3, 'Redes Cisco', 'Cisco Press', 'ISBN003', 3, 2),
(4, 'Cálculo I', 'Stewart', 'ISBN004', 4, 4),
(5, 'el quijote', 'ldlnc', 'o30303', 2, 4),
(6, 'HTML y CSS', 'Jon Duckett', 'ISBN006', 6, 8),
(7, 'JavaScript Moderno', 'Eloquent JS', 'ISBN007', 6, 5),
(8, 'Redes Avanzadas', 'Cisco Academy', 'ISBN008', 3, 2),
(9, 'Álgebra Lineal', 'Lay', 'ISBN009', 4, 4),
(10, 'Física Universitaria', 'Serway', 'ISBN010', 9, 3),
(11, 'Química General', 'Chang', 'ISBN011', 10, 7),
(12, 'Introducción a IA', 'Russell', 'ISBN012', 5, 2),
(13, 'Machine Learning Básico', 'Aurélien Géron', 'ISBN013', 19, 5),
(14, 'Big Data Hoy', 'Oracle Press', 'ISBN014', 20, 4),
(15, 'Linux desde Cero', 'Ubuntu Team', 'ISBN015', 18, 6),
(16, 'Estructuras de Datos', 'Weiss', 'ISBN016', 17, 3),
(17, 'Algoritmos Modernos', 'Cormen', 'ISBN017', 16, 5),
(18, 'Desarrollo Android', 'Google', 'ISBN018', 23, 4),
(19, 'Cloud Computing Básico', 'AWS', 'ISBN019', 21, 5),
(20, 'Ciberseguridad Total', 'Kaspersky', 'ISBN020', 7, 2),
(21, 'Robótica Educativa', 'LEGO', 'ISBN021', 25, 4),
(22, 'Electrónica Básica', 'Malvino', 'ISBN022', 8, 7),
(23, 'Telecomunicaciones I', 'Nokia Press', 'ISBN023', 26, 5),
(24, 'Estadística Aplicada', 'Walpole', 'ISBN024', 27, 3),
(25, 'Geometría Analítica', 'Lehmann', 'ISBN025', 28, 6),
(26, 'Investigación Científica', 'Hernández Sampieri', 'ISBN026', 29, 4),
(27, 'Marketing Digital', 'Kotler', 'ISBN027', 14, 5),
(28, 'Administración Moderna', 'Chiavenato', 'ISBN028', 11, 6),
(29, 'Contabilidad General', 'Meigs', 'ISBN029', 12, 3),
(30, 'Diseño Creativo', 'Adobe', 'ISBN030', 13, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id_prestamo` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `id_libro` int(11) NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date NOT NULL,
  `estado` varchar(20) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id_prestamo`, `id_estudiante`, `id_libro`, `fecha_prestamo`, `fecha_devolucion`, `estado`) VALUES
(1, 1, 1, '2026-05-20', '2026-05-27', 'Devuelto'),
(2, 2, 2, '2026-05-18', '2026-05-25', 'Devuelto'),
(3, 3, 2, '2026-05-08', '2026-05-12', 'Devuelto'),
(4, 4, 5, '2026-05-14', '2026-05-12', 'Devuelto'),
(5, 5, 5, '2026-05-12', '2026-05-19', 'Activo'),
(6, 6, 6, '2026-05-13', '2026-05-20', 'Devuelto'),
(7, 7, 7, '2026-05-14', '2026-05-21', 'Activo'),
(8, 8, 8, '2026-05-15', '2026-05-22', 'Activo'),
(9, 9, 9, '2026-05-16', '2026-05-23', 'Devuelto'),
(10, 10, 10, '2026-05-17', '2026-05-24', 'Activo'),
(11, 11, 11, '2026-05-18', '2026-05-25', 'Activo'),
(12, 12, 12, '2026-05-19', '2026-05-26', 'Devuelto'),
(13, 13, 13, '2026-05-20', '2026-05-27', 'Activo'),
(14, 14, 14, '2026-05-21', '2026-05-28', 'Activo'),
(15, 15, 15, '2026-05-22', '2026-05-29', 'Devuelto'),
(16, 16, 16, '2026-05-23', '2026-05-30', 'Activo'),
(17, 17, 17, '2026-05-24', '2026-05-31', 'Activo'),
(18, 18, 18, '2026-05-25', '2026-06-01', 'Devuelto'),
(19, 19, 19, '2026-05-26', '2026-06-02', 'Activo'),
(20, 20, 20, '2026-05-27', '2026-06-03', 'Activo'),
(21, 21, 21, '2026-05-28', '2026-06-04', 'Devuelto'),
(22, 22, 22, '2026-05-29', '2026-06-05', 'Activo'),
(23, 23, 23, '2026-05-30', '2026-06-06', 'Activo'),
(24, 24, 24, '2026-05-31', '2026-06-07', 'Devuelto'),
(25, 25, 25, '2026-06-01', '2026-06-08', 'Activo'),
(26, 26, 26, '2026-06-02', '2026-06-09', 'Activo'),
(27, 27, 27, '2026-06-03', '2026-06-10', 'Devuelto'),
(28, 28, 28, '2026-06-04', '2026-06-11', 'Activo'),
(29, 29, 29, '2026-06-05', '2026-06-12', 'Activo'),
(30, 30, 30, '2026-06-06', '2026-06-13', 'Devuelto');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD UNIQUE KEY `carnet` (`carnet`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id_libro`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `fk_libro_categoria` (`id_categoria`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `fk_prestamo_estudiante` (`id_estudiante`),
  ADD KEY `fk_prestamo_libro` (`id_libro`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id_libro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `fk_libro_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `fk_prestamo_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prestamo_libro` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
