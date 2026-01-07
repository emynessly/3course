CREATE SCHEMA IF NOT EXISTS movie_db;

CREATE TABLE IF NOT EXISTS movie_db.movies (
    movie_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    rating NUMERIC DEFAULT 0,
    CONSTRAINT unique_title_release_year UNIQUE (title, release_year)
);

CREATE TABLE IF NOT EXISTS movie_db.directors (
    director_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country INTEGER NOT NULL
);