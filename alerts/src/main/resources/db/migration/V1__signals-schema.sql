--
-- Table creation
--

CREATE TABLE IF NOT EXISTS Tank (
  Id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Reference VARCHAR(15) NOT NULL,
  StationId INTEGER NOT NULL,
  Description VARCHAR(255) NOT NULL DEFAULT 'NO_DESCRIPTION',
  WarningLevelPercentage INTEGER NOT NULL,
  LiquidTypeId INTEGER NOT NULL,
  LevelTypeId INTEGER NOT NULL,
  Enabled BIT(1) NOT NULL DEFAULT '1',
  StartDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS TankEndDate (
  Id SERIAL PRIMARY KEY,
  TankId INTEGER NOT NULL,
  EndDate TIMESTAMP NOT NULL
);



CREATE TABLE IF NOT EXISTS Measure (
  Id SERIAL PRIMARY KEY,
  TankId INTEGER NOT NULL,
  Level INTEGER NOT NULL,
  Time TIMESTAMP NULL
);


CREATE TABLE IF NOT EXISTS LevelType (
  Id SERIAL PRIMARY KEY,
  LevelType VARCHAR(25) NOT NULL,
  Unit VARCHAR(25) NOT NULL
);


CREATE TABLE IF NOT EXISTS LiquidType (
  Id SERIAL PRIMARY KEY,
  Reference VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS LiquidDensity (
  Id SERIAL PRIMARY KEY,
  Density INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS Customer (
  Id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS CustomerContact (
  CustomerId INTEGER NOT NULL,
  ContactId INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Station (
  Id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Reference VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS CustomerStation (
  CustomerId INTEGER NOT NULL,
  StationId INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS StationTank (
  StationId INTEGER NOT NULL,
  TankId INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Contact (
  Id SERIAL PRIMARY KEY,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  ContactInfoId INTEGER NOT NULL,
  ContactTypeId INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS ContactType (
  Id SERIAL PRIMARY KEY,
  Type VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS ContactInfo (
  Id SERIAL PRIMARY KEY,
  Email VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS TankShape (
  Id SERIAL PRIMARY KEY,
  Shape VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS TankSize (
  Id SERIAL PRIMARY KEY,
  Width INTEGER NOT NULL,
  Height INTEGER NOT NULL,
  ShapeId INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS TankMaximumCapacity (
  Id SERIAL PRIMARY KEY,
  TankId INTEGER NOT NULL,
  Volume INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS TankTankSize (
  TankId INTEGER NOT NULL,
  TankSizeId INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Login (
  Id SERIAL PRIMARY KEY,
  Login VARCHAR(100) NOT NULL,
  Password VARCHAR(100) NOT NULL,
  Enabled bit(1) NOT NULL DEFAULT '1'
);

CREATE TABLE IF NOT EXISTS ContactLogin (
  ContactId INTEGER NOT NULL,
  LoginId INTEGER NOT NULL
);

CREATE VIEW Alert AS
  SELECT m.id, t.reference AS tankReference, m.level, m.time
  FROM Measure m
    INNER JOIN Tank t ON (t.id = m.tankId);

CREATE RULE Measure_INSERT AS ON INSERT TO Alert DO INSTEAD
  INSERT INTO  Measure (tankId, level, time)
  VALUES ((select Id from Tank WHERE reference = NEW.tankReference), NEW.level, NEW.time)
  RETURNING Measure.id, (SELECT reference FROM Tank WHERE Id = Measure.tankId), Measure.level, Measure.time;


CREATE VIEW Users AS
  SELECT c.Id, c.FirstName, c.LastName, ci.Email, l.Login, l.Password, l.Enabled, cu.Name AS Company
  FROM ContactLogin AS cl
    INNER JOIN Login AS l ON l.Id = cl.LoginId
    INNER JOIN Contact AS c ON c.Id = cl.ContactId
    INNER JOIN ContactInfo AS ci ON ci.Id = c.ContactInfoId
    INNER JOIN CustomerContact AS cc ON cc.ContactId = c.Id
    INNER JOIN Customer cu ON cu.Id = cc.CustomerId;


CREATE VIEW TanksInAlert AS
  SELECT Tank.Id, Tank.Name AS Tank, Customer.Name as Customer, Station.Name AS Station, LiquidType.Reference AS LiquidType, Measure.Level, LevelType.Unit, Measure.Time AS MeasureTime,
    round(((Measure.Level::float / TankMaximumCapacity.Volume) * 100)::numeric, 2) AS FIllingRate
  FROM Station
    INNER JOIN StationTank ON StationTank.StationId = Station.Id
    INNER JOIN Tank ON tank.Id = StationTank.TankId
    INNER JOIN LiquidType ON LiquidType.Id = Tank.LiquidTypeId
    INNER JOIN LevelType ON LevelType.Id = Tank.LevelTypeId
    INNER JOIN Measure ON Tank.id = Measure.TankId
    INNER JOIN (
                 SELECT DISTINCT ON(TankId) Id, Time
                 FROM Measure
                 ORDER BY TankId, Time DESC
               ) LatestMeasure ON Measure.Id = LatestMeasure.Id
    INNER JOIN CustomerStation ON customerStation.StationId = Station.Id
    INNER JOIN Customer ON Customer.Id = CustomerStation.CustomerId
    LEFT JOIN TankMaximumCapacity ON TankMaximumCapacity.TankId = Tank.Id
  WHERE
    CASE WHEN TankMaximumCapacity.Volume IS NOT NULL
            THEN Measure.Level <= (TankMaximumCapacity.Volume * Tank.WarningLevelPercentage) / 100
         ELSE FALSE
         END;

CREATE VIEW TankMonitoring AS
  SELECT
    M1.TankId as Id,
    M1.MeasureCount,
    M2.OldestMeasureTime,
    M3.LatestMeasureTime,
    M3.LatestMeasureLevel
  FROM (SELECT TankId, COUNT(Id) AS MeasureCount FROM Measure GROUP BY TankId ) M1
  INNER JOIN (SELECT TankId, TIME AS OldestMeasureTime FROM Measure ORDER BY TankId, Time ASC LIMIT 1) M2 ON M1.TankId = M2.TankId
  INNER JOIN (SELECT TankId, TIME AS LatestMeasureTime, Level AS LatestMeasureLevel FROM Measure ORDER BY TankId, Time DESC LIMIT 1) M3 ON M1.TankId = M3.TankId;

--
-- Constraints
--

ALTER TABLE Tank
  ADD CONSTRAINT FK_Tank_LiquidType FOREIGN KEY (LiquidTypeId) REFERENCES LiquidType (Id);

ALTER TABLE Measure
  ADD CONSTRAINT FK_Measure_Tank FOREIGN KEY (tankId) REFERENCES Tank (id);

ALTER TABLE TankEndDate
  ADD CONSTRAINT FK_TankEndDate_Tank FOREIGN KEY (TankId) REFERENCES Tank (Id);

ALTER TABLE CustomerStation
  ADD CONSTRAINT FK_CustomerStation_Customer FOREIGN KEY (CustomerId) REFERENCES Customer (Id),
  ADD CONSTRAINT FK_CustomerStation_Station FOREIGN KEY (StationId) REFERENCES Station (Id);

ALTER TABLE StationTank
  ADD CONSTRAINT FK_StationTank_Station FOREIGN KEY (StationId) REFERENCES Station (Id),
  ADD CONSTRAINT FK_StationTank_Tank FOREIGN KEY (TankId) REFERENCES Tank (Id);

ALTER TABLE Contact
  ADD CONSTRAINT FK_Contact_ContactInfo FOREIGN KEY (ContactInfoId) REFERENCES ContactInfo (Id);

ALTER TABLE Tank
  ADD CONSTRAINT FK_Tank_Station FOREIGN KEY (StationId) REFERENCES Station (Id),
  ADD CONSTRAINT FK_Tank_LevelType FOREIGN KEY (LevelTypeId) REFERENCES LevelType (Id);
ALTER TABLE CustomerContact
  ADD CONSTRAINT FK_CustomerContact_Contact FOREIGN KEY (ContactId) REFERENCES Contact (Id),
  ADD CONSTRAINT FK_CustomerContact_Customer FOREIGN KEY (CustomerId) REFERENCES Customer (Id);


ALTER TABLE TankSize
  ADD CONSTRAINT FK_TankSize_TankShape FOREIGN KEY (ShapeId) REFERENCES TankShape (Id);


ALTER TABLE TankTankSize
  ADD CONSTRAINT FK_TankTankSize_TankSize FOREIGN KEY (TankId) REFERENCES Tank (Id),
  ADD CONSTRAINT FK_TankTankSize_Tank FOREIGN KEY (TankSizeId) REFERENCES TankSize (Id);


ALTER TABLE ContactLogin
   ADD CONSTRAINT FK_ContactLogin_Login FOREIGN KEY (LoginId) REFERENCES Login (Id),
   ADD CONSTRAINT FK_ContactLogin_Contact FOREIGN KEY (ContactId) REFERENCES Contact (Id);

ALTER TABLE TankMaximumCapacity
   ADD CONSTRAINT FK_TankMaximumCapacity_Tank  FOREIGN KEY (TankId) REFERENCES Tank (Id);

ALTER TABLE LevelType
    ADD CONSTRAINT UK_LevelType_Unit UNIQUE(LevelType,Unit);

---
--- INSERT REFERENCE DATA
---

INSERT INTO LiquidType (Reference) VALUES
('GASOLINE'),
('DIESEL SP 91');

INSERT INTO ContactType (Type) VALUES
('Owner'),
('Manager');

INSERT INTO LevelType (LevelType, Unit)
VALUES ('VOLUME','L'), ('HEIGHT', 'M');