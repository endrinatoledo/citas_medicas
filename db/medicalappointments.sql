-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-09-2021 a las 00:14:22
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `medicalappointments`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctors`
--

CREATE TABLE `doctors` (
  `doc_id` int(11) NOT NULL,
  `uro_id` int(11) NOT NULL,
  `spe_id` int(11) NOT NULL,
  `doc_first_name` varchar(100) NOT NULL,
  `doc_last_name` varchar(100) NOT NULL,
  `doc_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `doctors`
--

INSERT INTO `doctors` (`doc_id`, `uro_id`, `spe_id`, `doc_first_name`, `doc_last_name`, `doc_status`) VALUES
(1, 2, 1, 'Carlos', 'Diaz', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medical_appointments`
--

CREATE TABLE `medical_appointments` (
  `map_id` int(11) NOT NULL,
  `pat_id` int(11) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `map_date` date NOT NULL,
  `map_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medical_appointments`
--

INSERT INTO `medical_appointments` (`map_id`, `pat_id`, `doc_id`, `map_date`, `map_status`) VALUES
(1, 1, 1, '2021-09-10', 0),
(2, 1, 1, '2021-09-11', 1),
(4, 1, 1, '2021-09-12', NULL),
(5, 1, 1, '2021-09-13', NULL),
(6, 1, 1, '2021-09-14', NULL),
(7, 1, 1, '2021-09-14', NULL),
(8, 1, 1, '2021-09-15', NULL),
(9, 1, 1, '2021-09-16', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `patients`
--

CREATE TABLE `patients` (
  `pat_id` int(11) NOT NULL,
  `uro_id` int(11) NOT NULL,
  `pat_first_name` varchar(100) NOT NULL,
  `pat_last_name` varchar(100) NOT NULL,
  `pat_date` date NOT NULL,
  `pat_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `patients`
--

INSERT INTO `patients` (`pat_id`, `uro_id`, `pat_first_name`, `pat_last_name`, `pat_date`, `pat_status`) VALUES
(1, 1, 'Endrina', 'Toledo', '1992-12-02', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `rol_name` varchar(50) NOT NULL,
  `rol_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `rol_name`, `rol_status`) VALUES
(1, 'Paciente', 1),
(2, 'Medico', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `specialties`
--

CREATE TABLE `specialties` (
  `spe_id` int(11) NOT NULL,
  `spe_name` varchar(150) NOT NULL,
  `spe_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `specialties`
--

INSERT INTO `specialties` (`spe_id`, `spe_name`, `spe_status`) VALUES
(1, 'Internista', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `use_id` int(11) NOT NULL,
  `use_email` varchar(200) NOT NULL,
  `use_password` varchar(200) NOT NULL,
  `use_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`use_id`, `use_email`, `use_password`, `use_status`) VALUES
(1, 'etoledo@gmail.com', '1234', 1),
(2, 'cdiaz@gmail.com', '1234', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_rol`
--

CREATE TABLE `user_rol` (
  `uro_id` int(11) NOT NULL,
  `use_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `user_rol`
--

INSERT INTO `user_rol` (`uro_id`, `use_id`, `rol_id`) VALUES
(1, 1, 1),
(2, 2, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doc_id`),
  ADD KEY `doc_userrol` (`uro_id`),
  ADD KEY `doc_esp` (`spe_id`);

--
-- Indices de la tabla `medical_appointments`
--
ALTER TABLE `medical_appointments`
  ADD PRIMARY KEY (`map_id`),
  ADD KEY `doc_fk` (`doc_id`),
  ADD KEY `pat_fk` (`pat_id`);

--
-- Indices de la tabla `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pat_id`),
  ADD KEY `pact_userrol_fk` (`uro_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`spe_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`use_id`);

--
-- Indices de la tabla `user_rol`
--
ALTER TABLE `user_rol`
  ADD PRIMARY KEY (`uro_id`),
  ADD KEY `user_fk` (`use_id`),
  ADD KEY `rol_fk` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `medical_appointments`
--
ALTER TABLE `medical_appointments`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `patients`
--
ALTER TABLE `patients`
  MODIFY `pat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `specialties`
--
ALTER TABLE `specialties`
  MODIFY `spe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `use_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `user_rol`
--
ALTER TABLE `user_rol`
  MODIFY `uro_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doc_esp` FOREIGN KEY (`spe_id`) REFERENCES `specialties` (`spe_id`),
  ADD CONSTRAINT `doc_userrol` FOREIGN KEY (`uro_id`) REFERENCES `user_rol` (`uro_id`);

--
-- Filtros para la tabla `medical_appointments`
--
ALTER TABLE `medical_appointments`
  ADD CONSTRAINT `doc_fk` FOREIGN KEY (`doc_id`) REFERENCES `doctors` (`doc_id`),
  ADD CONSTRAINT `pat_fk` FOREIGN KEY (`pat_id`) REFERENCES `patients` (`pat_id`);

--
-- Filtros para la tabla `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `pact_userrol_fk` FOREIGN KEY (`uro_id`) REFERENCES `user_rol` (`uro_id`);

--
-- Filtros para la tabla `user_rol`
--
ALTER TABLE `user_rol`
  ADD CONSTRAINT `rol_fk` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`),
  ADD CONSTRAINT `user_fk` FOREIGN KEY (`use_id`) REFERENCES `users` (`use_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
