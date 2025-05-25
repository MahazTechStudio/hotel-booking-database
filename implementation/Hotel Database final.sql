SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS HotelOS;
CREATE DATABASE HotelOS;
USE HotelOS;

DROP TABLE IF EXISTS HotelOperatingCompany;
CREATE TABLE HotelOperatingCompany(
CompanyName VARCHAR(50)      NOT NULL,
UID         VARCHAR(50)      NOT NULL,
Email       VARCHAR(50)      NOT NULL,
Name_       VARCHAR(50)      NOT NULL,
--
PRIMARY KEY(CompanyName),
UNIQUE(UID)
);

DROP TABLE IF EXISTS Hotel;
CREATE TABLE Hotel(
HID            VARCHAR(15)   NOT NULL,
ContactEmail   VARCHAR(50)   NOT NULL,
StarRating     FLOAT      ,
ContactPhone    VARCHAR(20)   NOT NULL,
HotelName      VARCHAR(50)   NOT NULL,
Type_          VARCHAR(15)   NOT NULL,
AddressNum       INT   AUTO_INCREMENT  NOT NULL,
CompanyName    VARCHAR(50)   NOT NULL,
--
PRIMARY KEY(HID),
UNIQUE(ContactEmail),
UNIQUE(ContactPhone),

FOREIGN KEY(CompanyName) REFERENCES HotelOperatingCompany(CompanyName) ON DELETE CASCADE,
FOREIGN KEY(AddressNum) REFERENCES Address(AddressID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Address;
CREATE TABLE Address(
AddressID        INT   AUTO_INCREMENT  NOT NULL,
HID             VARCHAR(15)   NOT NULL,
Country         VARCHAR(15)   NOT NULL,
City            VARCHAR(15)   NOT NULL,
Street          VARCHAR(40)   NOT NULL,
--
PRIMARY KEY(AddressID),
FOREIGN KEY(HID) REFERENCES Hotel(HID) ON DELETE CASCADE

);


DROP TABLE IF EXISTS User_;
CREATE TABLE User_(
UID             VARCHAR(20)   NOT NULL,
Email           VARCHAR(100)   NOT NULL,
UName           VARCHAR(30)   NOT NULL,

--
FOREIGN KEY(UID) REFERENCES HotelOperatingCompany(UID) ON DELETE CASCADE,
UNIQUE(Uname),
UNIQUE(Email)
);

DROP TABLE IF EXISTS Room;
CREATE TABLE Room(
DailyPrice     DOUBLE        NOT NULL,
AreaID          INT  NOT NULL,
ViewID          VARCHAR(45),
AmenitiesID      VARCHAR(20),
RoomNumber     INT           NOT NULL,
HotelID      VARCHAR(15)   NOT NULL,
--
PRIMARY KEY(RoomNumber),
FOREIGN KEY(HotelID) REFERENCES Hotel(HID) ON DELETE CASCADE,
FOREIGN KEY(AmenitiesID) REFERENCES Amenities(AmenityNum) ON DELETE CASCADE
);


DROP TABLE IF EXISTS Amenities;
CREATE TABLE Amenities(
AmenityNum    VARCHAR(20),
RoomNumber    INT NOT NULL,
Amenity       VARCHAR(50) NOT NULL,
--
PRIMARY KEY(AmenityNum),
FOREIGN KEY(RoomNumber) REFERENCES Room(RoomNumber) ON DELETE CASCADE
);



DROP TABLE IF EXISTS View_;
CREATE TABLE View_(
ViewNum        INT   AUTO_INCREMENT  NOT NULL,
RoomNumber     INT           NOT NULL,
ViewType       TEXT,  
--
PRIMARY KEY(ViewNum),
FOREIGN KEY(RoomNumber) REFERENCES Room(RoomNumber) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Area;
CREATE TABLE Area(
AreaID         INT   AUTO_INCREMENT  NOT NULL,
RoomNumber     INT           NOT NULL,
AreaType       TEXT,  
Size           VARCHAR(100)  NOT NULL,
--
PRIMARY KEY(AreaID),
FOREIGN KEY(RoomNumber) REFERENCES Room(RoomNumber) ON DELETE CASCADE
);


DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer(
SSN             INT           NOT NULL,
Fname           VARCHAR(20)   NOT NULL,
Lname           VARCHAR(20)   NOT NULL,
Email           VARCHAR(100)   NOT NULL,
Gender          CHAR,
PhoneNumber     VARCHAR(20)   NOT NULL,
--
PRIMARY KEY(SSN),
UNIQUE(Email),
UNIQUE(PhoneNumber)
);

DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking(
BookingID       VARCHAR(45)   NOT NULL,
Payment         FLOAT         NOT NULL,
Check_IN        DATETIME      NOT NULL,
Check_OUT       DATETIME      NOT NULL,
RoomNum         INT           NOT NULL,
CustomerID      INT           NOT NULL,
HotelNum        VARCHAR(15)   NOT NULL,
ESSN            INT           NOT NULL,
--
PRIMARY KEY(BookingID),
UNIQUE(RoomNum),
FOREIGN KEY(HotelNum) REFERENCES Hotel(HID) ON DELETE CASCADE,
FOREIGN KEY(ESSN) REFERENCES Customer(SSN) ON DELETE CASCADE,
FOREIGN KEY(RoomNum) REFERENCES Room(RoomNumber) ON DELETE CASCADE
);



-- Insert data into HotelOperatingCompany
INSERT INTO HotelOperatingCompany (CompanyName, UID, Email, Name_) VALUES
('LuxuryStay', 'UID001', 'luxury@luxury.com', 'John Doe'),
('EliteHotels', 'UID002', 'elite@elite.com', 'Jane Smith'),
('ComfortInn', 'UID003', 'comfort@comfort.com', 'Alice Brown'),
('UrbanSuites', 'UID004', 'urban@urban.com', 'Robert Johnson'),
('ParadiseHotels', 'UID005', 'paradise@paradise.com', 'Emily Davis'),
('CozyHotels', 'UID006', 'cozy@cozy.com', 'Sophia Wilson'),
('OceanicResorts', 'UID007', 'oceanic@oceanic.com', 'James Miller'),
('SkylineHotels', 'UID008', 'skyline@skyline.com', 'Charlotte Taylor');

-- Insert data into Address
INSERT INTO Address (HID, Country, City, Street) VALUES
('HID001', 'UAE', 'Dubai', 'Palm Jumeirah St'),
('HID002', 'UAE', 'Sharjah', 'Al Majaz St'),
('HID003', 'UAE', 'Abu Dhabi', 'Corniche St'),
('HID004', 'UAE', 'Sharjah', 'University City Rd'),
('HID005', 'USA', 'New York', '5th Avenue'),
('HID006', 'UK', 'London', 'Oxford St'),
('HID007', 'UAE', 'Dubai', 'Sheikh Zayed Rd'),
('HID008', 'UAE', 'Sharjah', 'Al Buhaira St');

-- Insert data into Hotel
INSERT INTO Hotel (HID, ContactEmail, StarRating, ContactPhone, HotelName, Type_, AddressNum, CompanyName) VALUES
('HID001', 'palm@luxury.com', 5, '1234567890', 'Palm Paradise', 'Resort', 1, 'LuxuryStay'),
('HID002', 'elite1@elite.com', 4, '1234567891', 'Elite Sharjah', 'Hotel', 2, 'EliteHotels'),
('HID003', 'comfort1@comfort.com', 3.5, '1234567892', 'Comfort Corniche', 'Inn', 3, 'ComfortInn'),
('HID004', 'urban1@urban.com', 4.2, '1234567893', 'Urban Stay', 'Hotel', 4, 'UrbanSuites'),
('HID005', 'paradise1@paradise.com', 5, '1234567894', 'Paradise NYC', 'Resort', 5, 'ParadiseHotels'),
('HID006', 'cozy1@cozy.com', 3.8, '1234567895', 'Cozy Oxford', 'Hotel', 6, 'CozyHotels'),
('HID007', 'skyline1@skyline.com', 4.7, '1234567896', 'Skyline View', 'Hotel', 7, 'SkylineHotels'),
('HID008', 'elite2@elite.com', 4.5, '1234567897', 'Elite Al Buhaira', 'Hotel', 8, 'EliteHotels');

-- Insert data into User_
INSERT INTO User_ (UID, Email, UName) VALUES
('UID001', 'admin1@luxury.com', 'admin1'),
('UID002', 'admin2@elite.com', 'admin2'),
('UID003', 'admin3@comfort.com', 'admin3'),
('UID004', 'admin4@urban.com', 'admin4'),
('UID005', 'admin5@paradise.com', 'admin5'),
('UID006', 'admin6@cozy.com', 'admin6'),
('UID007', 'admin7@oceanic.com', 'admin7'),
('UID008', 'admin8@skyline.com', 'admin8');

-- Insert data into Room
INSERT INTO Room (DailyPrice, AreaID, ViewID, AmenitiesID, RoomNumber, HotelID) VALUES
(200, 1, 'V001', 'A001', 101, 'HID001'),
(150, 2, 'V002', 'A002', 102, 'HID002'),
(120, 3, 'V003', 'A003', 103, 'HID003'),
(180, 4, 'V004', 'A004', 104, 'HID004'),
(250, 5, 'V005', 'A005', 105, 'HID005'),
(100, 6, 'V006', 'A006', 106, 'HID006'),
(220, 7, 'V007', 'A007', 107, 'HID007'),
(190, 8, 'V008', 'A008', 108, 'HID008');

-- Insert data into Amenities
INSERT INTO Amenities (AmenityNum, RoomNumber, Amenity) VALUES
('A001', 101, 'Free WiFi'),
('A002', 102, 'Breakfast Included'),
('A003', 103, 'Gym Access'),
('A004', 104, 'Pool Access'),
('A005', 105, 'Ocean View'),
('A006', 106, 'Room Service'),
('A007', 107, 'Airport Shuttle'),
('A008', 108, 'Spa Access');

-- Insert data into View_
INSERT INTO View_ (ViewNum, RoomNumber, ViewType) VALUES
(1, 101, 'Sea View'),
(2, 102, 'City View'),
(3, 103, 'Garden View'),
(4, 104, 'Skyline View'),
(5, 105, 'Oceanfront View'),
(6, 106, 'Courtyard View'),
(7, 107, 'Mountain View'),
(8, 108, 'Lake View');

-- Insert data into Area
INSERT INTO Area (AreaID, RoomNumber, AreaType, Size) VALUES
(1, 101, 'Bedroom', '25 sqm'),
(2, 102, 'Bedroom', '20 sqm'),
(3, 103, 'Living Room', '30 sqm'),
(4, 104, 'Living Room', '35 sqm'),
(5, 105, 'Suite', '50 sqm'),
(6, 106, 'Standard', '15 sqm'),
(7, 107, 'Deluxe', '40 sqm'),
(8, 108, 'Executive', '45 sqm');

-- Insert data into Customer
INSERT INTO Customer (SSN, Fname, Lname, Email, Gender, PhoneNumber) VALUES
(123456789, 'Michael', 'Scott', 'michael@dundermifflin.com', 'M', '555-1111'),
(987654321, 'Dwight', 'Schrute', 'dwight@dundermifflin.com', 'M', '555-2222'),
(456789123, 'Jim', 'Halpert', 'jim@dundermifflin.com', 'M', '555-3333'),
(321654987, 'Pam', 'Beesly', 'pam@dundermifflin.com', 'F', '555-4444'),
(789123456, 'Stanley', 'Hudson', 'stanley@dundermifflin.com', 'M', '555-5555'),
(654321789, 'Angela', 'Martin', 'angela@dundermifflin.com', 'F', '555-6666'),
(147258369, 'Kevin', 'Malone', 'kevin@dundermifflin.com', 'M', '555-7777'),
(369258147, 'Oscar', 'Martinez', 'oscar@dundermifflin.com', 'M', '555-8888');


-- Insert data into Booking
INSERT INTO Booking (BookingID, Payment, Check_IN, Check_OUT, RoomNum, CustomerID, HotelNum, ESSN) VALUES
('B001', 400, '2024-11-01 14:00:00', '2024-11-05 12:00:00', 101, 123456789, 'HID001', 123456789),
('B002', 300, '2024-11-03 14:00:00', '2024-11-07 12:00:00', 102, 987654321, 'HID002', 987654321),
('B003', 360, '2024-11-02 14:00:00', '2024-11-06 12:00:00', 103, 456789123, 'HID003', 456789123),
('B004', 720, '2024-11-04 14:00:00', '2024-11-08 12:00:00', 104, 321654987, 'HID004', 321654987),
('B005', 1000, '2024-11-05 14:00:00', '2024-11-10 12:00:00', 105, 789123456, 'HID005', 789123456),
('B006', 200, '2024-11-06 14:00:00', '2024-11-09 12:00:00', 106, 123456789, 'HID006', 123456789),
('B007', 440, '2024-11-07 14:00:00', '2024-11-11 12:00:00', 107, 147258369, 'HID005', 147258369),
('B008', 600, '2024-11-08 14:00:00', '2024-11-12 12:00:00', 108, 123456789, 'HID008', 123456789),
('B009', 500, '2024-11-09 14:00:00', '2024-11-13 12:00:00', 109, 456789123, 'HID001', 456789123),
('B010', 150, '2024-11-10 14:00:00', '2024-11-12 12:00:00', 110, 123456789, 'HID002', 123456789);

-- Q6
-- a
SELECT CompanyName
FROM Hotel
GROUP BY CompanyName
HAVING COUNT(HID) >= 2;

-- b
SELECT HotelName
FROM Hotel
WHERE HID NOT IN (SELECT HotelNum FROM Booking);

-- c
SELECT C.Fname, C.Lname, C.Email
FROM Customer C
JOIN Booking B ON C.SSN = B.ESSN
GROUP BY C.SSN, C.Fname, C.Lname, C.Email
HAVING COUNT(DISTINCT B.HotelNum) >= 3;

-- d
SELECT DISTINCT H.CompanyName
FROM Hotel H
JOIN Address A ON H.AddressNum = A.AddressID
WHERE A.City = 'Sharjah';

-- e
SELECT ROUND(COUNT(*) / COUNT(DISTINCT ESSN), 2) AS AvgBookingsPerCustomer
FROM Booking;
