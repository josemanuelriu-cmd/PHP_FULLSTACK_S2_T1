
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `culampolla`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adreses`
--

CREATE TABLE `adreses` (
  `IDAdreca` int(11) NOT NULL,
  `Carrer` varchar(100) NOT NULL,
  `Numero` varchar(10) NOT NULL,
  `Pis` varchar(3) NOT NULL,
  `Porta` varchar(2) NOT NULL,
  `Ciutat` varchar(50) NOT NULL,
  `Codi_postal` int(11) NOT NULL,
  `Pais` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `IDClient` int(11) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `IDAdreca` int(11) DEFAULT NULL,
  `Telefon` varchar(15) DEFAULT NULL,
  `Correu electronic` varchar(200) DEFAULT NULL,
  `Data registre` date NOT NULL DEFAULT current_timestamp(),
  `Establiment recomenat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleats`
--

CREATE TABLE `empleats` (
  `IDEmpleat` int(11) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `Establiment` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveidors`
--

CREATE TABLE `proveidors` (
  `IDProveidor` int(11) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `IDAdreca` int(11) NOT NULL,
  `Telefon` varchar(15) NOT NULL,
  `Fax` varchar(15) DEFAULT NULL,
  `NIF` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ulleres`
--

CREATE TABLE `ulleres` (
  `IDUllera` int(11) NOT NULL,
  `Marca` varchar(50) NOT NULL,
  `Graduacio dret` decimal(10,0) NOT NULL,
  `Graduacio esquerre` decimal(10,0) NOT NULL,
  `Color dret` varchar(20) NOT NULL,
  `Color esquerre` varchar(20) NOT NULL,
  `Tipus muntura` varchar(10) NOT NULL,
  `Color muntura` varchar(20) NOT NULL,
  `Preu` decimal(10,0) NOT NULL,
  `IDProveidor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendes`
--

CREATE TABLE `vendes` (
  `IDVenta` bigint(20) NOT NULL,
  `IDEmpleat` int(11) NOT NULL,
  `IDClient` int(11) NOT NULL,
  `IDUllera` int(11) NOT NULL,
  `Data venta` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `adreses`
--
ALTER TABLE `adreses`
  ADD PRIMARY KEY (`IDAdreca`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD UNIQUE KEY `IDClient` (`IDClient`),
  ADD KEY `IDClient_2` (`IDClient`),
  ADD KEY `IDAdreca` (`IDAdreca`);

--
-- Indices de la tabla `empleats`
--
ALTER TABLE `empleats`
  ADD UNIQUE KEY `IDEmpleat` (`IDEmpleat`),
  ADD KEY `IDEmpleat_2` (`IDEmpleat`);

--
-- Indices de la tabla `proveidors`
--
ALTER TABLE `proveidors`
  ADD UNIQUE KEY `IDProveidor` (`IDProveidor`),
  ADD KEY `IDAdreca` (`IDAdreca`);

--
-- Indices de la tabla `ulleres`
--
ALTER TABLE `ulleres`
  ADD UNIQUE KEY `IDUllera` (`IDUllera`),
  ADD KEY `IDProveidor` (`IDProveidor`);

--
-- Indices de la tabla `vendes`
--
ALTER TABLE `vendes`
  ADD UNIQUE KEY `IDVenda` (`IDVenta`),
  ADD UNIQUE KEY `Numempleat` (`IDEmpleat`),
  ADD KEY `IDEmpleat` (`IDEmpleat`,`IDClient`,`IDUllera`),
  ADD KEY `IDUllera` (`IDUllera`),
  ADD KEY `IDClient` (`IDClient`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `adreses`
--
ALTER TABLE `adreses`
  MODIFY `IDAdreca` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `IDClient` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleats`
--
ALTER TABLE `empleats`
  MODIFY `IDEmpleat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveidors`
--
ALTER TABLE `proveidors`
  MODIFY `IDProveidor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ulleres`
--
ALTER TABLE `ulleres`
  MODIFY `IDUllera` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vendes`
--
ALTER TABLE `vendes`
  MODIFY `IDVenta` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`IDAdreca`) REFERENCES `adreses` (`IDAdreca`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveidors`
--
ALTER TABLE `proveidors`
  ADD CONSTRAINT `proveidors_ibfk_1` FOREIGN KEY (`IDAdreca`) REFERENCES `adreses` (`IDAdreca`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ulleres`
--
ALTER TABLE `ulleres`
  ADD CONSTRAINT `ulleres_ibfk_1` FOREIGN KEY (`IDProveidor`) REFERENCES `proveidors` (`IDProveidor`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `vendes`
--
ALTER TABLE `vendes`
  ADD CONSTRAINT `vendes_ibfk_1` FOREIGN KEY (`IDEmpleat`) REFERENCES `empleats` (`IDEmpleat`) ON UPDATE CASCADE,
  ADD CONSTRAINT `vendes_ibfk_2` FOREIGN KEY (`IDUllera`) REFERENCES `ulleres` (`IDUllera`) ON UPDATE CASCADE,
  ADD CONSTRAINT `vendes_ibfk_3` FOREIGN KEY (`IDClient`) REFERENCES `clients` (`IDClient`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
