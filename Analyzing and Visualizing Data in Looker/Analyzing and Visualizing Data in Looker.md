# Getting Started with Analyzing and Visualizing Data in Looker|| [LAB](https://www.cloudskillsboost.google/focuses/25305?parent=catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
<div align="center" style="padding: 5px;">
  <h3>📱 Join the EduTech Barsha Community</h3>
  
  <a href="https://whatsapp.com/channel/0029Va5J2r5Jf05cKT1pZh31">
    <img src="https://img.shields.io/badge/Join_WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="Join WhatsApp">
  </a>
  &nbsp;
  <a href="https://t.me/edutechbarsha">
    <img src="https://img.shields.io/badge/Join_Telegram-229ED9?style=for-the-badge&logo=telegram&logoColor=white" alt="Join Telegram">
  </a>
  &nbsp;
  <a href="https://www.youtube.com/@edutechbarsha?sub_confirmation=1">
    <img src="https://img.shields.io/badge/Subscribe-EduTech%20Barsha-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube Channel">
  </a>
</div>

# Follow the instructions:
### 🔗Solution [here](https://youtu.be/qmEAyQ4pluI)

## Task 1: Single Value Visualization:
```
explore: +airports { 
    query: Eduetchbarsha_Task1 {
      measures: [average_elevation]
    }
  }
```

- **Explore** → **FAA** → **Airports**
- Customize Visualization:
  - Select **Single Value**
  - Set **Value Format**: `0.00`
  - Modify **Value Color** and **Title** -> `Average Elevation`
- Save to **New Dashboard** → **``Airports``**

## Task 2: Bar Chart (`Average Elevation by Facility Type`)
```
explore: +airports {
    query: Eduetchbarsha_Task2 {
      dimensions: [facility_type]
      measures: [average_elevation, count]
  }
}
```

- **Explore** → **FAA** → **Airports**
- Set **Row Limit**: `5`
- Customize Visualization:
  - Select **Bar Chart**
  - Enable **Value Labels**
  - Rename **Axes** and set **Value Format**: `0.00`
- Save to **Existing Dashboard** → **``Airports``**

## Task 3: Line Chart (`Number of Flights Cancelled Each Week in 2004`)
```
explore: +flights {
    query: Eduetchbarsha_Task3 {
      dimensions: [depart_week]
      measures: [cancelled_count]
      filters: [flights.depart_date: "2004"]
  }
}
```

- **Explore** → **FAA** → **Flights**
- Customize Visualization:
  - Select **Line Chart**
  - Set **Filled Point Style**
  - Add **Reference Line**
- Save to **New Dashboard** → **``Airports and Flights``**

## Task 4: Line Chart (`Number of Flights by Distance Tier in 2003`)
```
explore: +flights {
    query: Eduetchbarsha_Task4 {
      dimensions: [depart_week, distance_tiered]
      measures: [count]
      filters: [flights.depart_date: "2003"]
  }
}
```

- **Explore** → **FAA** → **Flights**
- Customize Visualization:
  - Select **Stacked Line Chart**
  - Enable **Overlay Series Positioning**
- Save to **Existing Dashboard** → **``Airports and Flights``**
  

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)


