CREATE TABLE IF NOT EXISTS Tank (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  reference varchar(255) NOT NULL,
  description varchar(255) NULL,
  enabled bit(1) NULL,
  endDate datetime NULL,
  startDate datetime NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Measure (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  tankId bigint(20) NOT NULL,
  level bigint(20) NOT NULL,
  time datetime NULL,
  PRIMARY KEY (id)
);


CREATE VIEW Alert AS
SELECT m.id, t.reference, m.level, m.time AS value
FROM Measure m
LEFT JOIN Tank t
ON t.id = m.id;


--
-- Constraints
--

ALTER TABLE Measure
  ADD CONSTRAINT FK_Measure_Tank FOREIGN KEY (tankId) REFERENCES Tank (id);