
INSERT INTO LiquidType (Reference) VALUES ('OIL');
INSERT INTO ContactInfo (Email) VALUES
('mamadou.coulibaly@petrolium.com'),
('harouna.niang@petrolium.com');
INSERT INTO ContactType (Type) VALUES
('Owner'),
('Manager');
INSERT INTO Contact (FirstName, LastName, ContactInfoId, ContactTypeId) VALUES
('Mamadou', 'Coulibaly', 1, 1),
('Harouna', 'Niang', 2, 1);
INSERT INTO Customer (Name) VALUES ('Petrolium Limited SA');
INSERT INTO CustomerContact VALUES (1,1),(1,2);
INSERT INTO Station (Name, Reference) VALUES ('Banankabougou', 'MLIBKOBNK000001');
INSERT INTO CustomerStation VALUES (1,1);


INSERT INTO TankShape (Shape) VALUES ('cylinder');
INSERT INTO TankSize (Width, Height, ShapeId) VALUES (15, 35, 1);



INSERT INTO Tank (Name, Reference, StationId, WarningLevelPercentage, LiquidTypeId, Enabled) VALUES
('Cuve Essence 1', 'A00000000000001', 1, 30, 1, '1');
INSERt INTO TankTankSize VALUES (1,1)
