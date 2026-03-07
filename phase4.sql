USE INFO_330_ZJA

-- Zach's Code
-- This is a financial investment vs venue size query. I looked at each 
-- of the teams, calculated how much the coaches earned and then compared
-- that to venue size
SELECT salary
FROM Team t
    JOIN Coach c on c.TeamID = t.TeamID
    JOIN Venue v on v.VenueID = t.TeamID