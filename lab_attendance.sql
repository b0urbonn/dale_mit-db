-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2024 at 02:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lab_attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `class_schedule_table`
--

CREATE TABLE `class_schedule_table` (
  `Sched_ID` int(11) NOT NULL,
  `Class_Name` varchar(100) DEFAULT NULL,
  `Day_of_Week` varchar(20) DEFAULT NULL,
  `Start_Time` time DEFAULT NULL,
  `End_Time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_schedule_table`
--

INSERT INTO `class_schedule_table` (`Sched_ID`, `Class_Name`, `Day_of_Week`, `Start_Time`, `End_Time`) VALUES
(36, 'dale', 'Monday', '22:22:00', '23:23:00');

-- --------------------------------------------------------

--
-- Table structure for table `laboratory_entries_table`
--

CREATE TABLE `laboratory_entries_table` (
  `Entry_ID` int(11) NOT NULL,
  `Student_ID` int(11) DEFAULT NULL,
  `Entry_TimeIn` datetime DEFAULT NULL,
  `Entry_TimeOut` datetime DEFAULT NULL,
  `Purpose_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laboratory_entries_table`
--

INSERT INTO `laboratory_entries_table` (`Entry_ID`, `Student_ID`, `Entry_TimeIn`, `Entry_TimeOut`, `Purpose_ID`) VALUES
(43, 42, '2024-12-20 08:59:00', '0000-00-00 00:00:00', 1),
(44, 42, '2024-12-20 09:00:41', NULL, 1),
(45, 43, '2024-12-20 09:08:16', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `purpose_table`
--

CREATE TABLE `purpose_table` (
  `Purpose_ID` int(11) NOT NULL,
  `Description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purpose_table`
--

INSERT INTO `purpose_table` (`Purpose_ID`, `Description`) VALUES
(1, 'Scheduled Class'),
(2, 'Unscheduled_Class/Others');

-- --------------------------------------------------------

--
-- Table structure for table `student_table`
--

CREATE TABLE `student_table` (
  `Student_ID` int(11) NOT NULL,
  `Student_Name` varchar(100) DEFAULT NULL,
  `Student_Address` varchar(200) DEFAULT NULL,
  `Student_ContactNo` varchar(15) DEFAULT NULL,
  `Student_Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_table`
--

INSERT INTO `student_table` (`Student_ID`, `Student_Name`, `Student_Address`, `Student_ContactNo`, `Student_Email`) VALUES
(42, 'Dale Ogbac', 'Santa Cruz, Marinduque', '09021022626', 'ogbac.raphaeldale@marsu.edu.ph'),
(43, 'sdasad', 'dsadas', 'sadsad', 'sadsad');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class_schedule_table`
--
ALTER TABLE `class_schedule_table`
  ADD PRIMARY KEY (`Sched_ID`);

--
-- Indexes for table `laboratory_entries_table`
--
ALTER TABLE `laboratory_entries_table`
  ADD PRIMARY KEY (`Entry_ID`),
  ADD KEY `Purpose_ID` (`Purpose_ID`),
  ADD KEY `laboratory_entries_table_ibfk_1` (`Student_ID`);

--
-- Indexes for table `purpose_table`
--
ALTER TABLE `purpose_table`
  ADD PRIMARY KEY (`Purpose_ID`);

--
-- Indexes for table `student_table`
--
ALTER TABLE `student_table`
  ADD PRIMARY KEY (`Student_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class_schedule_table`
--
ALTER TABLE `class_schedule_table`
  MODIFY `Sched_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `laboratory_entries_table`
--
ALTER TABLE `laboratory_entries_table`
  MODIFY `Entry_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `purpose_table`
--
ALTER TABLE `purpose_table`
  MODIFY `Purpose_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_table`
--
ALTER TABLE `student_table`
  MODIFY `Student_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `laboratory_entries_table`
--
ALTER TABLE `laboratory_entries_table`
  ADD CONSTRAINT `laboratory_entries_table_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `student_table` (`Student_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `laboratory_entries_table_ibfk_2` FOREIGN KEY (`Purpose_ID`) REFERENCES `purpose_table` (`Purpose_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
