-- 1ST NORMAL FORM

-- Imported csv table is called: imported_pokemon_data

-- Split apart the abilities column values and store in new table
CREATE TABLE first_norm AS
SELECT abilities, trim(value) AS split_value
FROM imported_pokemon_data,
			  json_each('["' || replace(abilities, ',', ' "," ') || '"]')
WHERE split_value <> '';

-- Removing 'stupid' characters
UPDATE  first_norm 
SET split_value = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(split_value, '[', ''), ']', ''), '''', ''), '"', ''));

-- Creating a second version of first_norm with only distinct values
CREATE TABLE first_norm_second AS
SELECT DISTINCT abilities, split_value
FROM first_norm;

-- New combined table
CREATE TABLE first_norm_final AS
SELECT  first_norm_second.abilities,  first_norm_second.split_value, imported_pokemon_data.* 
FROM first_norm_second
JOIN imported_pokemon_data
		ON first_norm_second.abilities = imported_pokemon_data.abilities;
		

-- Used to get column names: PRAGMA table_info(first_norm_final);

-- Creating new table without the duplicate abilities columns
CREATE TABLE first_norm_form AS
SELECT pokedex_number, name, hp, weight_kg, height_m, generation, classfication, is_legendary, 
					capture_rate, experience_growth, percentage_male, speed, attack, sp_attack, defense, 
					sp_defense, type1, type2, split_value, against_bug, against_dark, against_dragon, 
					against_electric, against_fairy, against_fight, against_fire, against_flying, against_ghost, 
					against_grass, against_ground, against_ice, against_normal, against_poison, against_psychic, 
					against_rock, against_steel, against_water, base_egg_steps, base_happiness, base_total
FROM first_norm_final;
		
-- Rename split values to abilities
ALTER TABLE first_norm_form
RENAME COLUMN split_value TO abilities_name;

-- Dropping extra tables
DROP TABLE first_norm;
DROP TABLE first_norm_second;
DROP TABLE first_norm_final;
