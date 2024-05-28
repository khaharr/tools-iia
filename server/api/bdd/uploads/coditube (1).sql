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
  `pseudo` varchar(20) DEFAULT NULL,
  `identifier_channel` varchar(20) DEFAULT NULL,
  `nb_follower` int(11) DEFAULT 0,
  `bio` text DEFAULT NULL,
  `banner` varchar(255) DEFAULT NULL,
  `stream_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `channel_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `comment_short`;
CREATE TABLE `comment_short` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `short_id` int(11) DEFAULT NULL,
  `comment_like` int(11) DEFAULT 0,
  `super_like` tinyint(1) DEFAULT NULL,
  `reply` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `short_id` (`short_id`),
  CONSTRAINT `comment_short_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_short_ibfk_2` FOREIGN KEY (`short_id`) REFERENCES `short` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `comment_video`;
CREATE TABLE `comment_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  `comment_like` int(11) DEFAULT 0,
  `super_like` tinyint(1) DEFAULT NULL,
  `comment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `comment_video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_video_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `dislike_short`;
CREATE TABLE `dislike_short` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_short` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_short` (`id_short`),
  CONSTRAINT `dislike_short_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `dislike_short_ibfk_2` FOREIGN KEY (`id_short`) REFERENCES `short` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `dislike_short_comment`;
CREATE TABLE `dislike_short_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_comment` (`id_comment`),
  CONSTRAINT `dislike_short_comment_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `dislike_short_comment_ibfk_2` FOREIGN KEY (`id_comment`) REFERENCES `comment_short` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `dislike_video`;
CREATE TABLE `dislike_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_video` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_video` (`id_video`),
  CONSTRAINT `dislike_video_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `dislike_video_ibfk_2` FOREIGN KEY (`id_video`) REFERENCES `video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `dislike_video_comment`;
CREATE TABLE `dislike_video_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_comment` (`id_comment`),
  CONSTRAINT `dislike_video_comment_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `dislike_video_comment_ibfk_2` FOREIGN KEY (`id_comment`) REFERENCES `comment_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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


DROP TABLE IF EXISTS `like_short`;
CREATE TABLE `like_short` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_short` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_short` (`id_short`),
  CONSTRAINT `like_short_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `like_short_ibfk_2` FOREIGN KEY (`id_short`) REFERENCES `short` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `like_short_comment`;
CREATE TABLE `like_short_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_comment` (`id_comment`),
  CONSTRAINT `like_short_comment_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `like_short_comment_ibfk_2` FOREIGN KEY (`id_comment`) REFERENCES `comment_short` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `like_video`;
CREATE TABLE `like_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_video` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_video` (`id_video`),
  CONSTRAINT `like_video_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `like_video_ibfk_2` FOREIGN KEY (`id_video`) REFERENCES `video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `like_video_comment`;
CREATE TABLE `like_video_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_comment` (`id_comment`),
  CONSTRAINT `like_video_comment_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `like_video_comment_ibfk_2` FOREIGN KEY (`id_comment`) REFERENCES `comment_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `live`;
CREATE TABLE `live` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `live_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


DROP TABLE IF EXISTS `playlist`;
CREATE TABLE `playlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `is_private` tinyint(4) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `playlist_compo_short`;
CREATE TABLE `playlist_compo_short` (
  `id` int(11) NOT NULL,
  `id_short` int(11) NOT NULL,
  `id_playlist` int(11) NOT NULL,
  KEY `id_short` (`id_short`),
  KEY `id_playlist` (`id_playlist`),
  CONSTRAINT `playlist_compo_short_ibfk_1` FOREIGN KEY (`id_short`) REFERENCES `short` (`id`),
  CONSTRAINT `playlist_compo_short_ibfk_2` FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `playlist_compo_video`;
CREATE TABLE `playlist_compo_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_video` int(11) NOT NULL,
  `id_playlist` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_video` (`id_video`),
  KEY `id_playlist` (`id_playlist`),
  CONSTRAINT `playlist_compo_video_ibfk_1` FOREIGN KEY (`id_video`) REFERENCES `video` (`id`),
  CONSTRAINT `playlist_compo_video_ibfk_2` FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `search`;
CREATE TABLE `search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_search` int(11) DEFAULT NULL,
  `name_search` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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
  `audio_id` int(11) DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `upload_video_url` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `upload_date_time` datetime DEFAULT NULL,
  `number_view` int(11) DEFAULT 0,
  `nb_comment` int(11) DEFAULT 0,
  `video_duration` int(11) DEFAULT NULL,
  `filters` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
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
  `tokenId` varchar(255) DEFAULT NULL,
  `discordAccount` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `user` (`id`, `first_name`, `last_name`, `mail`, `password`, `birthdate`, `gender`, `country`, `PP`, `role`, `username`, `tokenId`, `discordAccount`) VALUES
(1,	'Nolan',	'LAMEILLE',	'nolan.lameille@gmail.com',	'password',	NULL,	NULL,	NULL,	'https://yt3.ggpht.com/cx2n5tMmgWEv1e-68s8XmNAXS-C-NisDqU50b0YMn7H_hRF0s9Nk1hUEhFVJTxeNwhNf7aSf0QQ=s800-c-k-c0x00ffffff-no-rj',	NULL,	'Nonoice',	NULL,	NULL),
(2,	'a',	'v',	'email',	'password',	NULL,	NULL,	NULL,	'https://yt3.googleusercontent.com/3aGVY2iBhkA30oJywVFplMPHw-EpSR7FcldppbxWjLa4-EZakMGBwA8Vqen1FvA9N-3_PRH1TlI=s800-c-k-c0x00ffffff-no-rj',	NULL,	'Zerator',	NULL,	NULL),
(3,	NULL,	NULL,	'dupontstef80@gmail.com',	'$2a$10$.YuJ7MYp/D/1PNBoFwX35.AilTjWdl6fcS0hQ60GUtWLbEZFzoWNO',	NULL,	NULL,	NULL,	NULL,	NULL,	'Akik4',	NULL,	NULL),
(4,	NULL,	NULL,	'brasco@gmail.com',	'$2a$10$/bLAuEiDUpkZbwPK9Ss4peWXkqmS9ZTiGr1j5Etm/UGJGQIdQC/HK',	NULL,	NULL,	NULL,	NULL,	NULL,	'brasco',	NULL,	NULL),
(5,	NULL,	NULL,	'billy@gmail.com',	'$2a$10$aonBWL2O.TKv/QMXF0vVaO6B73sDR2m2QM5YuJ8n4yAS39S82Wszu',	NULL,	NULL,	NULL,	NULL,	NULL,	'Billy',	NULL,	NULL),
(6,	NULL,	NULL,	'younes@gmail.com',	'$2a$10$6YemhEPjlWDvRh4xTukhbOcORWKqhqHCrU/rPgX7Pruhj4.4wE6Vi',	NULL,	NULL,	NULL,	NULL,	NULL,	'younes',	NULL,	NULL),
(7,	NULL,	NULL,	'kristian@gmail.com',	'$2a$10$AtXHOb9eFBVwShfVciaaPOS6/dY5ju/uqrBDH1oRlkMxVnSAof62K',	NULL,	NULL,	NULL,	NULL,	NULL,	'kristian',	NULL,	NULL),
(8,	NULL,	NULL,	'admin@gmail.com',	'$2a$10$hoErzzkW6n1jiV2fgHBLO.SS1sNq//eN3OTZssGOW1m52cu5ks0fG',	NULL,	NULL,	NULL,	NULL,	NULL,	'admin',	NULL,	NULL),
(9,	NULL,	NULL,	'azert@gmail.com',	'$2a$10$JdzP/MvEbmZDFQVJJhPITu2It5cFWkh7/kdYW0aVuK7v1jqXsXT3i',	NULL,	NULL,	NULL,	NULL,	NULL,	'azertyuiop',	NULL,	NULL);

DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
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
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `video` (`id`, `channel_id`, `upload_video_url`, `title`, `thumbnail`, `description`, `upload_date_time`, `number_view`, `nb_comment`, `nb_like`, `nb_dislike`, `video_duration`, `category`) VALUES
(6,	1,	'/uploads/videos/energy_field_-_74933 (1080p).mp4',	'Test',	'/uploads/thumbnails/favicon.png',	'Test',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	''),
(8,	1,	'/uploads/videos/energy.mp4',	'Energy',	'/uploads/thumbnails/favicon.png',	'Energy',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	''),
(18,	1,	'/uploads/videos/Ryomen-Sukuna-jujutsu-kaisen-4k-live-wallpaper (PosInTech).mp4',	'khalid',	'/uploads/thumbnails/meme.jpg',	'khalid',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'News'),
(19,	14,	'/uploads/videos/1711697148888_Ryomen-Sukuna-jujutsu-kaisen-4k-live-wallpaper (PosInTech).mp4',	'khalid',	'/uploads/thumbnails/1711697148888_avatar.jpg',	'lache pas l\'ecole ya zebi',	'2024-03-29 07:37:12',	NULL,	NULL,	NULL,	NULL,	NULL,	'News'),
(20,	14,	'/uploads/videos/1711702166575_labday-coding-factory-esiee-it-projet.mp4',	'braskoladem',	'/uploads/thumbnails/1711702166575_133521207244584144.jpg',	'kd,ez,d',	'2024-03-29 09:13:22',	NULL,	NULL,	NULL,	NULL,	NULL,	'VideoGames'),
(21,	14,	'/uploads/videos/1711702166575_labday-coding-factory-esiee-it-projet.mp4',	'braskoladem',	'/uploads/thumbnails/1711702166575_133521207244584144.jpg',	'kd,ez,d',	'2024-03-29 09:13:28',	NULL,	NULL,	NULL,	NULL,	NULL,	'VideoGames');

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
  `watch_date` datetime DEFAULT NULL,
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
  `watch_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `watched_video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `watched_video_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `watched_video` (`id`, `video_id`, `user_id`, `watch_date`) VALUES
(1,	NULL,	1,	'2024-03-28 08:42:28'),
(2,	NULL,	1,	'2024-03-28 08:42:32'),
(3,	NULL,	1,	'2024-03-28 08:43:10'),
(4,	NULL,	1,	'2024-03-28 09:25:52'),
(5,	18,	8,	'2024-03-29 09:18:11'),
(6,	21,	8,	'2024-03-29 09:18:09');

-- 2024-03-29 09:27:56
