-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 28 mai 2025 à 17:13
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `train_ticket_system`
--

-- --------------------------------------------------------

--
-- Structure de la table `journeys`
--

CREATE TABLE `journeys` (
  `id` int(11) NOT NULL,
  `train_id` int(11) DEFAULT NULL,
  `departure_station_id` int(11) DEFAULT NULL,
  `arrival_station_id` int(11) DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `available_seats` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `journey_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'SCHEDULED'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `journeys`
--

INSERT INTO `journeys` (`id`, `train_id`, `departure_station_id`, `arrival_station_id`, `departure_time`, `arrival_time`, `available_seats`, `price`, `journey_date`, `status`) VALUES
(1, 1, 1, 2, '2025-05-31 08:00:00', '2025-05-31 12:00:00', 180, '75.50', '2025-05-31', 'ONTIME'),
(2, 1, 2, 3, '2025-05-31 14:00:00', '2025-05-31 18:00:00', 190, '85.00', '2025-05-31', 'ONTIME'),
(3, 2, 3, 4, '2025-05-31 09:30:00', '2025-05-31 11:30:00', 140, '45.00', '2025-05-31', 'ONTIME'),
(4, 3, 1, 4, '2025-05-31 16:00:00', '2025-05-31 19:00:00', 170, '65.00', '2025-05-31', 'ONTIME'),
(5, 1, 1, 2, '2025-06-01 08:00:00', '2025-06-01 12:00:00', 180, '75.50', '2025-06-01', 'ONTIME'),
(6, 2, 2, 3, '2025-05-31 10:00:00', '2025-05-31 18:00:00', 145, '55.00', '2025-05-31', 'SCHEDULED'),
(7, 1, 1, 2, '2025-05-28 08:00:00', '2025-05-28 12:00:00', 180, '75.50', '2025-05-28', 'SCHEDULED'),
(8, 1, 2, 3, '2025-05-28 14:00:00', '2025-05-28 18:00:00', 190, '85.00', '2025-05-28', 'SCHEDULED'),
(9, 2, 3, 4, '2025-05-28 09:30:00', '2025-05-28 11:30:00', 140, '45.00', '2025-05-28', 'SCHEDULED'),
(10, 1, 1, 3, '2025-05-28 16:00:00', '2025-05-28 20:00:00', 170, '95.00', '2025-05-28', 'SCHEDULED'),
(11, 1, 1, 2, '2025-05-29 08:00:00', '2025-05-29 12:00:00', 180, '75.50', '2025-05-29', 'SCHEDULED'),
(12, 2, 2, 3, '2025-05-29 10:00:00', '2025-05-29 14:00:00', 145, '55.00', '2025-05-29', 'SCHEDULED');

-- --------------------------------------------------------

--
-- Structure de la table `routes`
--

CREATE TABLE `routes` (
  `id` int(11) NOT NULL,
  `train_id` int(11) DEFAULT NULL,
  `station_id` int(11) DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `distance_from_start` decimal(10,2) DEFAULT NULL,
  `stop_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `routes`
--

INSERT INTO `routes` (`id`, `train_id`, `station_id`, `arrival_time`, `departure_time`, `distance_from_start`, `stop_number`) VALUES
(1, 1, 1, NULL, '08:00:00', '0.00', 1),
(2, 1, 2, '12:00:00', NULL, '225.00', 2),
(3, 2, 3, NULL, '09:30:00', '0.00', 1),
(4, 2, 4, '11:30:00', NULL, '120.00', 2);

-- --------------------------------------------------------

--
-- Structure de la table `stations`
--

CREATE TABLE `stations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `code` varchar(10) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `stations`
--

INSERT INTO `stations` (`id`, `name`, `city`, `state`, `code`, `is_active`) VALUES
(1, 'Station Sfax', 'Sfax', NULL, 'SFX', 1),
(2, 'Station Bourguiba', 'Monastir', NULL, 'MON', 1),
(3, 'Gare Tunis', 'Tunis', NULL, 'TUN', 1),
(4, 'Gare Sousse', 'Sousse', NULL, 'ETO', 1),
(5, 'Gare Gabes', 'Gabes', NULL, 'GAB', 1),
(6, 'Gare Nabeul', 'Nabeul', NULL, 'NBL', 1);

-- --------------------------------------------------------

--
-- Structure de la table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `journey_id` int(11) DEFAULT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) DEFAULT 'CONFIRMED',
  `passenger_name` varchar(100) DEFAULT NULL,
  `passenger_age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tickets`
--

INSERT INTO `tickets` (`id`, `user_id`, `journey_id`, `seat_number`, `booking_date`, `status`, `passenger_name`, `passenger_age`) VALUES
(1, 1, 1, 'A1', '2025-05-28 01:35:46', NULL, 'Hadil Ben Ayed', 24),
(3, 1, 4, 'A1', '2025-05-28 14:59:56', NULL, 'Hadil', 10);

-- --------------------------------------------------------

--
-- Structure de la table `trains`
--

CREATE TABLE `trains` (
  `trainId` int(11) NOT NULL,
  `train_number` varchar(20) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  `total_seats` int(11) NOT NULL,
  `train_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `trains`
--

INSERT INTO `trains` (`trainId`, `train_number`, `train_name`, `total_seats`, `train_type`) VALUES
(1, 'T001', 'Northeast Express', 200, 'Express'),
(2, 'T002', 'City Local', 150, 'Local'),
(3, 'T003', 'Metro Express', 180, 'Express'),
(4, 'T004', 'Regional Service', 120, 'Regional');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `created_at`) VALUES
(1, 'Hadil', 'Hadil@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Hadil', NULL, '2025-05-28 00:04:54'),
(2, 'Trikiz', 'ahmedtriki.triki5@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Ahmed Triki', NULL, '2025-05-28 14:47:27');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `journeys`
--
ALTER TABLE `journeys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `train_id` (`train_id`),
  ADD KEY `departure_station_id` (`departure_station_id`),
  ADD KEY `arrival_station_id` (`arrival_station_id`);

--
-- Index pour la table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `train_id` (`train_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Index pour la table `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Index pour la table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `journey_id` (`journey_id`);

--
-- Index pour la table `trains`
--
ALTER TABLE `trains`
  ADD PRIMARY KEY (`trainId`),
  ADD UNIQUE KEY `train_number` (`train_number`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `journeys`
--
ALTER TABLE `journeys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `stations`
--
ALTER TABLE `stations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `journeys`
--
ALTER TABLE `journeys`
  ADD CONSTRAINT `journeys_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `trains` (`trainId`),
  ADD CONSTRAINT `journeys_ibfk_2` FOREIGN KEY (`departure_station_id`) REFERENCES `stations` (`id`),
  ADD CONSTRAINT `journeys_ibfk_3` FOREIGN KEY (`arrival_station_id`) REFERENCES `stations` (`id`);

--
-- Contraintes pour la table `routes`
--
ALTER TABLE `routes`
  ADD CONSTRAINT `routes_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `trains` (`trainId`),
  ADD CONSTRAINT `routes_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`);

--
-- Contraintes pour la table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`journey_id`) REFERENCES `journeys` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
