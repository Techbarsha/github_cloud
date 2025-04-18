# Monitoring in Google Cloud: Challenge Lab || [ARC115](https://www.cloudskillsboost.google/focuses/63855?parent=catalog) ||

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

# Follow the instructions
## Solution [here](https://youtu.be/y4TOR3belTU)

### Run the following Commands in CloudShell

```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/Monitoring%20in%20Google%20Cloud/arc115.sh

sudo chmod +x arc115.sh

./arc115.sh
```

### NOW FOLLOW [VIDEO'S](https://youtu.be/cZJn_C_Ry4w) INSTRUCTIONS.

* Go to `Create Uptime Check` from [here](https://console.cloud.google.com/monitoring/uptime/create?)

1. For Title: enter `edutechlab`

* Go to `Dashboards` from [here](https://console.cloud.google.com/monitoring/dashboards?)

1. Add the first line chart that has a Resource metric filter, `CPU load (1m)`, for the VM.

2. Add a second line chart that has a Resource metric filter, `Requests`, for Apache Web Server.

* Go to `Create log-based metric` from [here](https://console.cloud.google.com/logs/metrics/edit?)

1. For Log-based metric name: enter `edutechlab`

2. Paste The Following in `Build filter` & Replace PROJECT_ID
```
resource.type="gce_instance"
logName="projects/PROJECT_ID/logs/apache-access"
textPayload:"200"
```

3. Paste The Following in `Regular Expression` field:
```
execution took (\d+)
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
