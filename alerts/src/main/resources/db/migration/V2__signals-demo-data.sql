
--- Customer 1

INSERT INTO ContactInfo (Email) VALUES
('mamadou.coulibaly@petrolium.com'),
('harouna.niang@petrolium.com');

INSERT INTO Contact (FirstName, LastName, ContactInfoId, ContactTypeId) VALUES
('Mamadou', 'Coulibaly', 1, 1),
('Harouna', 'Niang', 2, 1);

INSERT INTO Customer (Name) VALUES ('Petrolium Limited SA');
INSERT INTO CustomerContact VALUES (1,1),(1,2);
INSERT INTO Station (Name, Reference) VALUES ('Banankabougou', 'MLIBKOBNK000001');
INSERT INTO Station (Name, Reference) VALUES ('Badalabougou Sema I', 'MLIBKOBDG000002');
INSERT INTO CustomerStation VALUES (1,1), (1,2);

--- Customer 2

INSERT INTO ContactInfo (Email) VALUES
('fane.sacko@malioil.com'),
('pierre.grand@malioil.com');

INSERT INTO Contact (FirstName, LastName, ContactInfoId, ContactTypeId) VALUES
('Fane', 'Sacko', 3, 1),
('Pierre', 'Grand', 4, 1);

INSERT INTO Customer (Name) VALUES ('Mali Oil SARL');
INSERT INTO CustomerContact VALUES (2, 3), (2, 4);
INSERT INTO Station (Name, Reference) VALUES ('Korofina', 'MLIBKOKFN000001');
INSERT INTO Station (Name, Reference) VALUES ('Badalabougou Sema I', 'MLIBKOBDG000001');
INSERT INTO Station (Name, Reference) VALUES ('Quartier du fleuve', 'MLIBKOQDF000001');
INSERT INTO CustomerStation VALUES (2, 3), (2, 4), (2, 5);


INSERT INTO TankShape (Shape) VALUES ('cylinder');
INSERT INTO TankSize (Width, Height, ShapeId) VALUES (15, 35, 1);
INSERT INTO Login (Login, Password, Enabled) VALUES ('harouna.niang','dnaqr7AnyCW9mrq3iyNAcOcCdS9iW3UuVeVbSOYH41g=','1');
INSERT INTO Login (Login, Password, Enabled) VALUES ('admin','dnaqr7AnyCW9mrq3iyNAcOcCdS9iW3UuVeVbSOYH41g=','1');
INSERT INTO ContactLogin VALUES (2,1);
INSERT INTO ContactLogin VALUES (4,1);


INSERT INTO Tank (Name, Reference, StationId, WarningLevelPercentage, LiquidTypeId, LevelTypeId, Enabled) VALUES
--- Station Petrolium Limited SA - Banankabougou
('Cuve 1', 'A00000000000001', 1, 30, 1, 1, '1'),
('Cuve 2', 'A00000000000002', 1, 30, 2, 1, '1'),
('Cuve 3', 'A00000000000003', 1, 30, 2, 1, '1'),

--- Station Petrolium Limited SA - Badalabougou
('Cuve 1', 'A00000000000011', 2, 30, 1, 1, '1'),

--- Station Mali Oil SARL - Korofina
('Cuve 1', 'A00000000000004', 3, 30, 1, 1, '1'),

--- Station Mali Oil SARL - Badalabougou
('Cuve 1', 'A00000000000005', 4, 25, 2, 1, '1'),
('Cuve 2', 'A00000000000006', 4, 25, 2, 1, '1'),

('Cuve 3', 'A00000000000007', 4, 25, 1, 1, '1'),
('Cuve 4', 'A00000000000008', 4, 25, 1, 1, '1'),

--- Station Mali Oil SARL - Quartier du fleuve
('Cuve 5', 'A00000000000009', 5, 25, 2, 1, '1'),
('Cuve 6', 'A00000000000010', 5, 25, 1, 1, '1');

INSERT INTO StationTank VALUES
(1,1),
(1,2),
(1,3),
(2,4),
(3,5),
(3,6),
(3,7),
(3,8),
(4,9),
(4,10);

INSERt INTO TankTankSize VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1);


INSERT INTO TankMaximumCapacity (TankId, Volume) VALUES
(1, 25000),
(2, 25000),
(3, 25000),
(4, 25000),
(5, 25000),
(6, 25000),
(7, 25000),
(8, 25000),
(9, 25000),
(10, 25000);
