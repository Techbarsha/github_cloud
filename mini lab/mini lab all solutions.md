# mini lab all solutions || [LAB](https://www.cloudskillsboost.google/catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions:
### If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)

### Run the following Commands in CloudShell
- CLOUD STORAGE

## **mini lab : Cloud Storage : 1:**
### 🔗Solution [here](https://youtu.be/sx3KnHGDFPg)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab1.sh
sudo chmod +x minilab1.sh
./minilab1.sh
```

## **mini lab : Cloud Storage : 2:**
### 🔗Solution [here](https://youtu.be/sx3KnHGDFPg)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab2.sh
sudo chmod +x minilab2.sh
./minilab2.sh
```


## **mini lab : Cloud Storage : 4:**
### 🔗Solution [here](https://youtu.be/sx3KnHGDFPg)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab4.sh
sudo chmod +x minilab4.sh
./minilab4.sh
```

## **mini lab : Cloud Storage : 5:**
### 🔗Solution [here](https://youtu.be/sx3KnHGDFPg)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab5.sh
sudo chmod +x minilab5.sh
./minilab5.sh
```

- BIGQUERY
## **mini lab : BigQuery : 1:**
### 🔗Solution [here](https://youtu.be/cfr-5xoK1yw)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilabbq1.sh
sudo chmod +x minilabbq1.sh

./minilabbq1.sh
```

## **mini lab : BigQuery : 2:**
### 🔗Solution [here](https://youtu.be/sx3KnHGDFPg)



```
REGION=""
```
```
export PROJECT_ID=$(gcloud config get-value project)
bq mk --connection --connection_type='CLOUD_SPANNER' --properties='{"database":"projects/'$PROJECT_ID'/instances/ecommerce-instance/databases/ecommerce"}' --project_id=$PROJECT_ID --location=$REGION my_connection_id
bq query --use_legacy_sql=false "SELECT * FROM EXTERNAL_QUERY('$PROJECT_ID.$REGION.my_connection_id', 'SELECT * FROM orders;');"
bq query --use_legacy_sql=false "CREATE VIEW ecommerce.order_history AS SELECT * FROM EXTERNAL_QUERY('$PROJECT_ID.$REGION.my_connection_id', 'SELECT * FROM orders;');"
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
