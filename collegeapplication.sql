
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 03 مايو 2024 الساعة 21:05
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `collegeapplication`
--

DELIMITER $$
--
-- الإجراءات
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStudentApplication` (IN `userId` INT, IN `newApplication` TEXT)   BEGIN
    UPDATE students
    SET application = newApplication
    WHERE id = userId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- بنية الجدول `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `personal_details` text DEFAULT NULL,
  `academic_qualifications` text DEFAULT NULL,
  `documents` longblob DEFAULT NULL,
  `status` varchar(100) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `department` varchar(100) NOT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `lastname`, `phone`, `dob`, `address`, `city`, `department`, `state`, `country`, `zipcode`) VALUES
(1, 'b.e.2.g.2017@gmail.com', 'fatem@gmail.com', '$2y$10$AJ502tPcL11KLgKsLg2SD.z6dFQTlGwwBG0vJhF7cHoZnv4K5b.Ee', 'Mohammed', '0504242406', '2024-05-08', 'SP 85139987', 'Florida', 'Engineering', 'Florida', 'الولايات المتحدة', '34249');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_applications`
-- (See below for the actual view)
--
CREATE TABLE `view_applications` (
`id` int(11)
,`user_id` int(11)
,`user_name` varchar(255)
,`user_lastname` varchar(255)
,`personal_details` text
,`academic_qualifications` text
,`documents` longblob
,`status` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_user_profile`
-- (See below for the actual view)
--
CREATE TABLE `view_user_profile` (
`id` int(11)
,`name` varchar(255)
,`lastname` varchar(255)
,`email` varchar(255)
,`phone` varchar(50)
,`dob` date
,`address` varchar(255)
,`city` varchar(100)
,`state` varchar(100)
,`country` varchar(100)
,`zipcode` varchar(20)
,`department` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `view_applications`
--
DROP TABLE IF EXISTS `view_applications`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_applications`  AS SELECT `a`.`id` AS `id`, `a`.`user_id` AS `user_id`, `u`.`name` AS `user_name`, `u`.`lastname` AS `user_lastname`, `a`.`personal_details` AS `personal_details`, `a`.`academic_qualifications` AS `academic_qualifications`, `a`.`documents` AS `documents`, `a`.`status` AS `status` FROM (`applications` `a` join `users` `u` on(`a`.`user_id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_user_profile`
--
DROP TABLE IF EXISTS `view_user_profile`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_user_profile`  AS SELECT `users`.`id` AS `id`, `users`.`name` AS `name`, `users`.`lastname` AS `lastname`, `users`.`email` AS `email`, `users`.`phone` AS `phone`, `users`.`dob` AS `dob`, `users`.`address` AS `address`, `users`.`city` AS `city`, `users`.`state` AS `state`, `users`.`country` AS `country`, `users`.`zipcode` AS `zipcode`, `users`.`department` AS `department` FROM `users` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
