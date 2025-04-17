-- Create the database
CREATE DATABASE IF NOT EXISTS PetPals;
USE PetPals;

-- Table: Pets
CREATE TABLE Pets (
    PetID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Breed VARCHAR(100),
    Type VARCHAR(50),
    AvailableForAdoption int
);

-- Table: Shelters
CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(200)
);

-- Table: Donations
CREATE TABLE Donations (
    DonationID INT PRIMARY KEY,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10, 2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME
);

-- Table: AdoptionEvents
CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(200)
);

-- Table: Participants
CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

INSERT INTO Shelters (Name, Location) VALUES
('Happy Tails Shelter', 'Chennai'),
('Paw Paradise', 'Coimbatore'),
('Animal Haven', 'Madurai'),
('Furry Friends Home', 'Salem'),
('Safe Paws Shelter', 'Tiruchirappalli'),
('Care4Animals', 'Erode'),
('PetJoy Home', 'Vellore'),
('Angels for Paws', 'Tirunelveli'),
('Pawsitive Shelter', 'Thanjavur'),
('Heart for Paws', 'Chengalpattu');

INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption, ShelterID) VALUES
('Buddy', 3, 'Labrador Retriever', 'Dog', 1, 1),
('Mittens', 2, 'Persian', 'Cat', 1, 2),
('Rocky', 5, 'German Shepherd', 'Dog', 0, 3),
('Luna', 1, 'Siamese', 'Cat', 1, 4),
('Charlie', 6, 'Golden Retriever', 'Dog', 1, 5),
('Milo', 4, 'Beagle', 'Dog', 0, 6),
('Daisy', 2, 'Bulldog', 'Dog', 1, 7),
('Simba', 3, 'Bengal', 'Cat', 1, 8),
('Max', 7, 'Pug', 'Dog', 0, 9),
('Coco', 1, 'Himalayan', 'Cat', 1, 10);

INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID) VALUES
('nirosha', 'Cash', 5000.00, NULL, '2025-03-01 10:00:00', 1),
('indhu', 'Item', NULL, 'Dog Food', '2025-03-05 11:30:00', 2),
('shamitha', 'Cash', 2500.00, NULL, '2025-03-10 09:45:00', 3),
('hari', 'Item', NULL, 'Blankets', '2025-03-15 14:00:00', 4),
('sri', 'Cash', 7000.00, NULL, '2025-03-20 16:15:00', 5),
('dhivya', 'Item', NULL, 'Cat Toys', '2025-03-22 17:45:00', 6),
('sathish', 'Cash', 10000.00, NULL, '2025-03-25 12:30:00', 7),
('rubi', 'Item', NULL, 'Pet Shampoo', '2025-03-28 15:10:00', 8),
('Vikram', 'Cash', 3000.00, NULL, '2025-03-29 18:20:00', 9),
('Pooja', 'Cash', 4000.00, NULL, '2025-03-30 13:00:00', 10);

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES
('Adopt-a-Pet Fair', '2025-04-10 10:00:00', 'Chennai'),
('Furry Friends Meet', '2025-04-12 11:00:00', 'Coimbatore'),
('Home for Paws', '2025-04-15 12:00:00', 'Madurai'),
('Paws and Play', '2025-04-18 10:30:00', 'Salem'),
('Adoption Awareness Day', '2025-04-20 09:00:00', 'Tiruchirappalli'),
('Pet Fest', '2025-04-22 10:45:00', 'Erode'),
('Joy of Adoption', '2025-04-24 11:15:00', 'Vellore'),
('Animal Love Day', '2025-04-26 10:30:00', 'Tirunelveli'),
('Care & Adopt', '2025-04-28 09:45:00', 'Thanjavur'),
('Forever Friends Event', '2025-04-30 14:00:00', 'Chengalpattu');

INSERT INTO Participants (ParticipantName, ParticipantType, EventID) VALUES
('Happy Tails Shelter', 'Shelter', 1),
('Paw Paradise', 'Shelter', 2),
('Animal Haven', 'Shelter', 3),
('John Doe', 'Adopter', 1),
('Riya Mehra', 'Adopter', 2),
('Care4Animals', 'Shelter', 6),
('Furry Friends Home', 'Shelter', 4),
('Siddharth Singh', 'Adopter', 3),
('Safe Paws Shelter', 'Shelter', 5),
('Neha Kapoor', 'Adopter', 5);

select * from Shelters;
select * from Pets;
select * from Donations;
select * from AdoptionEvents;
select * from Participants;

-- 5.Available pets for adoption
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;

-- 6.Participants for specific event
SELECT ParticipantName, ParticipantType
FROM Participants
WHERE EventID = 6;  

-- 7.Stored Procedure to Update Shelter Info
UPDATE Shelters
SET Name = 'New Shelter Name',
    Location = 'New Location Address'
WHERE ShelterID = 2;
select * from Shelters;
UPDATE Shelters
SET Name = 'Paw Paradise',
    Location = 'Coimbatore'
WHERE ShelterID = 2;


-- 8.Total Donations per Shelter
SELECT 
    s.Name AS ShelterName,
    SUM(d.DonationAmount) AS TotalDonations
FROM 
    Shelters s
LEFT JOIN 
    Donations d ON s.ShelterID = d.ShelterID
GROUP BY 
    s.ShelterID;


-- 9.Pets without Owners (Assuming OwnerID Column Exists)
ALTER TABLE Pets DROP COLUMN OwnerID;
ALTER TABLE Pets ADD COLUMN OwnerID INT NULL;
SELECT Name, Age, Breed, Type
FROM Pets
WHERE OwnerID IS NULL;
select * from Pets;

-- 10.Total Donation by Month & Year
SELECT DATE_FORMAT(DonationDate, '%M %Y') AS MonthYear,
       SUM(DonationAmount) AS TotalDonation
FROM Donations
GROUP BY DATE_FORMAT(DonationDate, '%M %Y');

-- 11.Distinct Breeds for Specific Ages
SELECT DISTINCT Breed
FROM Pets
WHERE (Age BETWEEN 1 AND 3) OR Age > 5;

-- 12.Available Pets and Their Shelters
SELECT p.Name AS PetName, s.Name AS ShelterName
FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 1;
select * from Pets;
select * from Shelters;

-- 13.Total Participants in Events by City
SELECT COUNT(DISTINCT p.ParticipantID) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents e ON p.EventID = e.EventID
WHERE e.Location = 'Chennai';
select * from Participants;
select * from Pets;
select * from AdoptionEvents;

-- 14.Unique Breeds (Pets aged 1–5)
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;
select * from Pets;

-- 15.Pets Not Yet Adopted (Assuming Adoption table exists)
SELECT Name, Age, Breed, Type
FROM Pets
WHERE OwnerID IS NULL;
select * from Pets;


-- 16.Adopted Pets and Adopters (Assuming Adoption & User Tables)
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);
CREATE TABLE Adoption (
    AdoptionID INT PRIMARY KEY AUTO_INCREMENT,
    PetID INT,
    UserID INT,
    AdoptionDate DATE,
    FOREIGN KEY (PetID) REFERENCES Pets(PetID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- Users (Adopters)
INSERT INTO Users (Name) VALUES 
('Nirosha'), 
('Indhu'), 
('Shamitha');

-- Adoption Records
INSERT INTO Adoption (PetID, UserID, AdoptionDate) VALUES
(1, 1, '2025-04-01'), -- Buddy adopted by Nirosha
(4, 2, '2025-04-03'), -- Luna adopted by Indhu
(10, 3, '2025-04-05'); -- Coco adopted by Shamitha

SELECT p.Name AS PetName, u.Name AS AdopterName
FROM Adoption a
JOIN Pets p ON a.PetID = p.PetID
JOIN Users u ON a.UserID = u.UserID;
select * from Pets;

-- 17.Count of Available Pets per Shelter
SELECT 
    s.Name AS ShelterName, 
    COUNT(p.PetID) AS AvailablePets
FROM 
    Shelters s
LEFT JOIN 
    Pets p ON s.ShelterID = p.ShelterID AND p.AvailableForAdoption = 1
GROUP BY 
    s.ShelterID, s.Name;
select * from Shelters;
select * from Pets;

-- 18.Pets with Same Breed from Same Shelter
SELECT distinct
    p1.Name AS Pet1, 
    p2.Name AS Pet2, 
    p1.Breed, 
    s.Name AS Shelter
FROM Pets p1
JOIN Pets p2 
    ON p1.ShelterID = p2.ShelterID 
    AND p1.Breed = p2.Breed 
    AND p1.PetID < p2.PetID
JOIN 
    Shelters s 
    ON p1.ShelterID = s.ShelterID;


-- 19.All Possible Shelter–Event Combinations
SELECT s.Name AS Shelter, e.EventName
FROM Shelters s
CROSS JOIN AdoptionEvents e;

-- 20. Shelter with Highest Number of Adoptions
SELECT s.Name, COUNT(*) AS TotalAdoptions
FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 0
GROUP BY s.ShelterID
ORDER BY TotalAdoptions DESC
LIMIT 1;







