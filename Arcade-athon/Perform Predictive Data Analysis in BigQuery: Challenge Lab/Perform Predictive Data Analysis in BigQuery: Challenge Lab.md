# Perform Predictive Data Analysis in BigQuery: Challenge Lab || [GSP374](https://www.cloudskillsboost.google/focuses/37320?parent=catalog) ||
# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/B_yaZVAnMSA)

### Run the following Commands in CloudShell
```
export EVENT=
export TABLE=
export VALUE_X1=
export VALUE_Y1=
export VALUE_X2=
export VALUE_Y2=
export FUNC_1=
export FUNC_2=
export MODEL=
```
```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/main/Arcade-athon/Perform%20Predictive%20Data%20Analysis%20in%20BigQuery%3A%20Challenge%20Lab/gsp374.sh

sudo chmod +x gsp374.sh

./gsp374.sh
```

# Go to BigQuery from [here](https://console.cloud.google.com/bigquery)
```
CREATE FUNCTION `shot distance to goal`(x INT64, y INT64)
RETURNS FLOAT64
AS (
 /* Translate 0-100 (x,y) coordinate-based distances to absolute positions
 using "average" field dimensions of X-axis lengthxY-axis length before combining in 2D dist calc */
 SQRT(
   POW((X-axis goal mouth length - x) * X-axis length/100, 2) +
   POW((Y-axis goal mouth length - y) * Y-axis length/100, 2)
   )
 );
```
### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
