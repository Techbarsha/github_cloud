# Assessing Data Quality with Dataplex || [GSP1158](https://www.cloudskillsboost.google/focuses/67211?parent=catalog) ||
# Follow the instructions
---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/B_yaZVAnMSA)

### Run the following Commands in CloudShell
```
export REGION=
```
```
curl -LO raw.githubusercontent.com/QUICK-GCP-LAB/2-Minutes-Labs-Solutions/main/Assessing%20Data%20Quality%20with%20Dataplex/gsp1158.sh

sudo chmod +x gsp1158.sh

./gsp1158.sh
```
# Go to ``BigQuery`` from [Click here](https://console.cloud.google.com/projectselector2/bigquery?supportedpurview=project)

# In the *SQL Editor*, click on *Compose a new query*. Paste the following query, and then click *Run*: ( REPLACE PROJECT_ID WITH YOUR PROJECT )
```
  SELECT * FROM `PROJECT_ID.customers.contact_info`
  ORDER BY id
  LIMIT 50
```
# Go to Create task from [Click here](https://console.cloud.google.com/dataplex/process/create-task/data-quality)


### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
