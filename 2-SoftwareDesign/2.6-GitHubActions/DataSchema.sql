CREATE TABLE "Users" (
    "User_ID" SERIAL PRIMARY KEY,
    "Username" VARCHAR(50) NOT NULL,
    "Email" VARCHAR(100) NOT NULL UNIQUE CHECK (
        "Email" ~ '^([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4})$'
    ),
    "Created_At" DATE NOT NULL
);

CREATE TABLE "SleepData" (
    "Sleep_ID" SERIAL PRIMARY KEY,
    "User_ID" INT NOT NULL REFERENCES "Users" ("User_ID"),
    "Sleep_Duration" FLOAT CHECK ("Sleep_Duration" BETWEEN 0 AND 24),
    "Sleep_Quality" VARCHAR(20),
    "Sleep_Date" DATE NOT NULL
);

CREATE TABLE "Recommendations" (
    "Recommendation_ID" SERIAL PRIMARY KEY,
    "User_ID" INT NOT NULL REFERENCES "Users" ("User_ID"),
    "Recommendation_Text" VARCHAR(500) NOT NULL,
    "Created_At" DATE NOT NULL
);

CREATE TABLE "HousingOptions" (
    "Housing_ID" SERIAL PRIMARY KEY,
    "User_ID" INT NOT NULL REFERENCES "Users" ("User_ID"),
    "Location" VARCHAR(100) NOT NULL,
    "Price" NUMERIC(10, 2) CHECK ("Price" > 0),
    "Comfort_Level" VARCHAR(50),
    "Contact_Email" VARCHAR(100) CHECK (
        "Contact_Email" ~ '^([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4})$'
    )
);
