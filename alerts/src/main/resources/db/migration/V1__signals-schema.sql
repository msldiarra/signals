--
-- Table creation
--

CREATE TABLE Tank (
  Id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Reference VARCHAR(15) NOT NULL,
  StationId INTEGER NOT NULL,
  Description VARCHAR(255) NOT NULL DEFAULT 'NO_DESCRIPTION',
  WarningLevelPercentage INTEGER NOT NULL,
  LiquidTypeId INTEGER NOT NULL,
  Enabled BIT(1) NOT NULL DEFAULT '1',
  StartDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TankEndDate (
  Id SERIAL PRIMARY KEY,
  TankId INTEGER NOT NULL,
  EndDate TIMESTAMP NOT NULL
);



CREATE TABLE Measure (
  Id SERIAL PRIMARY KEY,
  TankId INTEGER NOT NULL,
  Level INTEGER NOT NULL,
  Time TIMESTAMP NULL
);


CREATE TABLE LiquidType (
  Id SERIAL PRIMARY KEY,
  Reference VARCHAR(100) NOT NULL
);

CREATE TABLE LiquidDensity (
  Id SERIAL PRIMARY KEY,
  Density INTEGER NOT NULL
);


CREATE TABLE Customer (
  Id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL
);

CREATE TABLE CustomerContact (
  CustomerId INTEGER NOT NULL,
  ContactId INTEGER NOT NULL
);

CREATE TABLE Station (
  Id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Reference VARCHAR(15) NOT NULL
);

CREATE TABLE CustomerStation (
  CustomerId INTEGER NOT NULL,
  StationId INTEGER NOT NULL
);

CREATE TABLE StationTank (
  StationId INTEGER NOT NULL,
  TankId INTEGER NOT NULL
);

CREATE TABLE Contact (
  Id SERIAL PRIMARY KEY,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  ContactInfoId INTEGER NOT NULL,
  ContactTypeId INTEGER NOT NULL
);

CREATE TABLE ContactType (
  Id SERIAL PRIMARY KEY,
  Type VARCHAR(100) NOT NULL
);

CREATE TABLE ContactInfo (
  Id SERIAL PRIMARY KEY,
  Email VARCHAR(100) NOT NULL
);

CREATE TABLE TankShape (
  Id SERIAL PRIMARY KEY,
  Shape VARCHAR(100) NOT NULL
);

CREATE TABLE TankSize (
  Id SERIAL PRIMARY KEY,
  Width INTEGER NOT NULL,
  Height INTEGER NOT NULL,
  ShapeId INTEGER NOT NULL
);

CREATE TABLE TankTankSize (
  TankId INTEGER NOT NULL,
  TankSizeId INTEGER NOT NULL
);

CREATE TABLE Login (
    Id SERIAL PRIMARY KEY,
    Login VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Enabled bit(1) NOT NULL DEFAULT '1'
);

CREATE TABLE ContactLogin (
    ContactId INTEGER NOT NULL,
    LoginId INTEGER NOT NULL
);

CREATE VIEW Alert AS
SELECT m.id, t.reference AS tankReference, m.level, m.time
FROM Measure m
INNER JOIN Tank t ON (t.id = m.id);

CREATE RULE Meausre_INSERT AS ON INSERT TO Alert DO INSTEAD
  INSERT INTO  Measure (tankId, level, time)
  VALUES ((select Id from Tank WHERE reference = NEW.tankReference), NEW.level, NEW.time)
  RETURNING Measure.id, (SELECT reference FROM Tank WHERE Id = Measure.tankId), Measure.level, Measure.time;


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
  ADD CONSTRAINT FK_Tank_Station FOREIGN KEY (StationId) REFERENCES Station (Id);

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