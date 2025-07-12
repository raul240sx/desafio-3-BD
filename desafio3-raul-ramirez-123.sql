--1. Crear una base de datos llamada películas.
CREATE DATABASE peliculas;
--------------------------------------------------------------------------

-- 2. Cargar ambos archivos a su tabla correspondiente.
CREATE TABLE peliculas (
	id SERIAL PRIMARY KEY,
	Titulo VARCHAR(100),
	Anio_Estreno INT,
	Director VARCHAR(50)
);


CREATE TABLE reparto (
	id_pelicula INT REFERENCES peliculas(id),
	Actor VARCHAR(50)
);


-- Cargamos los datos de los archivos csv

COPY peliculas
FROM '/docker-entrypoint-initdb.d/peliculas.csv'
WITH (
	format csv,
	header true
);


COPY reparto
FROM '/docker-entrypoint-initdb.d/reparto.csv'
WITH (
	format csv,
	header true
);
--------------------------------------------------------------------------


-- 3. Obtener el ID de la película “Titanic”

select id as pelicula_id from peliculas  where titulo = 'Titanic';

--------------------------------------------------------------------------


-- 4. Listar a todos los actores que aparecen en la película "Titanic".
SELECT actor AS actores_en_Titanic 
FROM reparto
INNER JOIN peliculas
ON reparto.id_pelicula = peliculas.id
WHERE peliculas.Titulo = 'Titanic';

--------------------------------------------------------------------------


-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.

SELECT COUNT(actor) as cant_peliculas_harrison_ford
FROM reparto
INNER JOIN peliculas
ON reparto.id_pelicula = peliculas.id
WHERE reparto.actor = 'Harrison Ford';


--------------------------------------------------------------------------


-- 6. Indicar las películas estrenadas entre los años 1990 y 1999
-- ordenadas por título de manera ascendente.

SELECT *
FROM peliculas
WHERE Anio_Estreno >= 1990 AND Anio_Estreno <= 1999
ORDER BY Titulo ASC;


--------------------------------------------------------------------------


-- 7. Hacer una consulta SQL que muestre los títulos con su longitud,
-- la longitud debe ser nombrado para la consulta como “longitud_titulo”.

SELECT Titulo, LENGTH(Titulo) as longitud_titulo
FROM peliculas; 

--------------------------------------------------------------------------


-- 8. Consultar cual es la longitud más grande entre todos los títulos
-- de las películas.

SELECT Titulo, LENGTH(Titulo) as longitud_titulo
FROM peliculas
ORDER BY longitud_titulo DESC
LIMIT 1;
