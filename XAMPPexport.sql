-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 16, 2026 kell 03:46 PL
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
-- Andmebaas: `veebipoodkekkonen`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaBrand` (IN `ID` INT)   begin
select * from brands;
delete from brands where brandID = ID;
select * from brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaKasutaja` (IN `ID` INT(1))   begin
select * from customers;
delete from customers where customerID = ID;
select * from customers;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaBrand` (IN `brand_nimi` VARCHAR(30))   begin
insert into brands (brandName) values (brand_nimi);
select * from brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaKasutaja` (IN `firstName` CHAR(20), IN `lastName` CHAR(20), IN `phone` INT(15), IN `email` VARCHAR(20), IN `street` VARCHAR(40), IN `city` CHAR(20), IN `state` CHAR(20), IN `zipCode` INT(20))   begin
insert into customers(first_name, last_name, phone, email, street, city, state_, zip_code) values (firstName, lastName, phone, email, street, city, state, zipCode);
select * from categories;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1tahte` (IN `taht` CHAR(1))   begin
DECLARE today timestamp DEFAULT CURRENT_DATE;
select * from brands where brandName like CONCAT (taht,'%');
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uletanudOrders` (IN `currentDate` DATE)   SELECT * FROM orders WHERE shipped_date< currentDate$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uuendaBrand` (IN `ID` INT(1), IN `uusBrandNimi` VARCHAR(30))   begin
select * from brands;
update brands set brandName= uusBrandNimi
where brandID= ID;
select * from brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `võrrabStocks` (IN `s` INT)   update stocks set quantity = quantity * 1.1$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `brands`
--

CREATE TABLE `brands` (
  `brandID` int(11) NOT NULL,
  `brandName` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `brands`
--

INSERT INTO `brands` (`brandID`, `brandName`) VALUES
(2, 'Nike');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `categories`
--

CREATE TABLE `categories` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `categories`
--

INSERT INTO `categories` (`categoryID`, `categoryName`) VALUES
(1, 'autod'),
(2, 'mõõbel');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customers`
--

CREATE TABLE `customers` (
  `customerID` int(11) NOT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` text DEFAULT NULL,
  `street` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state_` text DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customers`
--

INSERT INTO `customers` (`customerID`, `first_name`, `last_name`, `phone`, `email`, `street`, `city`, `state_`, `zip_code`) VALUES
(5, 'Dom', 'Dom', 2321321, 'dawad', 'rgsgesges565', 'tallinn', 'hsfesf', '21321');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `orders`
--

CREATE TABLE `orders` (
  `orderID` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `order_status` text DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `required_date` date DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `storeID` int(11) DEFAULT NULL,
  `staffID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `orders`
--

INSERT INTO `orders` (`orderID`, `customerID`, `order_status`, `order_date`, `required_date`, `shipped_date`, `storeID`, `staffID`) VALUES
(1, 5, 'shipped', '2025-10-29', '2026-01-28', '2026-02-01', 1, 1),
(2, 5, 'shipped', '2025-09-22', '2025-11-15', '2025-11-29', NULL, NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `products`
--

CREATE TABLE `products` (
  `productID` int(11) NOT NULL,
  `productName` varchar(50) NOT NULL,
  `brandID` int(11) DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `modelYear` int(11) DEFAULT NULL,
  `listPrice` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `staffs`
--

CREATE TABLE `staffs` (
  `staffID` int(11) NOT NULL,
  `first_name` text DEFAULT NULL,
  `last_name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `active` text DEFAULT NULL,
  `storeID` int(11) DEFAULT NULL,
  `managerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `staffs`
--

INSERT INTO `staffs` (`staffID`, `first_name`, `last_name`, `email`, `phone`, `active`, `storeID`, `managerID`) VALUES
(1, 'Dominic', 'Kekkonen', 'dominic.kekkonen', 3232323, 'jah', 1, 1);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stocks`
--

CREATE TABLE `stocks` (
  `storeID` int(11) DEFAULT NULL,
  `productID` int(11) DEFAULT NULL,
  `quatity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stocks`
--

INSERT INTO `stocks` (`storeID`, `productID`, `quatity`) VALUES
(NULL, NULL, 50),
(NULL, NULL, 50);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stores`
--

CREATE TABLE `stores` (
  `storeID` int(11) NOT NULL,
  `store_name` varchar(30) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` text DEFAULT NULL,
  `street` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state_` text DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stores`
--

INSERT INTO `stores` (`storeID`, `store_name`, `phone`, `email`, `street`, `city`, `state_`, `zip_code`) VALUES
(1, 'clothesTLN', 23232424, 'clothes@gmail.com', 'Raadiku45', 'Tallinn', 'Harjumaa', '12043');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brandID`),
  ADD UNIQUE KEY `brandName` (`brandName`);

--
-- Indeksid tabelile `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryID`),
  ADD UNIQUE KEY `categoryName` (`categoryName`);

--
-- Indeksid tabelile `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerID`);

--
-- Indeksid tabelile `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `customerID` (`customerID`);

--
-- Indeksid tabelile `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `brandID` (`brandID`),
  ADD KEY `categoryID` (`categoryID`);

--
-- Indeksid tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staffID`),
  ADD KEY `storeID` (`storeID`),
  ADD KEY `managerID` (`managerID`);

--
-- Indeksid tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD KEY `storeID` (`storeID`),
  ADD KEY `productID` (`productID`);

--
-- Indeksid tabelile `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`storeID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `brands`
--
ALTER TABLE `brands`
  MODIFY `brandID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT tabelile `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT tabelile `customers`
--
ALTER TABLE `customers`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `orders`
--
ALTER TABLE `orders`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT tabelile `products`
--
ALTER TABLE `products`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staffID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT tabelile `stores`
--
ALTER TABLE `stores`
  MODIFY `storeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`);

--
-- Piirangud tabelile `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brandID`) REFERENCES `brands` (`brandID`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`);

--
-- Piirangud tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `staffs_ibfk_1` FOREIGN KEY (`storeID`) REFERENCES `stores` (`storeID`),
  ADD CONSTRAINT `staffs_ibfk_2` FOREIGN KEY (`managerID`) REFERENCES `staffs` (`staffID`);

--
-- Piirangud tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_ibfk_1` FOREIGN KEY (`storeID`) REFERENCES `stores` (`storeID`),
  ADD CONSTRAINT `stocks_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
