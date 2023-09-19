CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM parents, dogs WHERE parent = name ORDER BY height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name AS name, b.size AS size
  FROM dogs AS a, sizes AS b
  WHERE b.min < a.height AND a.height <= b.max
  ;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS c1, b.child AS c2
  FROM parents AS a, parents AS b
  WHERE a.parent = b.parent AND a.child < b.child
  ;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || c1 || " plus " || c2 || " have the same size: " || size1.size
  FROM siblings, size_of_dogs AS size1, size_of_dogs AS size2
  WHERE size1.name = c1 AND size2.name = c2 AND c1 < c2 AND size1.size = size2.size
  ;

