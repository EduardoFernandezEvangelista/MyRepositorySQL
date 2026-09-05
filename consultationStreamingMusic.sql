use streamingmusic;

-- listagens básicas
select * from users;

select * from artist;

select * from tracks;

select * from genres;

-- listagens basicas de informações especificas
select id_users, name_users, email, date_creation 
from users;

select id_artist, name_artist, country, date_artist 
from artist;

select id_tracks, title_tracks, duration_seconds, date_tracks 
from tracks;

select id_genre, name_genre 
from genres;

-- filtros simples
select name_users, email, date_creation 
from users 
where date_creation >= '2024-01-01';

select id_subscriptions, id_users, plan_type, date_start, status_subscriptions 
from subscriptions 
where status_subscriptions = 'ATIVO';

select title_tracks, duration_seconds, round(duration_seconds/60.0, 2) as duracao_minutos 
from tracks 
where duration_seconds > 300;

select id_users, id_tracks, star_ratings, comment_ratings, date_ratings 
from ratings 
where star_ratings = 5;

-- relacionamentos (joins)
select 
    t.title_tracks,
    a.title_albums,
    ar.name_artist,
    t.duration_seconds
from tracks t
join albums a on t.id_albums = a.id_albums
join artist ar on a.id_artist = ar.id_artist
order by ar.name_artist;

select 
    p.id_playlists,
    p.title_playlists,
    u.name_users,
    count(pt.id_tracks) as total_musicas
from playlists p
join users u on p.id_users = u.id_users
left join playlist_tracks pt on p.id_playlists = pt.id_playlists
group by p.id_playlists, p.title_playlists, u.name_users;

select 
    ph.timestamp_reproduction,
    u.name_users,
    t.title_tracks,
    round(ph.seconds_hear/60.0, 2) as minutos_ouvidos
from play_historys ph
join users u on ph.id_users = u.id_users
join tracks t on ph.id_tracks = t.id_tracks
order by ph.timestamp_reproduction desc;

select 
    u.name_users,
    t.title_tracks,
    ar.name_artist,
    f.date_like
from favorites f
join users u on f.id_users = u.id_users
join tracks t on f.id_tracks = t.id_tracks
join albums al on t.id_albums = al.id_albums
join artist ar on al.id_artist = ar.id_artist
order by f.date_like desc;

select 
    u.name_users,
    t.title_tracks,
    ar.name_artist,
    r.star_ratings,
    r.comment_ratings,
    r.date_ratings
from ratings r
join users u on r.id_users = u.id_users
join tracks t on r.id_tracks = t.id_tracks
join albums al on t.id_albums = al.id_albums
join artist ar on al.id_artist = ar.id_artist
order by r.star_ratings desc, r.date_ratings desc;

-- agregações (totais, médias, máximos)
select count(*) as total_usuarios 
from users;

select count(*) as total_musicas 
from tracks;

select 
    count(*) as total_musicas,
    sum(duration_seconds) as duracao_total_segundos,
    round(sum(duration_seconds)/60, 2) as duracao_total_minutos,
    round(sum(duration_seconds)/3600, 2) as duracao_total_horas,
    round(avg(duration_seconds), 2) as duracao_media
from tracks;

select 
    (select max(duration_seconds) from tracks) as duracao_maxima,
    (select min(duration_seconds) from tracks) as duracao_minima;

select 
    count(*) as total_faixas,
    sum(visualization) as total_visualizacoes,
    round(avg(visualization), 2) as media_visualizacoes
from tracks
where visualization is not null;

select 
    plan_type,
    count(*) as total_usuarios,
    round(sum(value_subscriptions), 2) as receita_total
from subscriptions
group by plan_type
order by total_usuarios desc;

-- agrupando dados (group by)
select 
    ar.name_artist,
    count(t.id_tracks) as total_musicas,
    round(sum(t.duration_seconds)/60, 2) as duracao_total_minutos
from artist ar
join albums al on ar.id_artist = al.id_artist
join tracks t on al.id_albums = t.id_albums
group by ar.id_artist, ar.name_artist
order by total_musicas desc;

select 
    u.name_users,
    count(p.id_playlists) as total_playlists
from users u
left join playlists p on u.id_users = p.id_users
group by u.id_users, u.name_users
having count(p.id_playlists) > 0
order by total_playlists desc;

select 
    t.title_tracks,
    count(tg.id_genre) as total_generos
from tracks t
left join track_genres tg on t.id_tracks = tg.id_tracks
group by t.id_tracks, t.title_tracks
order by total_generos desc;

select 
    u.name_users,
    count(ph.id_play_historys) as total_reproducoes,
    round(avg(ph.seconds_hear), 2) as media_segundos_ouvidos
from users u
left join play_historys ph on u.id_users = ph.id_users
group by u.id_users, u.name_users
having count(ph.id_play_historys) > 0
order by total_reproducoes desc;

select 
    t.title_tracks,
    count(r.id_ratings) as total_ratings,
    round(avg(r.star_ratings), 2) as media_stars
from tracks t
left join ratings r on t.id_tracks = r.id_tracks
group by t.id_tracks, t.title_tracks
order by media_stars desc;

select 
    ar.name_artist,
    count(f.id_followers) as total_seguidores
from artist ar
left join followers f on ar.id_artist = f.id_artist
group by ar.id_artist, ar.name_artist
order by total_seguidores desc;

-- filtrando grupos (having)
select 
    ar.name_artist,
    count(al.id_albums) as total_albuns
from artist ar
join albums al on ar.id_artist = al.id_artist
group by ar.id_artist, ar.name_artist
having count(al.id_albums) > 1
order by total_albuns desc;

select 
    u.name_users,
    count(ph.id_play_historys) as total_reproducoes
from users u
left join play_historys ph on u.id_users = ph.id_users
group by u.id_users, u.name_users
having count(ph.id_play_historys) >= 2
order by total_reproducoes desc;

select 
    t.title_tracks,
    count(r.id_ratings) as total_ratings,
    round(avg(r.star_ratings), 2) as media_stars
from tracks t
left join ratings r on t.id_tracks = r.id_tracks
group by t.id_tracks, t.title_tracks
having avg(r.star_ratings) >= 4;

-- ordenação e limites (order by e limit)
select 
    t.title_tracks,
    ar.name_artist,
    count(f.id_favorites) as total_curtidas
from tracks t
join favorites f on t.id_tracks = f.id_tracks
join albums al on t.id_albums = al.id_albums
join artist ar on al.id_artist = ar.id_artist
group by t.id_tracks, t.title_tracks, ar.name_artist
order by total_curtidas desc
limit 5;

select 
    t.title_tracks,
    ar.name_artist,
    count(ph.id_play_historys) as total_reproducoes,
    round(sum(ph.seconds_hear)/3600, 2) as horas_ouvidas
from tracks t
join play_historys ph on t.id_tracks = ph.id_tracks
join albums al on t.id_albums = al.id_albums
join artist ar on al.id_artist = ar.id_artist
group by t.id_tracks, t.title_tracks, ar.name_artist
order by total_reproducoes desc
limit 10;

select 
    ph.timestamp_reproduction,
    u.name_users,
    t.title_tracks,
    ar.name_artist
from play_historys ph
join users u on ph.id_users = u.id_users
join tracks t on ph.id_tracks = t.id_tracks
join albums al on t.id_albums = al.id_albums
join artist ar on al.id_artist = ar.id_artist
order by ph.timestamp_reproduction desc
limit 5;

select 
    p.title_playlists,
    u.name_users,
    count(pt.id_tracks) as total_musicas,
    p.communal
from playlists p
join users u on p.id_users = u.id_users
left join playlist_tracks pt on p.id_playlists = pt.id_playlists
group by p.id_playlists, p.title_playlists, u.name_users, p.communal
order by total_musicas desc
limit 3;

-- subconsultas (nested queries)
select 
    u.name_users,
    count(ph.id_play_historys) as total_reproducoes
from users u
left join play_historys ph on u.id_users = ph.id_users
group by u.id_users, u.name_users
having count(ph.id_play_historys) > (
    select avg(reproducoes)
    from (
        select count(*) as reproducoes
        from play_historys
        group by id_users
    ) as media
);

select distinct
    t.title_tracks,
    ar.name_artist,
    p.title_playlists
from tracks t
join playlist_tracks pt on t.id_tracks = pt.id_tracks
join playlists p on pt.id_playlists = p.id_playlists
join albums al on t.id_albums = al.id_albums
join artist ar on al.id_artist = ar.id_artist
where p.communal = true
order by ar.name_artist, t.title_tracks;

select 
    u.name_users,
    u.email,
    s.plan_type,
    s.date_start,
    s.date_end
from users u
join subscriptions s on u.id_users = s.id_users
where s.plan_type in ('PREMIUM', 'FAMILY') 
  and s.status_subscriptions = 'ATIVO'
order by u.name_users;

-- consultas complexas
select 
    u.name_users,
    u.email,
    s.plan_type,
    s.status_subscriptions,
    count(distinct p.id_playlists) as total_playlists,
    count(distinct f.id_favorites) as total_curtidas,
    count(distinct ph.id_play_historys) as total_reproducoes,
    count(distinct r.id_ratings) as total_avaliacoes,
    count(distinct fol.id_followers) as total_artistas_seguidos
from users u
left join subscriptions s on u.id_users = s.id_users
left join playlists p on u.id_users = p.id_users
left join favorites f on u.id_users = f.id_users
left join play_historys ph on u.id_users = ph.id_users
left join ratings r on u.id_users = r.id_users
left join followers fol on u.id_users = fol.id_users
group by u.id_users, u.name_users, u.email, s.plan_type, s.status_subscriptions
order by total_reproducoes desc;

select 
    g.name_genre,
    count(distinct t.id_tracks) as total_musicas,
    count(distinct f.id_favorites) as total_curtidas,
    count(distinct ph.id_play_historys) as total_reproducoes,
    round(avg(r.star_ratings), 2) as rating_medio
from genres g
left join track_genres tg on g.id_genre = tg.id_genre
left join tracks t on tg.id_tracks = t.id_tracks
left join favorites f on t.id_tracks = f.id_tracks
left join play_historys ph on t.id_tracks = ph.id_tracks
left join ratings r on t.id_tracks = r.id_tracks
group by g.id_genre, g.name_genre
order by total_reproducoes desc;

select 
    (select count(*) from users) as total_usuarios,
    (select count(*) from artist) as total_artistas,
    (select count(*) from albums) as total_albuns,
    (select count(*) from tracks) as total_musicas,
    (select count(*) from genres) as total_generos,
    (select count(*) from playlists) as total_playlists,
    (select count(*) from favorites) as total_curtidas,
    (select count(*) from play_historys) as total_reproducoes,
    (select count(*) from ratings) as total_avaliacoes,
    (select count(*) from followers) as total_seguidores,
    (select count(*) from subscriptions where status_subscriptions = 'ATIVO') as assinaturas_ativas,
    (select round(sum(value_subscriptions), 2) from subscriptions where status_subscriptions = 'ATIVO') as receita_ativa;

-- análises para o negócio
select 
    plan_type,
    count(*) as quantidade_usuarios,
    round(sum(value_subscriptions), 2) as receita_total,
    round(avg(value_subscriptions), 2) as valor_medio
from subscriptions
where status_subscriptions = 'ATIVO' 
  and date_start >= date_sub(now(), interval 30 day)
group by plan_type
order by receita_total desc;

select 
    u.name_users,
    date(ph.timestamp_reproduction) as data,
    count(*) as reproducoes,
    sum(ph.seconds_hear) as total_segundos_ouvidos
from users u
left join play_historys ph on u.id_users = ph.id_users
where ph.timestamp_reproduction >= date_sub(now(), interval 7 day)
group by u.id_users, u.name_users, date(ph.timestamp_reproduction)
order by u.name_users, data desc;

select 
    ar.name_artist,
    ar.country,
    count(distinct ph.id_play_historys) as reproducoes,
    count(distinct f.id_favorites) as curtidas,
    count(distinct fol.id_followers) as seguidores,
    (count(distinct ph.id_play_historys) * 0.5 + count(distinct f.id_favorites) * 0.3 + count(distinct fol.id_followers) * 0.2) as score_popularidade
from artist ar
left join albums al on ar.id_artist = al.id_artist
left join tracks t on al.id_albums = t.id_albums
left join play_historys ph on t.id_tracks = ph.id_tracks
left join favorites f on t.id_tracks = f.id_tracks
left join followers fol on ar.id_artist = fol.id_artist
group by ar.id_artist, ar.name_artist, ar.country
order by score_popularidade desc;