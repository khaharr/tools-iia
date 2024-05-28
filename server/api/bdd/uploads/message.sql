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
  `nb_follower` int(11) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `banner` longtext DEFAULT NULL,
  `stream_key` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `channel_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `channel` (`id`, `user_id`, `pseudo`, `identifier_channel`, `nb_follower`, `bio`, `banner`, `stream_key`, `profile_picture`) VALUES
(1,	1,	'Nonoice',	'@Nonoice',	0,	'bio c\'est bon',	NULL,	NULL,	NULL),
(2,	2,	'Zerator',	'@Zerator',	2,	'bio c\'est bon',	NULL,	'www',	NULL),
(3,	3,	'Akik4',	NULL,	NULL,	'sdfsdf',	NULL,	'$2a$10$ALBNmxHJIB259epRO9mQIOxpYN5A1DQHY8QJhhGPHt6w18BPRYQcm',	NULL),
(5,	5,	'Billy',	'@biiiii',	0,	'lyyyyyy',	NULL,	NULL,	NULL),
(6,	6,	'younes',	'@younes',	0,	'lol',	NULL,	NULL,	NULL),
(12,	7,	'krist',	'@krist',	0,	'',	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `comment_short`;
CREATE TABLE `comment_short` (
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
  CONSTRAINT `comment_short_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_short_ibfk_2` FOREIGN KEY (`short_id`) REFERENCES `short` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `comment_video`;
CREATE TABLE `comment_video` (
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
  CONSTRAINT `comment_video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_video_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `comment_video` (`id`, `user_id`, `text`, `video_id`, `comment_like`, `super_like`, `comment_date`) VALUES
(1,	1,	'Terrible la vidéo chef',	1,	NULL,	NULL,	NULL),
(2,	1,	'WAAAAAAAAAAA MASTERCLASSS LA TEAM',	1,	NULL,	NULL,	NULL);

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

INSERT INTO `follow` (`id`, `channel_id`, `follower_id`) VALUES
(1,	2,	1),
(8,	1,	1);

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

INSERT INTO `search` (`id`, `number_search`, `name_search`) VALUES
(1,	2,	'On');

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
  `audio_id` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `filters` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  KEY `audio_id` (`audio_id`),
  CONSTRAINT `short_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `short_ibfk_2` FOREIGN KEY (`audio_id`) REFERENCES `audio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `short` (`id`, `channel_id`, `upload_video_url`, `title`, `thumbnail`, `description`, `upload_date_time`, `number_view`, `nb_comment`, `nb_like`, `nb_dislike`, `video_duration`, `audio_id`, `category`, `filters`) VALUES
(1,	1,	'/uploads/videos/energy.mp4',	'test short',	'/uploads/thumbnails/favicon.png',	'test short',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'News',	''),
(2,	1,	'/uploads/videos/1711580556710_energy.mp4',	'encore',	'/uploads/thumbnails/1711580556710_favicon.ico',	'encore',	'2024-03-27 23:03:01',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Podcasts',	'invert(1) blur(1vh) brightness(0.5) saturate(50%) opacity(50%) ');

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
(7,	NULL,	NULL,	'kristian@gmail.com',	'$2a$10$AtXHOb9eFBVwShfVciaaPOS6/dY5ju/uqrBDH1oRlkMxVnSAof62K',	NULL,	NULL,	NULL,	NULL,	NULL,	'kristian',	NULL,	NULL);

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
(1,	1,	'https://www.youtube.com/watch?v=PTmjVaCCax0',	'BLIND TEST Mario Kart 8 Deluxe (Avec 95 musiques de courses)',	'https://img.youtube.com/vi/PTmjVaCCax0/maxresdefault.jpg',	NULL,	'2024-03-14 13:48:16',	95,	NULL,	NULL,	NULL,	801,	NULL),
(2,	1,	'https://www.youtube.com/watch?v=gT8Wj6jaLw8',	'LE REPRODUCTEUR 5 : la compétition de construction Minecraft ultilme',	'https://img.youtube.com/vi/gT8Wj6jaLw8/maxresdefault.jpg',	NULL,	'2024-03-14 13:49:22',	30,	NULL,	NULL,	NULL,	254,	NULL),
(3,	1,	'https://www.youtube.com/watch?v=KQkmhqCY4eQ',	'On se les fait ces niveaux ? (Super Mario Maker 2)',	'https://img.youtube.com/vi/KQkmhqCY4eQ/maxresdefault.jpg',	NULL,	'2024-03-14 13:50:37',	9840,	NULL,	NULL,	NULL,	48,	NULL),
(4,	1,	'https://www.youtube.com/watch?v=KQkmhqCY4eQ',	'On se les fait ces niveaux ? (Super Mario Maker 2)',	'https://img.youtube.com/vi/KQkmhqCY4eQ/maxresdefault.jpg',	NULL,	'2024-03-14 15:22:44',	9824,	NULL,	NULL,	NULL,	8535200,	NULL),
(5,	2,	'https://www.youtube.com/watch?v=KQkmhqCY4eQ',	'VOUS VOULEZ UN PEU DE ZLAN ? - Best of ZeratoR #386',	'https://img.youtube.com/vi/jPBjJXEBcQc/maxresdefault.jpg',	'ABONNE TOI, par pitié : https://www.youtube.com/user/ZeratoRSC2/?sub_confirmation=1\r\n\r\nRetrouvez-moi en live sur : https://www.twitch.tv/zerator\r\n\r\nToutes les informations sont sur http://www.ZeratoR.com/\r\nLa NOUVELLE boutique : https://casualmachine.com/\r\n\r\nDevenez un vrai streamer comme moi avec Elgato : https://elgato.sjv.io/ZeratoR (5% de réduction avec ce lien)\r\n\r\nSuivez-moi sur les réseaux :\r\nFacebook : https://www.facebook.com/ZeratoR\r\nTwitter : https://twitter.com/ZeratoR\r\nInstagram : https://www.instagram.com/zerator\r\nDiscord : https://discord.gg/zerator\r\nTiktok : https://www.tiktok.com/@ZeratoR\r\n\r\nRetrouvez toute l\'actualité et l\'esport sur Mandatory.GG : https://www.mandatory.gg/\r\n\r\nSuivez Mandatory.GG sur les réseaux pour ne rien manquer :\r\n→ https://twitter.com/MandatoryGG\r\n→ https://www.instagram.com/mandatory.gg/\r\n→ https://www.tiktok.com/@mandatory.gg\r\n→ https://discord.gg/3uHncKP\r\n→ https://www.twitch.tv/mandatory\r\n→ https://www.facebook.com/MandatoryGG/\r\n\r\n00:00 Intro\r\n00:16 Vous connaissez la ZLAN ?\r\n00:43 ON EST CHAMPIONS !\r\n01:08 Soirée du lundi - Pummel Party\r\n03:45 Soirée du lundi - Skribbl.io\r\n04:45 Soirée du lundi - Codenames\r\n06:18 Popcorn\r\n10:29 Je suis Lisan al Gaib\r\n11:49 Valorant\r\n13:24 Chasing the Unseen\r\n14:46 United Penguin Kingdom',	'2024-03-19 09:20:35',	8851,	NULL,	NULL,	NULL,	5000,	NULL),
(6,	1,	'/uploads/videos/energy_field_-_74933 (1080p).mp4',	'Test',	'/uploads/thumbnails/favicon.png',	'Test',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	''),
(8,	1,	'/uploads/videos/energy.mp4',	'Energy',	'/uploads/thumbnails/favicon.png',	'Energy',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	''),
(11,	1,	'/uploads/videos/Levi vs Beast Titan - Attack on Titan Season 3 with Attack on Titan OST.mp4',	'Levi',	'/uploads/thumbnails/pp-eren.jpg',	'Levi casse ...',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Sports'),
(12,	1,	'/uploads/videos/1711579917492_Attack on Titan Season 4 Episode 14 - Levi vs Zeke Round 2 (Full Fight) [HD].mp4',	' Levi VS Zeke #2',	'/uploads/thumbnails/1711579917492_pp-eren.jpg',	'Round 2 du duel opposant Levi Ackerman et Zeke Jäger',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'News'),
(13,	1,	'/uploads/videos/1711579917492_Levi vs Beast Titan - Attack on Titan Season 3 with Attack on Titan OST.mp4',	'Petit Short',	'/uploads/thumbnails/1711579917492_favicon-removebg-preview.png',	'Wsh les short',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Music'),
(14,	1,	'/uploads/videos/1711580216954_energy.mp4',	'TIMESTAMP',	'/uploads/thumbnails/1711580216954_favicon-removebg-preview.png',	'PASSER LE SITE en ANGLAIS',	'2024-03-27 22:58:10',	NULL,	NULL,	NULL,	NULL,	NULL,	'Culture'),
(15,	1,	'/uploads/videos/1711580216954_Levi vs Beast Titan - Attack on Titan Season 3 with Attack on Titan OST.mp4',	'Short 2',	'/uploads/thumbnails/1711580216954_favicon.ico',	'test 2',	'2024-03-27 22:59:03',	NULL,	NULL,	NULL,	NULL,	NULL,	'Music'),
(16,	1,	'/uploads/videos/1711580216954_energy.mp4',	'Short 3',	'/uploads/thumbnails/1711580216954_favicon-removebg-preview(1).png',	'Short 3',	'2024-03-27 23:00:10',	NULL,	NULL,	NULL,	NULL,	NULL,	'Culture'),
(17,	1,	'/uploads/videos/1711580444969_energy.mp4',	'Wsh',	'/uploads/thumbnails/1711580444969_favicon.ico',	'wsh',	'2024-03-27 23:01:46',	NULL,	NULL,	NULL,	NULL,	NULL,	'News');

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


-- 2024-03-28 08:25:41
