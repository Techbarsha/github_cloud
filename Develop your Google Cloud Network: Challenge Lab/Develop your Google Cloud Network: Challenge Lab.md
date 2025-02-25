# Develop your Google Cloud Network: Challenge Lab || [GSP321](https://www.cloudskillsboost.google/focuses/10603?parent=catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions:
### If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/rZAzHtk7-QU)

### Run the following Commands in CloudShell

```
export ZONE=
```
```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/Develop%20your%20Google%20Cloud%20Network%3A%20Challenge%20Lab/gsp321.sh
sudo chmod +x gsp321.sh

./gsp321.sh
```
## - *Task 8: Enable monitoring*

1. Go to [*Services and Ingress*](https://console.cloud.google.com/kubernetes/discovery)
2. Copy `endpoint's`(wordpress) `IP address`.
3. Then go to -> [Uptime Checks](https://console.cloud.google.com/monitoring/uptime) -> `+ CREATE UPTIME CHECK`. 
4. Fill in the details as provided below : 

* Hostname : `endpoint's IP address` (without http and port number)

* Path : `/`

* Title: `Wordpress Uptime`

5. Leave everything as default. Click `Next` -> `Next` -> `Create`


### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

# Thanks For Watching:)
