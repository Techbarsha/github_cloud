
# Dataflow: Qwik Start - Templates [GSP192](https://www.cloudskillsboost.google/focuses/1101?parent=catalog)

# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/iVChp5TlpCE)

### Run the following Commands in CloudShell

## Go to Task 4 to find region
* Copy Region

```
export REGION=
```
```
gcloud auth list
gcloud config list project
gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com
bq mk taxirides
bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime
gsutil mb gs://$DEVSHELL_PROJECT_ID/
sleep 45
```
```
gcloud dataflow jobs run iotflow \
    --gcs-location gs://dataflow-templates-us-east1/latest/PubSub_to_BigQuery \
    --region us-east1 \
    --worker-machine-type e2-medium \
    --staging-location gs://qwiklabs-gcp-04-3414bbfeff94/temp \
    --parameters inputTopic=projects/pubsub-public-data/topics/taxirides-realtime,outputTableSpec=qwiklabs-gcp-04-3414bbfeff94:taxirides.realtime
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)

