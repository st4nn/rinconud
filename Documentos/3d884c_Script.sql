-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 04-07-2012 a las 05:05:31
-- Versión del servidor: 5.5.16
-- Versión de PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `broncoce_usuarios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company`
--

CREATE TABLE IF NOT EXISTS `Company` (
  `IdCompany` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `Contact` varchar(200) DEFAULT NULL,
  `IdOwn` int(11) NOT NULL COMMENT 'Id of the User who created',
  PRIMARY KEY (`IdCompany`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `Company`
--

INSERT INTO `Company` (`IdCompany`, `Name`, `url`, `Contact`, `IdOwn`) VALUES
(1, 'Support', NULL, NULL, 1),
(2, 'CeHis Ltda', 'http://cehis.net', 'Fabian Avila', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Function`
--

CREATE TABLE IF NOT EXISTS `Function` (
  `idFunction` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(85) COLLATE utf8_spanish2_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `AssociatedControl` varchar(120) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`idFunction`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `Function`
--

INSERT INTO `Function` (`idFunction`, `Name`, `Description`, `AssociatedControl`) VALUES
(1, 'DashBoard', 'View DashBoard', 'lnkHome'),
(2, 'Tools', 'Use Tools', 'lnkTools'),
(3, 'Custom Player', 'Generate Custom Player', 'lnkCustomPlayer'),
(4, 'Export Code', 'Export Code', 'lnkExportCode'),
(5, 'My Account', 'View your Account', 'lnkMyAccount'),
(6, 'Personal Information', 'Change Personal Information', 'lnkPersonalInformation'),
(7, 'Access Data', 'Change your Password', 'lnkAccessData'),
(8, 'Custom Template', 'Custom Template', 'lnkCustomTemplate'),
(9, 'Users', 'Create, Edit and delete User and your data', 'lnkUsers'),
(10, 'Creating Users', 'To create Users', 'lnkCreatingUsers'),
(11, 'My Users', 'View your Users', 'lnkMyUsers'),
(12, 'Permissions', 'View your Permissions', 'lnkPermissions'),
(13, 'Analytics', 'View Analytics', 'lnkAnalytics'),
(14, 'My Services', 'View your own Services', 'lnkMyService');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Language`
--

CREATE TABLE IF NOT EXISTS `Language` (
  `IdLanguage` int(11) NOT NULL AUTO_INCREMENT,
  `Language` varchar(30) NOT NULL,
  `Welcome` varchar(255) DEFAULT NULL,
  `Home` varchar(255) DEFAULT NULL,
  `Tools` varchar(255) DEFAULT NULL,
  `Analytics` varchar(255) DEFAULT NULL,
  `MyAccount` varchar(255) DEFAULT NULL,
  `Logout` varchar(255) DEFAULT NULL,
  `CustomPlayer` varchar(255) DEFAULT NULL,
  `ExportCode` varchar(255) DEFAULT NULL,
  `PersonalInformation` varchar(255) DEFAULT NULL,
  `CustomTemplate` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `DisplayName` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Company` varchar(255) DEFAULT NULL,
  `Save` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdLanguage`),
  UNIQUE KEY `Language` (`Language`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `Language`
--

INSERT INTO `Language` (`IdLanguage`, `Language`, `Welcome`, `Home`, `Tools`, `Analytics`, `MyAccount`, `Logout`, `CustomPlayer`, `ExportCode`, `PersonalInformation`, `CustomTemplate`, `Name`, `DisplayName`, `Email`, `Company`, `Save`) VALUES
(1, 'English', 'Welcome', 'Home', 'Tools', 'Analytics', 'My Account', 'Logout', 'Custom Player', 'Expot Code', 'Personal Information', 'Template', 'Name', 'Display Name', 'Email', 'Company', 'Save'),
(2, 'Espanol', 'Bienvenido', 'Inicio', 'Herramientas', 'Estadísticas', 'Mi Cuenta', 'Cerrar Sesión', 'Personalizar Reproductor', 'Exportar Codigo', 'Información Personal', 'Plantilla', 'Nombre', 'Alias', 'Correo', 'Compañía', 'Guardar'),
(3, 'français', 'Accueil', 'Initiation', 'Outils', 'Statistiques', 'Mon Compte', 'Déconnexion', 'lecteur personnalisé', 'L''exportation de code', 'des renseignements personnels', 'modèle', 'Nom', 'Nom d''affichage', 'Courrier', 'Entreprise', 'Sauver'),
(4, 'Deutsch', 'Willkommen', 'Einleitung', 'Werkzeuge', 'Statistik', 'Mein Konto', 'Ausloggen', 'Benutzerdefinierte Spieler', 'Export-Code', 'Persönliche Informationen', 'Schablone', 'Name', 'Display Name', 'Post', 'Firma', 'Sparen');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Login`
--

CREATE TABLE IF NOT EXISTS `Login` (
  `IdLogin` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(50) NOT NULL,
  `Pass` varchar(50) NOT NULL,
  `State` varchar(45) NOT NULL,
  PRIMARY KEY (`IdLogin`),
  UNIQUE KEY `User` (`User`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `Login`
--

INSERT INTO `Login` (`IdLogin`, `User`, `Pass`, `State`) VALUES
(1, 'admin', '1c7a92ae351d4e21ebdfb897508f59d6', 'Active'),
(2, 'Prueba2', 'd8ca6948fe2374ff482515e8fcd502bb', 'Active'),
(3, 'Prueba3', 'eabb63f16af172aca97381a646e5a7ef', 'Active'),
(4, 'Prueba4', '33736c73cc47c6c9a13b3251776cfc14', 'Active'),
(7, 'Prueba5', 'e9c94c05ec976a32b0636d32e6aff785', 'Active'),
(8, 'hieluki', '26061f1a5b4183bab44e4ecc6ed342bf', 'Active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Login_has_Products`
--

CREATE TABLE IF NOT EXISTS `Login_has_Products` (
  `IdLogin_has_Product` varchar(45) NOT NULL,
  `Login_IdLogin` int(11) NOT NULL,
  `Products_idProduct` int(11) NOT NULL,
  PRIMARY KEY (`IdLogin_has_Product`),
  KEY `fk_Login_has_Products_Products1` (`Products_idProduct`),
  KEY `fk_Login_has_Products_Login1` (`Login_IdLogin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Permissions`
--

CREATE TABLE IF NOT EXISTS `Permissions` (
  `IdPermission` int(11) NOT NULL AUTO_INCREMENT,
  `idFunction` int(11) NOT NULL,
  `IdLogin` int(11) NOT NULL,
  PRIMARY KEY (`IdPermission`),
  KEY `fk_Function_has_Login_Login1` (`IdLogin`),
  KEY `fk_Function_has_Login_Function1` (`idFunction`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=72 ;

--
-- Volcado de datos para la tabla `Permissions`
--

INSERT INTO `Permissions` (`IdPermission`, `idFunction`, `IdLogin`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 1, 7),
(16, 3, 7),
(17, 4, 7),
(18, 5, 7),
(19, 6, 7),
(20, 7, 7),
(21, 8, 7),
(22, 9, 7),
(23, 10, 7),
(24, 11, 7),
(25, 13, 7),
(26, 14, 7),
(57, 1, 2),
(58, 3, 2),
(59, 4, 2),
(60, 5, 2),
(61, 6, 2),
(62, 7, 2),
(63, 8, 2),
(64, 9, 2),
(65, 10, 2),
(66, 11, 2),
(67, 13, 2),
(68, 14, 2),
(69, 1, 8),
(70, 3, 8),
(71, 4, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Products`
--

CREATE TABLE IF NOT EXISTS `Products` (
  `idProduct` int(11) NOT NULL AUTO_INCREMENT,
  ` Name` varchar(115) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `idTypeProduct` int(11) NOT NULL,
  PRIMARY KEY (`idProduct`),
  KEY `fk_Products_TypeProducts1` (`idTypeProduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RelationUsers`
--

CREATE TABLE IF NOT EXISTS `RelationUsers` (
  `idRelationUsers` int(11) NOT NULL AUTO_INCREMENT,
  `IdSonUser` int(11) DEFAULT NULL,
  `IdFatherUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRelationUsers`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `RelationUsers`
--

INSERT INTO `RelationUsers` (`idRelationUsers`, `IdSonUser`, `IdFatherUser`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roll`
--

CREATE TABLE IF NOT EXISTS `Roll` (
  `idRoll` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(85) COLLATE utf8_spanish2_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`idRoll`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `Roll`
--

INSERT INTO `Roll` (`idRoll`, `Name`, `Description`) VALUES
(1, 'Admin', 'Administrator'),
(2, 'Reseller', 'Reseller'),
(3, 'Client', 'Client');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roll_has_Function`
--

CREATE TABLE IF NOT EXISTS `Roll_has_Function` (
  `IdRoll_has_Function` int(11) NOT NULL AUTO_INCREMENT,
  `idRoll` int(11) NOT NULL,
  `idFunction` int(11) NOT NULL,
  PRIMARY KEY (`IdRoll_has_Function`),
  KEY `fk_Roll_has_Function_Function1` (`idFunction`),
  KEY `fk_Roll_has_Function_Roll1` (`idRoll`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=37 ;

--
-- Volcado de datos para la tabla `Roll_has_Function`
--

INSERT INTO `Roll_has_Function` (`IdRoll_has_Function`, `idRoll`, `idFunction`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 2, 1),
(16, 2, 3),
(17, 2, 4),
(18, 2, 5),
(19, 2, 6),
(20, 2, 7),
(21, 2, 8),
(22, 2, 9),
(23, 2, 10),
(24, 2, 11),
(25, 2, 13),
(26, 2, 14),
(27, 3, 1),
(28, 3, 2),
(29, 3, 3),
(30, 3, 4),
(31, 3, 5),
(32, 3, 6),
(33, 3, 7),
(34, 3, 8),
(35, 3, 13),
(36, 3, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roll_has_Roll`
--

CREATE TABLE IF NOT EXISTS `Roll_has_Roll` (
  `idRecord` int(11) NOT NULL AUTO_INCREMENT,
  `IdRollParent` int(11) DEFAULT NULL,
  `IdRollChildren` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRecord`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `Roll_has_Roll`
--

INSERT INTO `Roll_has_Roll` (`idRecord`, `IdRollParent`, `IdRollChildren`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 2),
(5, 2, 1),
(6, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TypeProducts`
--

CREATE TABLE IF NOT EXISTS `TypeProducts` (
  `idTypeProduct` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(85) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`idTypeProduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `UsersData`
--

CREATE TABLE IF NOT EXISTS `UsersData` (
  `IdUsersData` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) NOT NULL,
  `NickName` varchar(80) NOT NULL,
  `mail` varchar(200) DEFAULT NULL,
  `IdCompany` int(11) NOT NULL,
  `urlFacebook` varchar(150) DEFAULT NULL,
  `urlTwitter` varchar(150) DEFAULT NULL,
  `IdInitialRoll` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdUsersData`),
  KEY `IdCompany` (`IdCompany`),
  KEY `IdUsersData` (`IdUsersData`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `UsersData`
--

INSERT INTO `UsersData` (`IdUsersData`, `Name`, `NickName`, `mail`, `IdCompany`, `urlFacebook`, `urlTwitter`, `IdInitialRoll`) VALUES
(1, 'Admin', 'Admin', '', 1, '', NULL, '1'),
(2, 'Tools', 'Use Tools', 'lnkTools', 1, '123', '', '3'),
(3, 'Prueba3', 'Prueba3', 'Prueba3@Prueba.com', 1, '', '', '1'),
(4, 'Prueba4', 'Prueba4', 'Prueba4@Prueba.com', 1, '', '', '1'),
(7, 'Prueba5', 'Prueba5', 'Prueba5@prueba.com', 1, '', '', '1'),
(8, 'fabianavila', 'favila', 'hieluki@gmail.com', 2, '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `UsersTransactions`
--

CREATE TABLE IF NOT EXISTS `UsersTransactions` (
  `idUsersTransactions` int(11) NOT NULL AUTO_INCREMENT,
  `IdUser` int(11) NOT NULL,
  `IdMasterUser` int(11) NOT NULL,
  `Operation` varchar(255) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Create\nUpdate\nDeacti',
  `Date` date NOT NULL,
  PRIMARY KEY (`idUsersTransactions`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `UsersTransactions`
--

INSERT INTO `UsersTransactions` (`idUsersTransactions`, `IdUser`, `IdMasterUser`, `Operation`, `Date`) VALUES
(1, 2, 1, 'Create', '2012-07-03'),
(2, 3, 1, 'Create', '2012-07-03'),
(3, 4, 1, 'Create', '2012-07-03'),
(4, 7, 1, 'Create', '2012-07-03'),
(5, 8, 2, 'Create', '2012-07-03'),
(6, 8, 2, 'Update', '2012-07-03'),
(7, 2, 2, 'Update', '2012-07-03'),
(8, 2, 1, 'Update', '2012-07-03');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Login_has_Products`
--
ALTER TABLE `Login_has_Products`
  ADD CONSTRAINT `fk_Login_has_Products_Login1` FOREIGN KEY (`Login_IdLogin`) REFERENCES `Login` (`IdLogin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Login_has_Products_Products1` FOREIGN KEY (`Products_idProduct`) REFERENCES `Products` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Permissions`
--
ALTER TABLE `Permissions`
  ADD CONSTRAINT `fk_Function_has_Login_Function1` FOREIGN KEY (`idFunction`) REFERENCES `Function` (`idFunction`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Function_has_Login_Login1` FOREIGN KEY (`IdLogin`) REFERENCES `Login` (`IdLogin`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `fk_Products_TypeProducts1` FOREIGN KEY (`idTypeProduct`) REFERENCES `TypeProducts` (`idTypeProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Roll_has_Function`
--
ALTER TABLE `Roll_has_Function`
  ADD CONSTRAINT `fk_Roll_has_Function_Function1` FOREIGN KEY (`idFunction`) REFERENCES `Function` (`idFunction`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Roll_has_Function_Roll1` FOREIGN KEY (`idRoll`) REFERENCES `Roll` (`idRoll`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `UsersData`
--
ALTER TABLE `UsersData`
  ADD CONSTRAINT `IdCompany` FOREIGN KEY (`IdCompany`) REFERENCES `Company` (`IdCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdUsersData` FOREIGN KEY (`IdUsersData`) REFERENCES `Login` (`IdLogin`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
