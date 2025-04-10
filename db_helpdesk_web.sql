-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2019 at 05:10 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_helpdesk_web`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_department`
--

CREATE TABLE `tbl_department` (
  `td_id` int(11) NOT NULL,
  `td_name` varchar(75) NOT NULL,
  `td_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_department`
--

INSERT INTO `tbl_department` (`td_id`, `td_name`, `td_description`) VALUES
(1, 'General', 'Not associated with a given department');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_priority`
--

CREATE TABLE `tbl_priority` (
  `tp_id` int(11) NOT NULL,
  `tp_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_priority`
--

INSERT INTO `tbl_priority` (`tp_id`, `tp_name`) VALUES
(1, 'Critical'),
(2, 'High'),
(3, 'Medium'),
(4, 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_service`
--

CREATE TABLE `tbl_service` (
  `ts_id` int(11) NOT NULL,
  `ts_name` varchar(225) NOT NULL,
  `ts_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_service`
--

INSERT INTO `tbl_service` (`ts_id`, `ts_name`, `ts_description`) VALUES
(1, 'General', 'Not associated with a given service');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ticket`
--

CREATE TABLE `tbl_ticket` (
  `tt_id` int(11) NOT NULL,
  `tt_user` int(11) NOT NULL,
  `tt_subject` varchar(225) DEFAULT NULL,
  `tt_department` int(11) NOT NULL,
  `tt_service` int(11) NOT NULL,
  `tt_priority` int(11) NOT NULL,
  `tt_message` longtext,
  `tt_status` enum('NEW','PROCESS','PENDING','CANCEL','DONE','DELETE') NOT NULL DEFAULT 'NEW',
  `tt_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `tu_id` int(11) NOT NULL,
  `tu_role` enum('admin','tech','customer') NOT NULL,
  `tu_user` varchar(100) NOT NULL UNIQUE,
  `tu_pass` varchar(100) NOT NULL DEFAULT '123',
  `tu_full_name` varchar(200) NOT NULL,
  `tu_email` varchar(150) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_department`
--
ALTER TABLE `tbl_department`
  ADD PRIMARY KEY (`td_id`);

--
-- Indexes for table `tbl_priority`
--
ALTER TABLE `tbl_priority`
  ADD PRIMARY KEY (`tp_id`);

--
-- Indexes for table `tbl_service`
--
ALTER TABLE `tbl_service`
  ADD PRIMARY KEY (`ts_id`);

--
-- Indexes for table `tbl_ticket`
--
ALTER TABLE `tbl_ticket`
  ADD PRIMARY KEY (`tt_id`),
  ADD KEY `tt_department` (`tt_department`),
  ADD KEY `tt_user` (`tt_user`),
  ADD KEY `tt_service` (`tt_service`),
  ADD KEY `tt_priority` (`tt_priority`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`tu_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_department`
--
ALTER TABLE `tbl_department`
  MODIFY `td_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_priority`
--
ALTER TABLE `tbl_priority`
  MODIFY `tp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_service`
--
ALTER TABLE `tbl_service`
  MODIFY `ts_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_ticket`
--
ALTER TABLE `tbl_ticket`
  MODIFY `tt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `tu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_ticket`
--
ALTER TABLE `tbl_ticket`
  ADD CONSTRAINT `tbl_ticket_ibfk_1` FOREIGN KEY (`tt_department`) REFERENCES `tbl_department` (`td_id`),
  ADD CONSTRAINT `tbl_ticket_ibfk_2` FOREIGN KEY (`tt_service`) REFERENCES `tbl_service` (`ts_id`),
  ADD CONSTRAINT `tbl_ticket_ibfk_3` FOREIGN KEY (`tt_priority`) REFERENCES `tbl_priority` (`tp_id`),
  ADD CONSTRAINT `tbl_ticket_ibfk_4` FOREIGN KEY (`tt_user`) REFERENCES `tbl_user` (`tu_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
