-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 17, 2023 at 05:19 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zms`
--

-- --------------------------------------------------------

--
-- Table structure for table `animal`
--

CREATE TABLE `animal` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `kind` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `animal`
--

INSERT INTO `animal` (`id`, `name`, `kind`, `type`, `age`, `gender`) VALUES
(1112, 'WAL1', 'West African Lungfish', 'Fish', 1, 'Female'),
(1113, 'PS1', 'Pumpkinseed Sunfish', 'Fish', 3, 'Male'),
(1114, 'LS1', 'Leopard Shark', 'Fish', 2, 'Female'),
(1115, 'BAF1', 'Banded Archer Fish', 'Fish', 1, 'Male'),
(1116, 'C1', 'Cichlid', 'Fish', 2, 'Female'),
(2230, 'L2', 'Lion', 'Mammal', 3, 'Female'),
(2231, 'G1', 'Gorilla', 'Mammal', 0, 'Female'),
(2232, 'PB1', 'Polar Bear', 'Mammal', 4, 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `cares_for`
--

CREATE TABLE `cares_for` (
  `uid` int(11) NOT NULL,
  `aid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cares_for`
--

INSERT INTO `cares_for` (`uid`, `aid`) VALUES
(100002, 1112),
(100002, 1115),
(100003, 1113),
(100004, 1115),
(100005, 1116),
(100005, 2231),
(100007, 1113),
(100007, 1114),
(100009, 1116),
(100009, 2232),
(100022, 1115);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `adminemail` varchar(100) NOT NULL,
  `adminpassword` varchar(1000) NOT NULL,
  `phno` varchar(10) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT 750000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `name`, `adminemail`, `adminpassword`, `phno`, `salary`) VALUES
(100000, 'Husheil', 'hush@zooadmin.com', 'hush', '7994025199', 600000),
(100001, 'Peter', 'peter@zooadmin.com', 'hush', '98446721', 750000),
(100002, 'James', 'james@zooadmin.com', 'hush', '9206917173', 750000),
(100003, 'John', 'john@zooadmin.com', 'hush', '9902311414', 750000),
(100004, 'Andrew', 'andrew@zooadmin.com', 'hush', '40403693', 750000),
(100005, 'Bartholomew', 'bartholomew@zooadmin.com', 'hush', '28495525', 750000),
(100006, 'Young James', 'youngjames@zooadmin.com', 'hush', '9902788600', 750000),
(100007, 'Judas', 'judas@zooadmin.com', 'hush', '9136110504', 750000),
(100008, 'Thaddeus', 'thaddeus@zooadmin.com', 'hush', '9380176312', 750000),
(100009, 'Matthew', 'matthew@zooadmin.com', 'hush', '9844181202', 750000),
(100010, 'Philip', 'philip@zooadmin.com', 'hush', '9845073493', 750000),
(100011, 'Simon', 'simon@zooadmin.com', 'hush', '9567795730', 750000),
(100012, 'Thomas', 'thomas@zooadmin.com', 'hush', '9567795710', 750000),
(100022, 'Luke', 'luke@zooadmin.com', 'hush', '67854468', 750000);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` int(11) DEFAULT 1000,
  `uid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `date`, `amount`, `uid`) VALUES
(1001, '2023-01-14', 1000, 1),
(1002, '2023-01-14', 1000, 1),
(1003, '2023-01-19', 1000, 1),
(10002, '2023-01-11', 1000, 1),
(10003, '2023-01-07', 1000, 1),
(10004, '2023-03-16', 1000, 1),
(10005, '2023-02-14', 1000, 1),
(10006, '2023-02-14', 1000, 1),
(10007, '2023-01-21', 1000, 1),
(10008, '2023-01-21', 1000, 1),
(10009, '2023-01-21', 1000, 1),
(10010, '2023-01-06', 1000, 1),
(10011, '2023-01-13', 1000, 1),
(10012, '2023-01-12', 1000, 1),
(10013, '2023-01-13', 1000, 1),
(10014, '2023-01-27', 1000, 1),
(10015, '2023-01-26', 1000, 3),
(10016, '2023-01-26', 1000, 3),
(10017, '2023-03-16', 1000, 1),
(10018, '2023-01-14', 1000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `phno` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `gender`, `username`, `email`, `password`, `phno`) VALUES
(1, 'hush', 'Female', 'husheil', 'husheilm@gmail.com', 'pbkdf2:sha256:260000$pRDDhekr1IkTAuu5$349a83a47ff5a73fcb77a351ce948ff65d8aefc3dad85f8ccf5a15c830758ad2', 977655),
(3, 'Krithika', 'Female', 'Kritz', 'krithika@gmail.com', 'pbkdf2:sha256:260000$jZZnvgb8tU4RE6Fg$0815d87e500990f3412c6b3d4da0f3f3da0e0139c0683695c6de3ddf78cc7296', 67786557);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `animal`
--
ALTER TABLE `animal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `cares_for`
--
ALTER TABLE `cares_for`
  ADD PRIMARY KEY (`uid`,`aid`),
  ADD KEY `aid` (`aid`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `adminemail` (`adminemail`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_ibfk_1` (`uid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `animal`
--
ALTER TABLE `animal`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2233;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100023;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10019;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cares_for`
--
ALTER TABLE `cares_for`
  ADD CONSTRAINT `cares_for_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cares_for_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `animal` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
