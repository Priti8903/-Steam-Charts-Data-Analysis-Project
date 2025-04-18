# -Steam-Charts-Data-Analysis-Project
📌 Project Overview
This project demonstrates a comprehensive data analysis workflow, encompassing data extraction, transformation, storage, and visualization. 
The primary objective is to analyze the top 175 games from (https://steamcharts.com/top) by scraping relevant data and presenting insights through an interactive Power BI dashboard.

🛠️ Tools & Technologies
Python: Utilized for web scraping and data preprocessing.

MySQL: Employed for structured data storage and management.

Power BI: Used to create dynamic and interactive visualizations.

📊 Data Collection & Processing
Data Source: SteamCharts, a platform providing real-time statistics on Steam games.

Scraping Methodology:

Extracted data from the top 7 pages, each containing 25 entries, totaling 175 game records.

Captured the following fields:

Rank

Game Name

Current Players

Peak Players

Hours Played


<pre> ```from bs4 import BeautifulSoup
import pandas as pd
import mysql.connector
from sqlalchemy import create_engine
import requests

game_names = []
current_players = []
peak_players = []
hours_played = []


for page in range(1, 8):
    if page == 1:
        url = "https://steamcharts.com/top"
    else:
        url = f"https://steamcharts.com/top/p.{page}" `

    response = requests.get(url, headers={"User-Agent": "Mozilla/5.0"})
    soup = BeautifulSoup(response.text, 'html.parser')

    table = soup.find("table", {"id": "top-games"})
    if table:
        rows = table.tbody.find_all("tr")
        for row in rows:
            cols = row.find_all("td")
            if len(cols) >= 6:
                game_name = cols[1].find('a').text.strip()
                current = cols[2].text.strip().replace(',', '')
                peak = cols[4].text.strip().replace(',', '')
                hours = cols[5].text.strip()

                game_names.append(game_name)
                current_players.append(int(current))
                peak_players.append(int(peak))
                hours_played.append(hours)
    else:
        print(f"Table not found on page {page}") `

Create DataFrame
df = pd.DataFrame({
    "Game Name": game_names,
    "Current Players": current_players,
    "Peak Players": peak_players,
    "Hours Played": hours_played
})

 Sort by Peak Players and reindex from 1
df_sorted = df.sort_values(by="Current Players", ascending=False).reset_index(drop=True)
df_sorted.index = range(1, len(df_sorted) + 1)
df_sorted.index.name = 'Rank'


print(df)
 Show first few rows
print(df_sorted.head())

 Save to CSV
df_sorted.to_csv("Top 100 games_2025", index=True)

insert into mysql 
engine=create_engine("mysql+mysqlconnector://root:1234@127.0.0.1:3306/Game_DB")

df.to_sql(name='Top_100_games_2025', con=engine, if_exists='append', index=False)

print("✅ Data inserted into MySQL successfully.")```<pre> 


Data Cleaning:

Removed commas from numerical fields to ensure correct data types.

Converted string representations of numbers to appropriate numeric types.

Handled missing or inconsistent data entries.

🗄️ Database Design
Database: Game_DB

Table: Top_100_games_2025

Schema:`CREATE TABLE Top_100_games_2025 (
    Rank INT NOT NULL AUTO_INCREMENT,
    Game_Name VARCHAR(300) NOT NULL,
    Current_Players INT,
    Peak_Players INT,
    Hours_Played INT,
    PRIMARY KEY (Rank)
);

Data Insertion:

Established a connection between Python and MySQL using mysql.connector and SQLAlchemy.

Inserted the cleaned DataFrame into the MySQL table.​

​
📈 Data Visualization with Power BI
Data Import:

Connected Power BI to the MySQL Game_DB database.

Imported the Top_100_games_2025 table for analysis.

Dashboard Features:

Cards:

Total Games

Total Peak Players

Current Players

Slicer:

Game Name

Bar Charts:

Top 10 Games by Peak Players

Top 10 Games by Current Players

Game Ranking by Popularity

📁 Repository Structure
Best_selling_game_of_all_time.ipynb – Jupyter Notebook for data extraction and cleaning.

Top_100_games_2025.csv – CSV file containing the cleaned dataset.

Top_100_games_2025.sql – SQL script to create the database and table.

Top_games_report.pbix – Power BI dashboard file.

README.md – Project documentation.

📁 Clone the Repository

`git clone https://github.com/yourusername/-Steam-Charts-Data-Analysis-Project.git
cd -Steam-Charts-Data-Analysis-Project
`
💻 Set Up the Environment
Ensure you have Python 3.x installed.

Then, install the required libraries:
`pip install -r requirements.txt
`
🐍 Run the Scraper
Execute the Python script (or Jupyter Notebook) to scrape and clean the data:
`jupyter notebook Best_selling_game_of_all_time.ipynb`

Import Data into MySQL:

Execute Top_100_games_2025.sql to create the database and table.

Use the Python script or a MySQL client to insert data from the CSV.​

Visualize with Power BI:

Open Top_games_report.pbix in Power BI Desktop.

Ensure the data source is correctly connected to your MySQL database.

Refresh the data to view the latest insights.​
GitHub

📌 Conclusion
This project exemplifies the integration of web scraping, data cleaning, database management, and data visualization to derive meaningful insights from real-time gaming data. It serves as a testament to the power of combining multiple tools and technologies in the realm of data analysis.​






