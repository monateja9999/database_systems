CREATE EXTENSION POSTGIS;

--Drop the table with name geometries, if it already exists
DROP TABLE geometries;

-- Create a table called geometries to store our spatial co-ordinates
CREATE TABLE geometries (name varchar, geom geometry(Point, 4326));

--Insert our long,lat values into the geometries table
INSERT INTO geometries (name, geom)
VALUES
    ('Point 1', ST_SetSRID(ST_MakePoint(-118.2924870,34.0330935),4326)),
    ('Point 2', ST_SetSRID(ST_MakePoint(-118.2869427,34.0241073),4326)),
    ('Point 3', ST_SetSRID(ST_MakePoint(-118.2890283,34.0207119),4326)),
    ('Point 4', ST_SetSRID(ST_MakePoint(-118.2871169,34.0191188),4326)),
    ('Point 5', ST_SetSRID(ST_MakePoint(-118.2868036,34.0187999),4326)),
    ('Point 6', ST_SetSRID(ST_MakePoint(-118.2825381,34.0185941),4326)),
    ('Point 7', ST_SetSRID(ST_MakePoint(-118.2840341,34.0202805),4326)),
    ('Point 8', ST_SetSRID(ST_MakePoint(-118.2853320,34.0201833),4326)),
    ('Point 9', ST_SetSRID(ST_MakePoint(-118.2833997,34.0220001),4326)),
    ('Point 10', ST_SetSRID(ST_MakePoint(-118.2850309,34.0252189),4326)),
    ('Point 11', ST_SetSRID(ST_MakePoint(-118.2846898,34.0232473),4326)),
    ('Point 12', ST_SetSRID(ST_MakePoint(-118.2873163,34.0207454),4326)),
    ('Point 13', ST_SetSRID(ST_MakePoint(-118.2844248,34.0243463),4326));

--Check if the co-ordinates are successfully inserted into the table
SELECT name, ST_AsText(geom) FROM geometries;

--Convex Hull Co-ordinates
SELECT ST_AsText(ST_ConvexHull(ST_Collect(geom))) FROM geometries;

--4 Nearest Neighbours Co-ordinates
SELECT name, ST_AsText(geom)
FROM geometries
WHERE name <> 'Point 1'
ORDER BY ST_Distance(geom, ST_SetSRID(ST_MakePoint(-118.2924870,34.0330935),4326))
LIMIT 4;