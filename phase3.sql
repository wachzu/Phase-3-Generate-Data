USE INFO_330_ZJA

-- Import all the csv files as staging files. 
-- The staging files are nameOfGroup_stg


DROP TABLE IF EXISTS Athlete
CREATE TABLE Athlete (
    AthleteID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StudentID INT NOT NULL, 
    StudentName VARCHAR(100) NOT NULL,
    TeamID INT NOT NULL, 
    JerseyNumber INT NOT NULL, 
    Sport VARCHAR(50) NOT NULL,
    Gender VARCHAR(50) NOT NULL
);
SELECT * FROM Athlete

DROP TABLE IF EXISTS Student
CREATE TABLE Student (
    StudentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    AcademicStanding VARCHAR(50) NOT NULL,
    TicketEligible BIT NOT NULL,
    Gender VARCHAR(50)
);
SELECT * FROM Student

DROP TABLE IF EXISTS AthleticEvent
CREATE TABLE AthleticEvent (
    EventID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    EventDescription VARCHAR(MAX) NULL, 
    EventDate DATE NOT NULL,
    EventStart TIME NOT NULL,
    EventEnd TIME NOT NULL,
    VenueID INT NOT NULL
)
SELECT * FROM AthleticEvent

DROP TABLE IF EXISTS Venue
CREATE TABLE Venue (
    VenueID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    VenueAddress VARCHAR(MAX) NOT NULL,
    Indoor BIT NOT NULL,
    Accessible BIT NOT NULL,
    Capacity INT NOT NULL,
    VenueName VARCHAR(MAX) NOT NULL
)
SELECT * FROM Venue

DROP TABLE IF EXISTS Coach
CREATE TABLE Coach (
    CoachID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CoachName VARCHAR(MAX) NOT NULL,
    CoachRole VARCHAR(50) NOT NULL,
    Sport VARCHAR(50) NOT NULL,
    TeamID INT NOT NULL
)
SELECT * FROM Coach

DROP TABLE IF EXISTS Team
CREATE TABLE Team (
    TeamID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Gender VARCHAR(50) NOT NULL,
    VenueID INT NOT NULL,
    Sport VARCHAR(50) NOT NULL
)
SELECT * FROM Team

DROP TABLE IF EXISTS StudentEvent
CREATE TABLE StudentEvent (
    StudentEventID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StudentID INT NOT NULL,
    AthleticEventID INT NOT NULL
)
SELECT * FROM StudentEvent

DROP TABLE IF EXISTS TeamEvent
CREATE TABLE TeamEvent (
    TeamEventID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TeamID INT NOT NULL,
    AthleticEventID INT NOT NULL
)
SELECT * FROM TeamEvent





-- Insert into Venue
INSERT INTO Venue (VenueName, VenueAddress, Indoor, Accessible, Capacity)
SELECT [name], [address], indoor, accessible, capacity
FROM venues_stg;

SELECT * FROM Venue

-- Insert into Team
INSERT INTO Team (Gender, VenueID, Sport)
SELECT gender, venue_id, sport
FROM teams_stg

SELECT * FROM Team

-- Insert into Students
INSERT INTO Student (StudentName, Email, AcademicStanding, TicketEligible, Gender)
SELECT [name], email, academic_standing, ticket_eligible, gender
FROM student_athletes_stg

SELECT * FROM Student

-- Insert into Coach
INSERT INTO Coach (CoachName, CoachRole, Sport, TeamID)
SELECT [name], [role], sport, team_id
FROM coaches_stg c JOIN Team t ON c.team_id = t.TeamID

SELECT * FROM Coach

-- Insert into event
INSERT INTO AthleticEvent (EventDescription, EventDate, EventStart, EventEnd, VenueID)
SELECT [description], [date], start_time, end_time, venue_id
FROM events_stg

SELECT * FROM AthleticEvent



-- Populate Athelete Table
INSERT INTO Athlete (StudentID, StudentName, TeamID, JerseyNumber, Sport, Gender)
SELECT s.StudentID, s.StudentName, sa.team_id, sa.number, t.Sport, s.Gender 
FROM student_athletes_stg sa
    JOIN Student s ON sa.name = s.StudentName 
    JOIN Team t ON t.TeamID = sa.team_id

SELECT * FROM Athlete

-- Populate StudentEvent table
INSERT INTO StudentEvent (StudentID, AthleticEventID)
SELECT se.student_id, se.event_id 
FROM student_event_stg se

SELECT * FROM StudentEvent

-- Insert TeamEvent table
INSERT INTO TeamEvent (TeamID, AthleticEventID)
SELECT t.team_id, event_id
FROM team_event_stg t

SELECT * FROM TeamEvent



-- Andrew's code
--add fks, the code should work but inserts are currently failing
alter table StudentEvent
    add constraint se_fk
    foreign key (StudentID) references Student(StudentID),
    foreign key (AthleticEventID) references AthleticEvent(AthleticEventID)

alter table Team
    add constraint team_fk
    foreign key (VenueID) references Venue(VenueID)

alter table TeamEvent
    add constraint te_FK
    foreign key (TeamID) references Team(TeamID),
    foreign key (AthleticEventID) references AthleticEvent(AthleticEventID)

alter table AthleticEvent
    add constraint ae_FK
    foreign key (VenueID) references Venue(VenueID)

alter table Coach
    add constraint c_FK
    foreign key (TeamID) references Team(TeamID)

alter table Athlete
    add constraint a_FK
    foreign key (StudentID) references Student(StudentID)