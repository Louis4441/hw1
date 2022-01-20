-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy
-- - Movie data includes the movie title, year released, MPAA rating,
--   and director
-- - A movie has a single director
-- - A person can be the director of and/or play a role in a movie
-- - Everything you need to do in this assignment is marked with TODO!

-- Rubric
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
--   (10 points)
-- - Insertion of "Batman" sample data into tables (5 points)
-- - Selection of data, so that something similar to the following sample
--   "report" can be achieved (5 points)

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Christopher Nolan
-- The Dark Knight        2008           PG-13  Christopher Nolan
-- The Dark Knight Rises  2012           PG-13  Christopher Nolan

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!
-- - Movie data includes the movie title, year released, MPAA rating,
--   and director
-- - A movie has a single director
-- - A person can be the director of and/or play a role in a movie

DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS persons; 
DROP TABLE IF EXISTS roles;

-- Create new tables, according to your domain model
-- TODO!

CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    release_year INTEGER,
    age_rating TEXT,
    person_id INTEGER,
    FOREIGN KEY (person_id)
      REFERENCES persons(id)
);

CREATE TABLE characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    character TEXT
);

CREATE TABLE persons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT
);

CREATE TABLE roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER,
    character_id INTEGER,
    person_id INTEGER,
    FOREIGN KEY (movie_id)
      REFERENCES movies(id),
    FOREIGN KEY (character_id)
      REFERENCES characters(id),
    FOREIGN KEY (person_id)
      REFERENCES persons(id)
);

--CREATE TABLE characters (
--    id INTEGER PRIMARY KEY AUTOINCREMENT,
--    character
--)
-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!
INSERT INTO movies (
    title, release_year, age_rating, person_id)
    VALUES (
        "Batman Begins", 2005, "PG-13", 12), --1
        ("The Dark Knight", 2008, "PG-13", 12), --2
        ("The Dark Knight Rises", 2012, "PG-13", 12
        ); --3

INSERT INTO characters (character)
    VALUES (
        "Bruce Wayne"), --1
        ("Alfred"), --2
        ("Ra's Al Ghul"), --3
        ("Rachel Dawes"), --4
        ("Commissioner Gordon"), --5
        ("Joker"), --6
        ("Harvey Dent"), --7
        ("Bane"), --8
        ("John Blake"), --9
        ("Selina Kyle"
        ); --10

INSERT INTO persons (full_name)
    VALUES (
        "Christian Bale"), --1
        ("Michael Caine"), --2
        ("Liam Neeson"), --3
        ("Katie Holmes"), --4
        ("Maggie Gyllenhaal"), --5
        ("Gary Oldman"), --6
        ("Heath Ledger"), --7
        ("Aaron Eckhart"), --8
        ("Tom Hardy"), --9
        ("Joseph Gordon-Levitt"), --10
        ("Anne Hathaway"), --11
        ("Christopher Nolan"
        ); --12 (director)

INSERT INTO roles (movie_id, person_id, character_id)
    VALUES (
        1, 1, 1),
        (1, 2, 2),
        (1, 3, 3),
        (1, 4, 4),
        (1, 6, 5),
        (2, 1, 1),
        (2, 7, 6),
        (2, 8, 7),
        (2, 2, 2),
        (2, 5, 4),
        (3, 1, 1),
        (3, 6, 5),
        (3, 9, 8),
        (3, 10, 9),
        (3, 11, 10
    );

-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
-- TODO!
SELECT title, release_year, age_rating, persons.full_name
FROM movies
    INNER JOIN persons ON movies.person_id = persons.id;
-- 

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
-- TODO!
SELECT movies.title, persons.full_name, characters.character
FROM roles
    INNER JOIN movies ON movies.id = roles.movie_id
    INNER JOIN persons ON persons.id = roles.person_id 
    INNER JOIN characters ON characters.id = character_id;
    