import pandas as pd
from faker import Faker
import random

fake = Faker()

SPORTS = [
    'Soccer', 'Basketball', 'Tennis', 'Football', 'Baseball',
    'Golf', 'Volleyball'
]

city = "Seattle"
state = "WA"
zip_code = "98101"

# 1. Generate Venues
venues = pd.DataFrame([{
    # 'venue_id': i, 
    'name': f"Venue {i}",
    'address': f"{fake.street_address()}, {city}, {state} {zip_code}",
    'indoor': random.choice([0,1]),
    'accessible': random.choice([0,1]),
    'capacity': random.randint(500, 10000)} for i in range(1, 11)])

# 2. Generate Coaches 
coach_data = []
for i in range(1, 31):
    full_name = fake.name()
    clean_name = full_name.lower().replace(" ", ".")
    coach_email = f"{clean_name}@uw.edu"

    coach_row = {
        # 'coach_id': i,
        'name': full_name,
        'email': coach_email,
        'team_id': random.randint(1, 7),
        'role': random.choice(["Assistant Coach", "Specialized Coach", "Coach"]),
        'salary': random.randint(100000, 300000)
    }
    coach_data.append(coach_row)
coaches_df = pd.DataFrame(coach_data)

# 3. Generate Student Data
students_data = []

for i in range(1, 201):
    is_athlete = random.random() < 0.3
    tix_elig = random.random() > 0.05
    full_name = fake.name()
    clean_name = full_name.lower().replace(" ", ".")
    student_email = f"{clean_name}@uw.edu"

    gender = random.choice(["Male", "Female"])
    
    student_row = {
        # 'student_id': 1000 + i,
        'name': full_name,
        'academic_standing': random.choice(["Freshman", "Sophomore", "Junior", "Senior"]),
        'email': student_email,
        'gender': gender,
        'ticket_eligible': 1 if tix_elig else 0,

        # If they are an athlete
        # 'athlete_id': i if is_athlete else -1,
        'team_id': (random.choice([1,3,5,7,9,11,13]) if gender == "Male" else random.choice([2,4,6,8,10,12,14])) if is_athlete else -1,
        'number': random.randint(0,99) if is_athlete else -1,       
    }
    students_data.append(student_row)

student_df = pd.DataFrame(students_data)

#4 Events
start_time = random.randint(8, 18)
events = pd.DataFrame([{
    # 'event_id': i,
    'date': fake.date_between(start_date='today', end_date='+1y'),
    'venue_id': random.randint(1,5),
    'start_time': f"{start_time}:{random.randint(10,59)}",
    'end_time': f"{start_time + random.randint(1,5)}:{random.randint(10,59)}",
    'description': "Example description of an event."
} for i in range(1, 15)])

#5 Teams
SPORTS = [
    'Soccer', 'Soccer', 'Basketball', 'Basketball','Tennis', 'Tennis', 'Football', 'Football', 'Baseball', 'Softball',
    'Golf', 'Golf', 'Volleyball', 'Volleyball'
]

teams = []
for i in range(1,15):
    sport_row = {
        # 'team_id': i,
        'gender': "Male" if i%2 != 0 else "Female",
        'venue_id': random.randint(1,10),
        'sport': SPORTS[i-1]
    } 
    teams.append(sport_row)
teams_df = pd.DataFrame(teams)

#Junction table 1 - Team to Event 
team_event = pd.DataFrame([{
    'team_id': random.randint(1,14),
    'event_id': random.randint(1,14)
} for i in range(1, 15)])

# Junction table 2 - Student to Event
student_event = pd.DataFrame([{
    'student_id': random.randint(1,200),
    'event_id': random.randint(1,14)
} for i in range(1, 80)])

# Export to CSV
# student_df.to_csv('student_athletes.csv', index=False)
# coaches_df.to_csv('coaches.csv', index=False)
# venues.to_csv('venues.csv', index=False)
# events.to_csv('events.csv', index=False)
# teams_df.to_csv('teams.csv', index=False)
team_event.to_csv('team_event.csv', index=False)
student_event.to_csv('student_event.csv', index=False)