create database streamingmusic;
use streamingmusic;

create table users(
	id_users int primary key not null auto_increment,
    email varchar(150) unique not null,
    senha varchar(150) not null,
    name_users varchar(100) not null,
    date_creation date
);

create table artist(
	id_artist int primary key not null auto_increment,
    name_artist varchar(100) not null,
    memoir_artist text,
    date_artist date,
    country varchar(50)
);

create table albums(
	id_albums int primary key not null auto_increment,
    id_artist int not null,
    title_albums varchar(200) not null,
    date_albums year(4),
    
    foreign key (id_artist) references artist(id_artist)
);

create table tracks(
	id_tracks int primary key not null auto_increment,
    id_albums int not null,
    title_tracks varchar(200) not null,
    duration_seconds int not null,
    date_tracks date,
    
    foreign key (id_albums) references albums(id_albums)
);

create table genres(
    id_genre int primary key not null auto_increment,
    name_genre varchar(50) not null unique,
    description_genre text
);

create table playlists(
	id_playlists int primary key not null auto_increment,
    id_users int not null,
    title_playlists varchar(200) not null,
    description_playlists text,
    communal boolean not null,
    date_playlists date,
    
    foreign key (id_users) references users(id_users)
);

create table playlist_tracks(
	id_playlist_tracks int primary key not null auto_increment,
	id_playlists int not null,
    id_tracks int not null,
    track_order int not null,
    date_added date,
    
    foreign key (id_playlists) references playlists(id_playlists),
    foreign key (id_tracks) references tracks(id_tracks),
    
    unique(id_playlists, track_order)
);

create table favorites(
	id_favorites int primary key not null  auto_increment,
	id_users int not null,
    id_tracks int not null,
    date_like datetime,
    
    foreign key (id_users) references users(id_users),
    foreign key (id_tracks) references tracks(id_tracks),
    
    unique(id_users, id_tracks)
);

create table play_historys(
	id_play_historys int primary key not null auto_increment,
    id_users int not null,
    id_tracks int not null,
    timestamp_reproduction datetime not null,
    seconds_hear int,
    
    foreign key (id_users) references users(id_users),
    foreign key (id_tracks) references tracks(id_tracks)
);

create table ratings(
	id_ratings int primary key not null auto_increment,
	id_users int not null,
    id_tracks int not null,
    comment_ratings text,
    star_ratings tinyint not null,
    date_ratings date,
    
    foreign key (id_users) references users(id_users),
    foreign key (id_tracks) references tracks(id_tracks),
    
    unique(id_users, id_tracks),
    check(star_ratings between 1 and 5)
);

create table followers(
	id_followers int primary key not null auto_increment,
	id_users int not null,
    id_artist int not null,
    date_followering date,
    
    foreign key (id_users) references users(id_users),
    foreign key (id_artist) references artist(id_artist),
    
    unique(id_users, id_artist)
);

create table subscriptions(
	id_subscriptions int primary key not null auto_increment,
    id_users int not null,
    plan_type varchar(20) not null,
    date_start date not null,
    date_end date,
    value_subscriptions decimal(10,2),
    status_subscriptions varchar (10),
    
    foreign key (id_users) references users(id_users),
    
    check(plan_type in ('FREE', 'PREMIUM', 'FAMILY')),
    check(status_subscriptions in ('ATIVO', 'CANCELADO', 'EXPIRADO')),
    check(date_end is null or date_end >= date_start)
);

create table track_genres(
	id_track_genres int primary key not null auto_increment,
    id_tracks int not null,
    id_genre int not null,
    
    foreign key (id_tracks) references tracks(id_tracks),
    foreign key (id_genre) references genres(id_genre),
    
    unique(id_tracks, id_genre)
);

insert into users (email, senha, name_users, date_creation) values
('joao.silva@email.com', 'senha123', 'João Silva', '2023-01-15'),
('maria.oliveira@email.com', 'senha456', 'Maria Oliveira', '2023-02-20'),
('carlos.santos@email.com', 'senha789', 'Carlos Santos', '2023-03-10'),
('ana.costa@email.com', 'senhaABC', 'Ana Costa', '2023-04-05'),
('pedro.martins@email.com', 'senhaXYZ', 'Pedro Martins', '2023-05-12'),
('juliana.ferreira@email.com', 'senhaQWE', 'Juliana Ferreira', '2023-06-08'),
('lucas.gomes@email.com', 'senhaRTY', 'Lucas Gomes', '2023-07-22'),
('beatriz.rocha@email.com', 'senhaUIO', 'Beatriz Rocha', '2023-08-30'),
('rafael.souza@email.com', 'senhaASD', 'Rafael Souza', '2023-09-14'),
('camila.santos@email.com', 'senhaFGH', 'Camila Santos', '2023-10-19'),
('diego.oliveira@email.com', 'senhaJKL', 'Diego Oliveira', '2023-11-25'),
('isabela.costa@email.com', 'senhaZXC', 'Isabela Costa', '2023-12-03'),
('mateus.silva@email.com', 'senhaVBN', 'Mateus Silva', '2024-01-11'),
('fernanda.pereira@email.com', 'senhaQAZ', 'Fernanda Pereira', '2024-02-07'),
('gustavo.alves@email.com', 'senhaWSX', 'Gustavo Alves', '2024-03-16'),
('laura.martins@email.com', 'senhaEDC', 'Laura Martins', '2024-04-22'),
('bruno.costa@email.com', 'senhaRFV', 'Bruno Costa', '2024-05-09'),
('sophia.santos@email.com', 'senhaTGH', 'Sophia Santos', '2024-06-13'),
('andre.gomes@email.com', 'senhaYUI', 'André Gomes', '2024-07-18'),
('victoria.rocha@email.com', 'senhaIOP', 'Victoria Rocha', '2024-08-25');

insert into artist (name_artist, memoir_artist, date_artist, country) values
('The Weeknd', 'Artista canadense de R&B e pop moderno', '1990-02-16', 'Canadá'),
('Taylor Swift', 'Cantora de pop e country americana', '1989-12-13', 'EUA'),
('Bad Bunny', 'Artista porto-riquenho de reggaeton e trap latino', '1994-03-10', 'Porto Rico'),
('Ariana Grande', 'Cantora americana de pop e R&B', '1993-10-26', 'EUA'),
('BTS', 'Grupo sul-coreano de K-pop', '1992-01-01', 'Coreia do Sul');

insert into genres (name_genre, description_genre) values
('Pop', 'Música popular moderna'),
('Rock', 'Gênero de rock clássico'),
('Hip-Hop', 'Hip-hop e rap'),
('R&B', 'Rhythm and Blues'),
('Country', 'Música country americana'),
('Jazz', 'Música jazz clássica'),
('Eletrônico', 'Música eletrônica e EDM'),
('Reggaeton', 'Reggaeton latino'),
('K-Pop', 'Pop coreano'),
('Indie', 'Música independente'),
('Sertanejo', 'Sertanejo brasileiro'),
('Samba', 'Samba e ritmo brasileiro'),
('Trap', 'Trap latino'),
('Soul', 'Soul music'),
('Funk', 'Funk e disco');

insert into albums (id_artist, title_albums, date_albums) values
(1, 'After Hours', 2020),
(2, 'Lover', 2019),
(3, 'Un x100to', 2016);

insert into tracks (id_albums, title_tracks, duration_seconds, date_tracks) values
-- Álbum After Hours (The Weeknd)
(1, 'Blinding Lights', 200, '2020-03-29'),
(1, 'The Hardest Part', 234, '2020-03-29'),
(1, 'Scared to Live', 204, '2020-03-29'),
(1, 'Hardest to Love', 216, '2020-03-29'),
(1, 'Faith', 272, '2020-03-29'),
(1, 'Heartless', 209, '2020-03-29'),
(1, 'Dangerous', 283, '2020-03-29'),
(1, 'In Your Eyes', 285, '2020-03-29'),

-- Álbum Lover (Taylor Swift)
(2, 'ME', 200, '2019-08-23'),
(2, 'The Archer', 272, '2019-08-23'),
(2, 'The Man', 249, '2019-08-23'),
(2, 'Lover', 363, '2019-08-23'),
(2, 'Cornelia Street', 220, '2019-08-23'),
(2, 'Daylight', 384, '2019-08-23'),
(2, 'Afterglow', 349, '2019-08-23'),

-- Álbum Un x100to (Bad Bunny)
(3, 'Soy Peor', 237, '2016-02-29'),
(3, 'Tití Me Preguntó', 253, '2016-02-29'),
(3, 'Krippy Kush', 269, '2016-02-29'),
(3, 'Sensualidad', 291, '2016-02-29'),
(3, 'En La Nada', 284, '2016-02-29'),
(3, 'Estrellas', 249, '2016-02-29'),
(3, 'Contigo', 334, '2016-02-29'),
(3, 'Difícil', 303, '2016-02-29');

insert into track_genres (id_tracks, id_genre) values
-- The Weeknd tracks - Pop, R&B, Eletrônico
(1, 1), (1, 4), (1, 7),
(2, 1), (2, 4),
(3, 1), (3, 4), (3, 7),
(4, 1), (4, 4),
(5, 4), (5, 14),
(6, 1), (6, 7),
(7, 1), (7, 4),
(8, 1), (8, 4),

-- Taylor Swift tracks - Pop, Country
(9, 1), (9, 5),
(10, 1), (10, 14),
(11, 1), (11, 5),
(12, 1), (12, 14),
(13, 1), (13, 5),
(14, 1), (14, 5),
(15, 1), (15, 5),

-- Bad Bunny tracks - Reggaeton, Trap, Pop
(16, 8), (16, 13),
(17, 8), (17, 13),
(18, 8), (18, 13),
(19, 8), (19, 4),
(20, 8), (20, 13),
(21, 8), (21, 1),
(22, 8), (22, 13),
(23, 8), (23, 13);

insert into playlists (id_users, title_playlists, description_playlists, communal, date_playlists) values
(1, 'Meu Top 2024', 'Minhas músicas favoritas do ano', FALSE, '2024-01-10'),
(2, 'Festa e Dança', 'Músicas para dançar e se divertir', TRUE, '2024-02-15'),
(5, 'Relaxamento', 'Músicas calmas para relaxar', FALSE, '2024-03-20');

insert into playlist_tracks (id_playlists, id_tracks, track_order, date_added) values
-- Playlist 1: Meu Top 2024
(1, 1, 1, '2024-01-10'),
(1, 9, 2, '2024-01-10'),
(1, 16, 3, '2024-01-15'),
(1, 2, 4, '2024-01-20'),
(1, 11, 5, '2024-01-25'),
(1, 18, 6, '2024-02-01'),

-- Playlist 2: Festa e Dança
(2, 6, 1, '2024-02-15'),
(2, 22, 2, '2024-02-15'),
(2, 15, 3, '2024-02-20'),
(2, 20, 4, '2024-02-25'),
(2, 8, 5, '2024-03-01'),
(2, 17, 6, '2024-03-05'),
(2, 10, 7, '2024-03-10'),

-- Playlist 3: Relaxamento
(3, 12, 1, '2024-03-20'),
(3, 14, 2, '2024-03-20'),
(3, 5, 3, '2024-03-25'),
(3, 13, 4, '2024-04-01');

insert into favorites (id_users, id_tracks, date_like) values
(1, 1, '2024-01-15 10:30:00'),
(2, 9, '2024-01-20 14:45:00'),
(3, 16, '2024-02-10 09:15:00'),
(4, 6, '2024-02-15 18:20:00'),
(5, 12, '2024-03-01 11:00:00'),
(6, 8, '2024-03-10 16:30:00'),
(7, 15, '2024-03-15 13:45:00'),
(8, 2, '2024-03-20 19:20:00'),
(9, 22, '2024-04-01 10:10:00'),
(10, 5, '2024-04-05 15:50:00');

insert into play_historys (id_users, id_tracks, timestamp_reproduction, seconds_hear) values
(1, 1, '2024-04-10 08:30:00', 200),
(2, 9, '2024-04-10 09:15:00', 180),
(3, 16, '2024-04-10 10:45:00', 237),
(1, 6, '2024-04-10 14:20:00', 209),
(4, 12, '2024-04-10 15:30:00', 300),
(5, 8, '2024-04-10 16:15:00', 285),
(2, 15, '2024-04-10 17:45:00', 300),
(6, 2, '2024-04-11 08:30:00', 234),
(7, 22, '2024-04-11 10:00:00', 250),
(8, 5, '2024-04-11 12:30:00', 272),
(1, 18, '2024-04-11 14:45:00', 200),
(3, 11, '2024-04-11 16:20:00', 249),
(4, 20, '2024-04-11 18:10:00', 280),
(5, 14, '2024-04-12 09:30:00', 350),
(9, 3, '2024-04-12 11:15:00', 204);

insert into ratings (id_users, id_tracks, comment_ratings, star_ratings, date_ratings) values
(1, 1, 'Excelente música, muito boa!', 5, '2024-04-10'),
(2, 9, 'Adorei, muito melódica', 5, '2024-04-10'),
(3, 16, 'Legal, mas poderia ser melhor', 3, '2024-04-10'),
(4, 6, 'Que música animada!', 5, '2024-04-11'),
(5, 12, 'Romântica demais, não é meu estilo', 2, '2024-04-11'),
(6, 8, 'Perfeita para a ocasião', 4, '2024-04-11'),
(7, 15, 'Muito bom, recomendo', 5, '2024-04-12'),
(8, 2, 'Interessante, gostei', 4, '2024-04-12'),
(9, 22, 'Top demais!', 5, '2024-04-12'),
(10, 5, 'Boa para relaxar', 4, '2024-04-13'),
(1, 8, 'Uma das melhores do artista', 5, '2024-04-13'),
(2, 18, 'Ritmo contagiante', 4, '2024-04-13');

insert into followers (id_users, id_artist, date_followering) values
(1, 1, '2024-01-15'),
(2, 2, '2024-01-20'),
(3, 3, '2024-02-10'),
(4, 1, '2024-02-15'),
(5, 2, '2024-03-01'),
(6, 3, '2024-03-10'),
(7, 4, '2024-03-15'),
(8, 5, '2024-03-20');

insert into subscriptions (id_users, plan_type, date_start, date_end, value_subscriptions, status_subscriptions) values
(1, 'PREMIUM', '2024-01-01', '2025-01-01', 14.99, 'ATIVO'),
(2, 'FREE', '2024-02-01', null, 0.00, 'ATIVO'),
(3, 'PREMIUM', '2024-01-15', '2025-01-15', 14.99, 'ATIVO'),
(4, 'FAMILY', '2024-03-01', '2025-03-01', 24.99, 'ATIVO'),
(5, 'PREMIUM', '2023-12-01', '2024-12-01', 14.99, 'CANCELADO'),
(6, 'FREE', '2024-02-15', null, 0.00, 'ATIVO'),
(7, 'PREMIUM', '2024-03-15', '2025-03-15', 14.99, 'ATIVO'),
(8, 'FAMILY', '2024-01-10', '2025-01-10', 24.99, 'ATIVO'),
(9, 'FREE', '2024-04-01', null, 0.00, 'ATIVO'),
(10, 'PREMIUM', '2024-02-20', '2025-02-20', 14.99, 'ATIVO'),
(11, 'PREMIUM', '2024-01-25', '2025-01-25', 14.99, 'ATIVO'),
(12, 'FREE', '2024-03-05', null, 0.00, 'ATIVO'),
(13, 'FAMILY', '2024-02-10', '2025-02-10', 24.99, 'ATIVO'),
(14, 'PREMIUM', '2023-11-01', '2023-12-01', 14.99, 'EXPIRADO'),
(15, 'FREE', '2024-04-01', null, 0.00, 'ATIVO'),
(16, 'PREMIUM', '2024-03-20', '2025-03-20', 14.99, 'ATIVO'),
(17, 'PREMIUM', '2024-02-01', '2025-02-01', 14.99, 'ATIVO'),
(18, 'FAMILY', '2024-01-20', '2025-01-20', 24.99, 'ATIVO'),
(19, 'FREE', '2024-03-10', null, 0.00, 'ATIVO'),
(20, 'PREMIUM', '2024-04-01', '2025-04-01', 14.99, 'ATIVO');

