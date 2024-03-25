
# Using BigQuery and Cloud Logging to Analyze BigQuery Usage [GSP617]

# # If you consider that the video helped you to complete your lab, so please do like and subscribe. https://www.youtube.com/@edutechbarsha

```
bq mk bq_logs
bq query --use_legacy_sql=false "SELECT current_date()"
```
```
resource.type="bigquery_resource"
protoPayload.methodName="jobservice.jobcompleted"
```
# Create Sink name: JobComplete
```
curl -LO raw.githubusercontent.com/Techcps/GSP-Short-Trick/master/Using%20BigQuery%20and%20Cloud%20Logging%20to%20Analyze%20BigQuery%20Usage/techcps.sh
sudo chmod +x techcps.sh
./techcps.sh
```

## Congratulations, you're all done with the lab 😄

# Thanks for watching :)
