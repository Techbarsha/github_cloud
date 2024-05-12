# Creating a Data Transformation Pipeline with Cloud Dataprep || [GSP430](https://www.cloudskillsboost.google/focuses/4415?parent=catalog) ||

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/mrJHiMwd5IE)

### Run the following Commands in CloudShell
```cmd
bq mk ecommerce
bq query --use_legacy_sql=false \
'#standardSQL
 CREATE OR REPLACE TABLE ecommerce.all_sessions_raw_dataprep
 OPTIONS(
   description="Raw data from analyst team to ingest into Cloud Dataprep"
 ) AS
 SELECT * FROM `data-to-insights.ecommerce.all_sessions_raw`
 WHERE date = "20170801";'
wget https://github.com/CodingWithHardik/files/raw/master/flow_Ecommerce_Analytics_Pipeline.zip
cloudshell download flow_Ecommerce_Analytics_Pipeline.zip
```
____
### Dataprep > Accept all conditions > flow > import flow > select the file 
### Remove first file from flow > Click + > import dataset > Bigquery > ecommerce > click + > import & add to flow > select
### Output > Run > Edit > Bigquery > GCP id > ecommerce > create new table > update > Run
____

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)

