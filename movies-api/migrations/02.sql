-- 1. Tabla de países
CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    iso_code VARCHAR(3) NOT NULL UNIQUE
);

-- 2. Tabla de géneros
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabla de directores
CREATE TABLE directors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    birth_date DATE,
    country_id INTEGER REFERENCES countries(id),
    -- just want day, month, year not hour
    created_at DATE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabla de ratings
CREATE TABLE age_ratings (
    id SERIAL PRIMARY KEY,
    description VARCHAR(50) NOT NULL,
    minimum_age INTEGER NOT NULL
);

-- 5. Tabla de idiomas
CREATE TABLE languages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    iso_code VARCHAR(3) NOT NULL UNIQUE
);

-- 6. Tabla de películas
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    synopsis TEXT,
    year INTEGER,
    release_date DATE,
    rating DECIMAL(3,1),
    genre_id INTEGER REFERENCES genres(id),
    director_id INTEGER REFERENCES directors(id),
    country_id INTEGER REFERENCES countries(id),
    language_id INTEGER REFERENCES languages(id),
    age_rating_id INTEGER REFERENCES age_ratings(id),
    -- //without timestamp
    expires_at TIMESTAMP DEFAULT current_timestamp + INTERVAL '1 year'
);

-- 7. Tabla de series
CREATE TABLE series (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    synopsis TEXT,
    start_year INTEGER,
    end_year INTEGER,
    total_seasons INTEGER,
    rating DECIMAL(3,1),
    genre_id INTEGER REFERENCES genres(id),
    director_id INTEGER REFERENCES directors(id),
    country_id INTEGER REFERENCES countries(id),
    language_id INTEGER REFERENCES languages(id),
    age_rating_id INTEGER REFERENCES age_ratings(id),
    expires_at TIMESTAMP DEFAULT current_timestamp + INTERVAL '1 year'
);

-- 8. Tabla de claves API
CREATE TABLE api_keys (
    id SERIAL PRIMARY KEY,
    api_key VARCHAR(64) NOT NULL UNIQUE,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP
);


INSERT INTO countries (name, iso_code) 
VALUES ('USA', 'USA'), ('UK', 'UK'), ('Spain', 'ESP'), ('Mexico', 'MEX'), 
('Argentina', 'ARG'), ('Brazil', 'BRA'), ('Canada', 'CAN'), ('Australia', 'AUS'), 
('Germany', 'DEU'), ('France', 'FRA'), ('Portugal', 'PRT'), ('Denmark', 'DNK'), ('Italy', 'ITA'), 
('South Korea', 'KOR'), ('Japan', 'JPN'), ('China', 'CHN'), ('Russia', 'RUS');

INSERT INTO genres (name, description) 
VALUES ('Action', 'Action movies'), ('Comedy', 'Comedy movies'), ('Drama', 'Drama movies'), ('Horror', 'Horror movies'), ('Sci-Fi', 'Sci-Fi movies'), ('Fantasy', 'Fantasy movies'), ('Romance', 'Romance movies'), ('Thriller', 'Thriller movies'), ('Animation', 'Animation movies'), ('Documentary', 'Documentary movies');

INSERT INTO age_ratings (description, minimum_age) 
VALUES ('G', 0), ('PG', 13), ('PG-13', 13), ('R', 17), ('NC-17', 18);

INSERT INTO languages (name, iso_code) 
VALUES ('English', 'ENG'), ('Spanish', 'ESP'), ('French', 'FRA'), ('German', 'DEU'), ('Italian', 'ITA'), ('Portuguese', 'POR'), ('Russian', 'RUS'), ('Chinese', 'CHN'), ('Japanese', 'JPN'), ('Korean', 'KOR');

--- directors
INSERT INTO directors (name, birth_date, country_id) VALUES
('Christopher Nolan', '1970-07-30', (SELECT id FROM countries WHERE iso_code='USA')),
('Quentin Tarantino', '1963-03-27', (SELECT id FROM countries WHERE iso_code='USA')),
('Pedro Almodóvar', '1949-09-25', (SELECT id FROM countries WHERE iso_code='ESP')),
('Bong Joon-ho', '1969-09-14', (SELECT id FROM countries WHERE iso_code='KOR')),
('Hayao Miyazaki', '1941-01-05', (SELECT id FROM countries WHERE iso_code='JPN')),
('Alejandro Amenábar', '1972-03-31', (SELECT id FROM countries WHERE iso_code='ESP')),
('Juan Antonio Bayona', '1975-05-09', (SELECT id FROM countries WHERE iso_code='ESP')),
('Fernando Trueba', '1955-01-18', (SELECT id FROM countries WHERE iso_code='ESP')),
('Álex de la Iglesia', '1965-12-04', (SELECT id FROM countries WHERE iso_code='ESP')),
('Isabel Coixet', '1960-04-09', (SELECT id FROM countries WHERE iso_code='ESP')),
('Carlos Saura', '1932-01-04', (SELECT id FROM countries WHERE iso_code='ESP')),
('Ken Loach', '1936-06-17', (SELECT id FROM countries WHERE iso_code='UK')),
('Danny Boyle', '1956-10-20', (SELECT id FROM countries WHERE iso_code='UK')),
('Guy Ritchie', '1968-09-10', (SELECT id FROM countries WHERE iso_code='UK')),
('Steve McQueen', '1969-10-09', (SELECT id FROM countries WHERE iso_code='UK')),
('Luc Besson', '1959-03-18', (SELECT id FROM countries WHERE iso_code='FRA')),
('Jean-Pierre Jeunet', '1953-09-03', (SELECT id FROM countries WHERE iso_code='FRA')),
('François Ozon', '1967-11-15', (SELECT id FROM countries WHERE iso_code='FRA')),
('Jacques Audiard', '1952-04-30', (SELECT id FROM countries WHERE iso_code='FRA')),
('Wim Wenders', '1945-08-14', (SELECT id FROM countries WHERE iso_code='DEU')),
('Werner Herzog', '1942-09-05', (SELECT id FROM countries WHERE iso_code='DEU')),
('Fatih Akin', '1973-08-25', (SELECT id FROM countries WHERE iso_code='DEU')),
('Tom Tykwer', '1965-05-23', (SELECT id FROM countries WHERE iso_code='DEU')),
('Paolo Sorrentino', '1970-05-31', (SELECT id FROM countries WHERE iso_code='ITA')),
('Federico Fellini', '1920-01-20', (SELECT id FROM countries WHERE iso_code='ITA')),
('Roberto Benigni', '1952-10-27', (SELECT id FROM countries WHERE iso_code='ITA')),
('Pedro Costa', '1959-12-29', (SELECT id FROM countries WHERE iso_code='PRT')),
('Lars von Trier', '1956-04-30', (SELECT id FROM countries WHERE iso_code='DNK')),
('Thomas Vinterberg', '1969-05-19', (SELECT id FROM countries WHERE iso_code='DNK'));