USE INFO_330_ZJA

-- Zach's Code

-- Query #1 - Query to find coach salary per seat
-- This is a financial investment vs venue size query. I looked at each 
-- of the teams, calculated how much the coaches earned and calculated the
-- coach earnings per seat in a venue.
SELECT t.Sport, t.Gender, COUNT(DISTINCT c.CoachID) AS total_coaches,
    SUM(c.Salary) AS total_salary,
    MAX(v.capacity) AS venue_capacity,
    ROUND(SUM(c.salary) / CAST(MAX(v.capacity) AS FLOAT), 2) AS dollars_per_seat
FROM Team t
    JOIN Coach c on c.TeamID = t.TeamID
    JOIN Venue v on v.VenueID = t.TeamID
GROUP BY t.Sport, t.Gender
ORDER BY dollars_per_seat DESC;
-- From the results, I found that male's tennis and women's soccer had the 
-- highest price per seat (this is fake data we generated using python). 
-- This could help the theoretical university by helping them reallocate funding
-- to different sports.


-- Query #2 - Team broken down by academic standing
WITH TeamRoster AS (
    -- This CTE prepares the data by joining and filtering in one place
    SELECT 
        t.sport AS Sport,
        s.AcademicStanding
    FROM Athlete a
    INNER JOIN Student s ON a.StudentID = s.StudentID
    INNER JOIN Team t ON a.TeamID = t.TeamID
    WHERE a.AthleteID != -1
)
SELECT
    Sport,
    COUNT(CASE WHEN AcademicStanding = 'Freshman' THEN 1 END) AS Freshmen,
    COUNT(CASE WHEN AcademicStanding = 'Sophomore' THEN 1 END) AS Sophomores,
    COUNT(CASE WHEN AcademicStanding = 'Junior' THEN 1 END) AS Juniors,
    COUNT(CASE WHEN AcademicStanding = 'Senior' THEN 1 END) AS Seniors,
    COUNT(*) AS Total_Athletes
FROM TeamRoster
GROUP BY Sport
ORDER BY Total_Athletes DESC;


