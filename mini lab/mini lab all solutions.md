# Mini Lab All Solutions 2025 || [LAB](https://www.cloudskillsboost.google/catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions:
### If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)

### Run the following Commands in CloudShell

- CLOUD STORAGE

## **mini lab : Cloud Storage : 1:**
### 🔗Solution [here](https://youtu.be/WksrZODOlfI)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab1.sh
sudo chmod +x minilab1.sh
./minilab1.sh
```

## **mini lab : Cloud Storage : 2:**
### 🔗Solution [here](https://youtu.be/ZzCsDiFTsIA)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab2.sh
sudo chmod +x minilab2.sh
./minilab2.sh
```
## **mini lab : Cloud Storage : 3:**
### 🔗Solution [here](https://youtu.be/ZzCsDiFTsIA)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab3.sh
sudo chmod +x minilab3.sh
./minilab3.sh
```

## **mini lab : Cloud Storage : 4:**
### 🔗Solution [here](https://youtu.be/fMtpMeVaetU)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab4.sh
sudo chmod +x minilab4.sh
./minilab4.sh
```

## **mini lab : Cloud Storage : 5:**
### 🔗Solution [here](https://youtu.be/VzjmiWVPpVw)


```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab5.sh
sudo chmod +x minilab5.sh
./minilab5.sh
```
## **mini lab : Cloud Storage : 6:**
### 🔗Solution [here](https://youtu.be/VzjmiWVPpVw)


```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilab6.sh
sudo chmod +x minilab6.sh
./minilab6.sh
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
### 🔗Solution [here](https://youtu.be/gHiiZIO8ywg)
```
REGION=""
```
```
export PROJECT_ID=$(gcloud config get-value project)
bq mk --connection --connection_type='CLOUD_SPANNER' --properties='{"database":"projects/'$PROJECT_ID'/instances/ecommerce-instance/databases/ecommerce"}' --project_id=$PROJECT_ID --location=$REGION my_connection_id
bq query --use_legacy_sql=false "SELECT * FROM EXTERNAL_QUERY('$PROJECT_ID.$REGION.my_connection_id', 'SELECT * FROM orders;');"
bq query --use_legacy_sql=false "CREATE VIEW ecommerce.order_history AS SELECT * FROM EXTERNAL_QUERY('$PROJECT_ID.$REGION.my_connection_id', 'SELECT * FROM orders;');"
```

## **mini lab : BigQuery : 3:**
### 🔗Solution [here](https://youtu.be/cfr-5xoK1yw)



```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/refs/heads/main/mini%20lab/minilabbig3.sh
sudo chmod +x minilabbig3.sh

./minilabbig3.sh
```

## **mini lab : BigQuery : 4**
### 🔗Solution [here](https://youtu.be/6xrybo6mPOs)
```
export PROJECT_ID=$(gcloud config get-value project)
export REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])")

export BUCKET_NAME=

bq load --source_format=CSV --autodetect products.products_information gs://$BUCKET_NAME/products.csv 

bq query --use_legacy_sql=false "CREATE SEARCH INDEX IF NOT EXISTS products.p_i_search_index ON products.products_information (ALL COLUMNS);"

bq query --use_legacy_sql=false "SELECT * FROM products.products_information WHERE SEARCH(STRUCT(), '22 oz Water Bottle') = TRUE;"
```

## **mini lab : BigQuery : 5**
### 🔗Solution [here](https://youtu.be/6xrybo6mPOs)
```
PROJECT_ID=$(gcloud config get-value project)

bq load --autodetect --source_format=CSV customer_details.customers customers.csv

bq query --use_legacy_sql=false 'CREATE OR REPLACE TABLE customer_details.male_customers AS SELECT CustomerID, Gender FROM customer_details.customers WHERE Gender = "Male"'

bq extract --destination_format=CSV customer_details.male_customers gs://${PROJECT_ID}-bucket/exported_male_customers.csv
```

## **mini lab : BigQuery : 5**
### 🔗Solution [here](https://youtu.be/6xrybo6mPOs)
```
PROJECT_ID=$(gcloud config get-value project)
REGION="us"

gcloud iam service-accounts add-iam-policy-binding ${PROJECT_ID}@${PROJECT_ID}.iam.gserviceaccount.com \
--role='roles/iam.serviceAccountTokenCreator'

sleep 20

bq mk --transfer_config --project_id="${PROJECT_ID}" --target_dataset=ecommerce --display_name="Monthly Customer Orders Backup" --params='{"query":"SELECT * FROM `'${PROJECT_ID}'.ecommerce.customer_orders`", "destination_table_name_template":"backup_orders", "write_disposition":"WRITE_TRUNCATE"}' --data_source=scheduled_query --schedule="1 of month 00:00" --location="${REGION}"
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
