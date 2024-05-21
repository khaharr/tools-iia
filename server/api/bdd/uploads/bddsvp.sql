-- Adminer 4.8.1 MySQL 11.3.2-MariaDB-1:11.3.2+maria~ubu2204 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `audio`;
CREATE TABLE `audio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `channel`;
CREATE TABLE `channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `pseudo` varchar(50) DEFAULT NULL,
  `identifier_channel` varchar(20) NOT NULL,
  `nb_follower` int(11) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `banner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `channel_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `channel` (`id`, `user_id`, `pseudo`, `identifier_channel`, `nb_follower`, `bio`, `banner`) VALUES
(1,	1,	'BrascoYT',	'',	18000001,	'Salut mes mignons, nouvelles vidéos gameplay \"Barbie Aventure Équestre\" tous les lundi, mercredi et vendredi.',	NULL),
(2,	1,	NULL,	'',	NULL,	NULL,	NULL),
(3,	1,	'Khalid78Dem',	'',	NULL,	NULL,	NULL),
(4,	1,	'Code',	'code785',	NULL,	NULL,	NULL),
(5,	1,	'Eren',	'@eren78',	0,	'Je suis Eren abonnez-vous ou je lance la grande terrassement, TATAKAE !!!',	NULL),
(9,	1,	'Mikasa',	'@mikasa-78',	0,	'Je cherche Eren, il est où ?',	NULL),
(10,	1,	'Azerty',	'@azerty',	0,	'J\'aime les claviers',	NULL),
(11,	1,	'Qwerty',	'@qwerty',	0,	'I like keybord',	NULL),
(12,	1,	'Test',	'@test',	0,	'ceci est un vulgaire test',	NULL),
(13,	1,	'Test2',	'@test2',	0,	'Ceci est un pathétique test',	NULL),
(14,	1,	'Younes',	'@younes78',	0,	'',	NULL),
(15,	1,	'',	'@',	0,	'',	NULL),
(16,	1,	'',	'@',	0,	'',	NULL),
(17,	1,	'',	'@',	0,	'',	NULL),
(18,	1,	'Younes',	'@youyou',	0,	'c\'est moi wsh',	NULL),
(19,	1,	'PopUp',	'@popup',	0,	'Salut c\'est moi Tchoupi, je marche vers l\'école ...',	NULL);

DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `follower_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `follower_id` (`follower_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `search`;
CREATE TABLE `search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_search` int(11) DEFAULT NULL,
  `name_search` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `search` (`id`, `number_search`, `name_search`) VALUES
(1,	1,	':submit'),
(2,	1,	'gtg'),
(3,	1,	'recherche');

DROP TABLE IF EXISTS `search_history`;
CREATE TABLE `search_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `research_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `search_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `search_id` (`search_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `search_history_ibfk_1` FOREIGN KEY (`search_id`) REFERENCES `search` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `search_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `short`;
CREATE TABLE `short` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `upload_video_url` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `upload_date_time` datetime DEFAULT NULL,
  `number_view` int(11) DEFAULT NULL,
  `nb_comment` int(11) DEFAULT NULL,
  `nb_like` int(11) DEFAULT NULL,
  `nb_dislike` int(11) DEFAULT NULL,
  `video_duration` int(11) DEFAULT NULL,
  `is_short` tinyint(1) DEFAULT NULL,
  `audio_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  KEY `audio_id` (`audio_id`),
  CONSTRAINT `short_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `short_ibfk_2` FOREIGN KEY (`audio_id`) REFERENCES `audio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `short_comment`;
CREATE TABLE `short_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `short_id` int(11) DEFAULT NULL,
  `comment_like` int(11) DEFAULT NULL,
  `super_like` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `short_id` (`short_id`),
  CONSTRAINT `short_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `short_comment_ibfk_2` FOREIGN KEY (`short_id`) REFERENCES `short` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tag_short_link`;
CREATE TABLE `tag_short_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `short_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`),
  KEY `short_id` (`short_id`),
  CONSTRAINT `tag_short_link_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tag_short_link_ibfk_2` FOREIGN KEY (`short_id`) REFERENCES `short` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tag_video_link`;
CREATE TABLE `tag_video_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `tag_video_link_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tag_video_link_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `PP` varchar(255) DEFAULT NULL,
  `role` smallint(6) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `user` (`id`, `first_name`, `last_name`, `mail`, `password`, `birthdate`, `gender`, `country`, `PP`, `role`, `username`) VALUES
(1,	NULL,	NULL,	'younes@gmail.com',	'$2a$10$9lhAQVCa1FcQGfkJzWVS6ujOAcS4iU1QNf8UkxwK1Ru4kjpNLbLVe',	NULL,	NULL,	NULL,	NULL,	NULL,	'younes');

DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `upload_video_url` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `upload_date_time` datetime DEFAULT NULL,
  `number_view` int(11) DEFAULT NULL,
  `nb_comment` int(11) DEFAULT NULL,
  `nb_like` int(11) DEFAULT NULL,
  `video_duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `video` (`id`, `channel_id`, `upload_video_url`, `title`, `thumbnail`, `description`, `category`, `upload_date_time`, `number_view`, `nb_comment`, `nb_like`, `video_duration`) VALUES
(1,	1,	NULL,	'Le Grand Terrassement',	'https://niindo64.files.wordpress.com/2022/05/aot-s4-p2-11.jpg',	'GT en live',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	1,	NULL,	'J\'arrête YouTube, s\'en est trop !',	'https://pbs.twimg.com/ext_tw_video_thumb/1310186634772701187/pu/img/Rknlk0FikhQeeUR2.jpg:large',	'Le football il a changé',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	1,	NULL,	'Let\'s Play #1 - Barbie au bal de fin d\'année',	'https://thumb.canalplus.pro/http/unsafe/1440x810/filters:quality(80)/img-hapi.canalplus.pro:80/ServiceImage/ImageID/103003516',	'Coucou mes choupinou, voici le début d\'une série de let\'s play sur mon jeu of all time WAAAAAAOU C\'EST PARTIE',	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	1,	NULL,	'Let\'s play #2 - Barbie cherche son cavalier',	'https://m.media-amazon.com/images/S/pv-target-images/66e59e023c8018f8927483f6cc417c4f40c09579e56e67ee1e49266dd6bc6c3b._SX1080_FMjpg_.jpg',	'YOUPPIIIIIIII on est repartie mes p\'tites fraises. Barbie va partir à la conquête de son cavalier pour le bal. Qui sera l\'heureux élu ? Brondon ? Ken ? Mustapha ? Lee ? Olivier ? Fernando ? ...',	'Video Games',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `video_comment`;
CREATE TABLE `video_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  `comment_like` int(11) DEFAULT NULL,
  `super_like` tinyint(1) DEFAULT NULL,
  `comment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `video_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `video_comment_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `watched_short`;
CREATE TABLE `watched_short` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `short_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `watch_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `short_id` (`short_id`),
  CONSTRAINT `watched_short_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `watched_short_ibfk_2` FOREIGN KEY (`short_id`) REFERENCES `short` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `watched_video`;
CREATE TABLE `watched_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `watch_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `watched_video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `watched_video_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- 2024-03-21 09:53:40