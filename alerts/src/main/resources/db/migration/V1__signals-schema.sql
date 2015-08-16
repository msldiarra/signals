CREATE TABLE Tank (
  id SERIAL PRIMARY KEY ,
  name VARCHAR(50) NOT NULL,
  reference VARCHAR(255) NOT NULL,
  description VARCHAR(255) NULL,
  enabled BIT(1) NULL,
  endDate TIMESTAMP NULL,
  startDate TIMESTAMP NULL
);

CREATE TABLE Measure (
  id SERIAL PRIMARY KEY,
  tankId INTEGER NOT NULL,
  level INTEGER NOT NULL,
  time TIMESTAMP NULL
);


CREATE VIEW Alert AS
SELECT m.id, t.reference AS tankReference, m.level, m.time
FROM Measure m
INNER JOIN Tank t ON (t.id = m.id);

CREATE RULE measure_INSERT AS ON INSERT TO Alert DO INSTEAD
  INSERT INTO  Measure (tankId, level, time)
  VALUES ((select Id from Tank WHERE reference = NEW.tankReference), NEW.level, NEW.time)
  RETURNING Measure.id, (SELECT reference FROM Tank WHERE Id = Measure.tankId), Measure.level, Measure.time;

--
-- Constraints
--

ALTER TABLE Measure
  ADD CONSTRAINT FK_Measure_Tank FOREIGN KEY (tankId) REFERENCES Tank (id);