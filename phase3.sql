USE INFO_330_ZJA

-- Import all the csv files as staging files. 
-- The staging files are nameOfGroup_stg


DROP TABLE IF EXISTS Athlete
CREATE TABLE Athlete (
    AthleteID INT IDENTITY(1,1) NOT NULL,
    StudentID INT NOT NULL, 
    TeamID INT NOT NULL, 
    JerseyNumber INT NOT NULL, 
    Sport VARCHAR(50) NOT NULL
    
    CONSTRAINT PK_Athlete PRIMARY KEY (AthleteID) 
);

DROP TABLE IF EXISTS Student
CREATE TABLE Student (
    StudentID INT IDENTITY(1,1) NOT NULL, 
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    AcademicStanding VARCHAR(50) NOT NULL,
    TicketEligible BIT NOT NULL,

    CONSTRAINT PK_Student PRIMARY KEY (StudentID) 
);

DROP TABLE IF EXISTS AthleticEvent
CREATE TABLE AthleticEvent (
    EventID INT IDENTITY(1,1) NOT NULL,
    EventDescription VARCHAR(MAX) NULL, 
    EventDate DATE NOT NULL,
    EventStart TIME NOT NULL,
    EventEnd TIME NOT NULL,
    VenueID INT NOT NULL

    CONSTRAINT PK_Event PRIMARY KEY (EventID)
)

DROP TABLE IF EXISTS Venue
CREATE TABLE Venue (
    VenueID INT IDENTITY(1,1) NOT NULL,
    VenueAddress VARCHAR(MAX) NOT NULL,
    Indoor BIT NOT NULL,
    Accessible BIT NOT NULL,
    Capacity INT NOT NULL,
    VenueName VARCHAR(MAX) NOT NULL

    CONSTRAINT PK_Venue PRIMARY KEY (VenueID)
)

DROP TABLE IF EXISTS Coach
CREATE TABLE Coach (
    CoachID INT IDENTITY(1,1) NOT NULL,
    CoachName VARCHAR(MAX) NOT NULL,
    CoachRole VARCHAR(50) NOT NULL,
    Sport VARCHAR(50) NOT NULL,
    TeamID INT NOT NULL

    CONSTRAINT PK_Coach PRIMARY KEY (CoachID)
)

DROP TABLE IF EXISTS Team
CREATE TABLE Team (
    TeamID INT IDENTITY(1,1) NOT NULL,
    Gender VARCHAR(50) NOT NULL,
    VenueID INT NOT NULL,
    Sport VARCHAR(50) NOT NULL

    CONSTRAINT PK_Team PRIMARY KEY (TeamID)
)

DROP TABLE IF EXISTS StudentEvent
CREATE TABLE StudentEvent (
    StudentEventID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StudentID INT NOT NULL,
    AthleticEventID INT NOT NULL
)

DROP TABLE IF EXISTS TeamEvent
CREATE TABLE TeamEvent (
    TeamEventID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TeamID INT NOT NULL,
    AthleticEventID INT NOT NULL
)