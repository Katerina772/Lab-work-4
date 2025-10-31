-- Фізична схема БД "Пошук житла та моніторинг сну"

-- Таблиця користувачів
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    preferences TEXT,
    CHECK (email ~* '^([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,})$')
);

-- Таблиця даних про сон
CREATE TABLE SleepData (
    sleep_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    date DATE NOT NULL,
    duration INT CHECK (duration BETWEEN 0 AND 24),
    quality VARCHAR(20) CHECK (quality IN ('low','medium','high')),
    CHECK (quality ~* '^[a-z]+$')
);

-- Таблиця рекомендацій
CREATE TABLE Recommendations (
    rec_id SERIAL PRIMARY KEY,
    sleep_id INT REFERENCES SleepData(sleep_id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    priority VARCHAR(10) CHECK (priority IN ('low','medium','high')),
    status VARCHAR(10) DEFAULT 'active'
);

-- Таблиця запитів на пошук житла
CREATE TABLE HousingSearch (
    search_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    city VARCHAR(50) NOT NULL,
    min_price NUMERIC(10,2),
    max_price NUMERIC(10,2),
    rooms SMALLINT
);

-- Таблиця варіантів житла
CREATE TABLE HousingOptions (
    option_id SERIAL PRIMARY KEY,
    search_id INT REFERENCES HousingSearch(search_id) ON DELETE CASCADE,
    address VARCHAR(150) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    rooms SMALLINT,
    comfort_level VARCHAR(20)
);

-- Таблиця збережених варіантів
CREATE TABLE SavedOptions (
    saved_id SERIAL PRIMARY KEY,
    option_id INT REFERENCES HousingOptions(option_id),
    date_saved DATE DEFAULT CURRENT_DATE,
    user_comment TEXT
);
