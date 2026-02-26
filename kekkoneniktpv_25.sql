-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 26, 2026 kell 09:53 EL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `kekkoneniktpv_25`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `category`
--

CREATE TABLE `category` (
  `idCategory` int(11) NOT NULL,
  `Category_Name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `nimi` varchar(25) NOT NULL,
  `parool` varchar(25) DEFAULT NULL,
  `koht` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `nimi`, `parool`, `koht`) VALUES
(1, 'Artjom', '1234', NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `product_`
--

CREATE TABLE `product_` (
  `idProduct` int(11) NOT NULL,
  `Product_Name` varchar(25) DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `Price` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `sale`
--

CREATE TABLE `sale` (
  `idSale` int(11) NOT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `idCustomer` int(11) DEFAULT NULL,
  `Count_pr` int(11) DEFAULT NULL,
  `Date_of_sale` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`idCategory`);

--
-- Indeksid tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indeksid tabelile `product_`
--
ALTER TABLE `product_`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indeksid tabelile `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`idSale`),
  ADD KEY `idProduct` (`idProduct`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `category`
--
ALTER TABLE `category`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT tabelile `product_`
--
ALTER TABLE `product_`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `sale`
--
ALTER TABLE `sale`
  MODIFY `idSale` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `product_`
--
ALTER TABLE `product_`
  ADD CONSTRAINT `product__ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`idCategory`);

--
-- Piirangud tabelile `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `product_` (`idProduct`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
