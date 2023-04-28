-- 2ND NORMAL FORM

-- Creating separate abilities table
CREATE TABLE abilities (
	abilities_id INTEGER PRIMARY KEY AUTOINCREMENT,
	abilities_name TEXT
);

-- Adding the abilities from the main table to the abilities table
INSERT INTO abilities(abilities_name)
SELECT DISTINCT abilities_name
FROM first_norm_form;

-- Making temp table to be able to insert values eventually
CREATE TABLE temp1 AS
SELECT abilities.*, first_norm_form.*
FROM abilities
JOIN first_norm_form
	ON abilities.abilities_name = first_norm_form.abilities_name;	

-- Creating main table with pokedex_number as primary key
CREATE TABLE pokemon1 (
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
	type1 TEXT,
	type2 TEXT,
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
	base_egg_steps TEXT,
	base_happiness TEXT,
	base_total TEXT
);

INSERT INTO pokemon1 (pokedex_number, name, hp, weight_kg, height_m, generation, classfication,
																		is_legendary, capture_rate, experience_growth, percentage_male, speed, attack, 
																		sp_attack, defense, sp_defense, type1, type2, against_bug, against_dark, 
																		against_dragon, against_electric, against_fairy, against_fight, against_fire, against_flying, 
																		against_ghost, against_grass, against_ground, against_ice, against_normal, against_poison,
																		against_psychic, against_rock, against_steel, against_water, base_egg_steps, base_happiness, base_total)
SELECT DISTINCT pokedex_number, name, hp, weight_kg, height_m, generation, classfication,
										is_legendary, capture_rate, experience_growth, percentage_male, speed, attack, 
										sp_attack, defense, sp_defense, type1, type2, against_bug, against_dark, 
										against_dragon, against_electric, against_fairy, against_fight, against_fire, against_flying, 
										against_ghost, against_grass, against_ground, against_ice, against_normal, against_poison,
										against_psychic, against_rock, against_steel, against_water, base_egg_steps, base_happiness, base_total
FROM first_norm_form;

-- Creating linking table (pokemon abilities)
CREATE TABLE pokemon_abilities_1(
	pokedex_number TEXT,
	abilities_id INTEGER,
	FOREIGN KEY (pokedex_number) REFERENCES pokemon1(pokedex_number),
	FOREIGN KEY (abilities_id) REFERENCES abilities(abilities_id)
);

INSERT INTO pokemon_abilities_1(pokedex_number, abilities_id)
SELECT pokedex_number, abilities_id
FROM temp1;

-- Dropping the temp table
DROP TABLE temp1;
DROP TABLE first_norm_form;
