# Ingesting FHIR Data with the Healthcare API || [GSP457](https://www.cloudskillsboost.google/focuses/1073?parent=catalog) ||
# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/markO68BtxM)

### Run the following Commands in CloudShell
### First, exports all the values from task 1 as showed.
```
curl -LO raw.githubusercontent.com/quiccklabs/Labs_solutions/master/Ingesting%20FHIR%20Data%20with%20the%20Healthcare%20API/quicklabgsp457.sh

sudo chmod +x quicklabgsp457.sh

./quicklabgsp457.sh
```
### FHIR Data De-identification and Export to BigQuery
▶️ FHIR Data De-identification
### 1. Click the Actions button for ```fhirstore1```

### 2. From the dropdown, select ```De-identify```

### 3. Select ```dataset1``` as the dataset and ```de_id``` as the destination data store.

### 4. Click Append for the pop-up.

### 5. Click Next.

### 6. Click ```De-identify```

### 7. You can view progress in the Operations tab in the Console.

### 8. Click on the Data Stores tab to view the datastores again once the operation is complete.

### ⏳ Wait for this operation to complete before moving to the next step.
### 💫 FHIR Bulk Export
### Using Cloud Shell, bulk export the FHIR data in de_id to the second BigQuery dataset created earlier.

### Before running, ensure that the previous bulk export has completed.

```
gcloud healthcare fhir-stores export bq de_id \
  --dataset=$DATASET_ID \
  --location=$LOCATION \
  --bq-dataset=bq://$PROJECT_ID.de_id \
  --schema-type=analytics
```
### 🔍 Exploring Data in BigQuery
### ✔ In the Cloud Console, use the Navigation menu to open BigQuery.

### ✔ In the left pane, under Resources, select your ```Project ID``` and expand the drop-down. You should see the two recently created datasets named ```dataset1``` and ```de_id```

### ✔ Select ```dataset1``` and expand the drop-down.

### ✔ Navigate to the ```Patient``` table and preview the Schema.

### ✔ Click the ```+ icon``` to open a new Query Editor tab, then add the following SQL command to view patient data exported from the FHIR stores:
```
SELECT
  id AS patient_id,
  name[safe_offset(0)].given AS given_name,
  name[safe_offset(0)].family AS family,
  birthDate AS birth_date
FROM dataset1.Patient
LIMIT 10;
```
### ✔ Run the query to see the results.

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
