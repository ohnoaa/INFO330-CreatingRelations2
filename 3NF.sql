-- 3RD NORMAL FORM

-- Creating type table
CREATE TABLE type (
	type_id INTEGER PRIMARY KEY AUTOINCREMENT,
	type_1 TEXT,
	type_2 TEXT
);

-- Inserting types into type table 
INSERT INTO type(type_1, type_2)
SELECT DISTINCT type1, type2
FROM pokemon1;

-- Creating against table 
CREATE TABLE against(
	type_id INTEGER,
	against_bug TEXT,
	against_dark TEXT,
	against_dragon TEXT,
	against_electric TEXT,
	against_fairy TEXT,
	against_fight TEXT,
	against_fire TEXT,
	against_flying TEXT,
	against_ghost TEXT,
	against_grass TEXT,
	against_ground TEXT,
	against_ice TEXT,
	against_normal TEXT,
	against_poison TEXT,
	against_psychic TEXT,
	against_rock TEXT,
	against_steel TEXT,
	against_water TEXT,
	FOREIGN KEY (type_id) REFERENCES type(type_id)
);

-- Inserting values into against table 
INSERT INTO against(type_id, against_bug, against_dark, against_dragon, against_electric, against_fairy,
								against_fight, against_fire, against_flying, against_ghost, against_grass, against_ground, 
								against_ice, against_normal, against_poison, against_psychic, against_rock, against_steel, against_water)
SELECT  type.type_id,  pokemon1.against_bug, pokemon1.against_dark, pokemon1.against_dragon,
					pokemon1.against_electric, pokemon1.against_fairy, pokemon1.against_fight, pokemon1.against_fire,
					pokemon1.against_flying, pokemon1.against_ghost, pokemon1.against_grass, pokemon1.against_ground,
					pokemon1.against_ice, pokemon1.against_normal, pokemon1.against_poison, pokemon1.against_psychic,
					pokemon1.against_rock, pokemon1.against_steel, pokemon1.against_water
FROM type
JOIN pokemon1
		ON type.type_1 = pokemon1.type1
		AND type.type_2 = pokemon1.type2
GROUP BY type.type_id;

-- Creating another temp table to solve my issues with the type fk later
CREATE TABLE temp2 AS
SELECT type.*, pokemon1.*
FROM type
JOIN pokemon1
	ON type.type_1 = pokemon1.type1
	AND type.type_2 = pokemon1.type2;	

-- Recreating main pokemon table with foreign key for type and without the against and type columns 
CREATE TABLE pokemon (
	pokedex_number TEXT PRIMARY KEY,
	name TEXT,
	hp TEXT,
	weight_kg TEXT,
	height_m TEXT,
	generation TEXT,
	classfication TEXT,
	is_legendary TEXT,
	capture_rate TEXT,
	experience_growth TEXT,
	percentage_male TEXT,
	speed TEXT,
	attack TEXT,
	sp_attack TEXT,
	defense TEXT,
	sp_defense TEXT,
	base_egg_steps TEXT,
	base_happiness TEXT,
	base_total TEXT,
	type_id INT REFERENCES type(type_id) 
);

-- Inserting values into new main table 
INSERT INTO pokemon(pokedex_number, name, hp, weight_kg, height_m, generation, classfication, is_legendary,
												capture_rate, experience_growth, percentage_male, speed, attack, sp_attack, defense, sp_defense,
												base_egg_steps, base_happiness, base_total, type_id)
SELECT pokedex_number, name, hp, weight_kg, height_m, generation, classfication, is_legendary,
					capture_rate, experience_growth, percentage_male, speed, attack, sp_attack, defense, sp_defense,
					base_egg_steps, base_happiness, base_total, type_id
FROM temp2;

-- Creating another temp table with abilities
CREATE TABLE temp3 AS
SELECT abilities.*, pokemon_abilities_1.*
FROM abilities
JOIN pokemon_abilities_1
	ON abilities.abilities_id = pokemon_abilities_1.abilities_id;	


--REcreating linking table (pokemon abilities)
CREATE TABLE pokemon_abilities(
	pokedex_number TEXT,
	abilities_id INTEGER,
	FOREIGN KEY (pokedex_number) REFERENCES pokemon(pokedex_number),
	FOREIGN KEY (abilities_id) REFERENCES abilities(abilities_id)
);

--Inserting the linking table stuff
INSERT INTO pokemon_abilities(pokedex_number, abilities_id)
SELECT pokedex_number, abilities_id
FROM temp3;

-- Dropping previous pokemon main table and temp2
DROP TABLE pokemon_abilities_1;
DROP TABLE pokemon1;
DROP TABLE temp2;
DROP TABLE temp3;