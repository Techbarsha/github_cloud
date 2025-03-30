# Configure Replication and Enable Point-in-Time-Recovery for Cloud SQL for PostgreSQL || [GSP922](https://www.cloudskillsboost.google/focuses/22795?parent=catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions:
### If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)

### 🔗Solution [here](https://youtu.be/uZRxcRcYQ5E)

### Run the following Commands in CloudShell

```
export PROJECT_ID=$(gcloud config get-value project)
export CLOUD_SQL_INSTANCE=postgres-orders
gcloud sql instances describe $CLOUD_SQL_INSTANCE

export BACKUP_TIME=$(date +"%R")

gcloud sql instances patch $CLOUD_SQL_INSTANCE \
    --backup-start-time=$BACKUP_TIME

  gcloud sql instances patch $CLOUD_SQL_INSTANCE \
     --enable-point-in-time-recovery \
     --retained-transaction-log-days=1

export TIMESTAMP=$(date --rfc-3339=seconds)

gcloud sql connect postgres-orders --user=postgres --quiet
```

* enter the below password when prompted. A psql session will start in Cloud Shell.

```
supersecret!
```
* In psql, change to the orders database:
```
\c orders
```
* When prompted, enter the password again.
```
supersecret!
```
```
SELECT COUNT(*) FROM distribution_centers;
```
```
INSERT INTO distribution_centers VALUES(-80.1918,25.7617,'Miami FL',11);
SELECT COUNT(*) FROM distribution_centers;
```
```
\q
```
```
curl -LO raw.githubusercontent.com/Techbarsha/shorttricks/refs/heads/main/gsp922.sh
sudo chmod +x *.sh

./*.sh
```
```
supersecret!
```
```
\c orders
```
```
supersecret!
```
```
SELECT COUNT(*) FROM distribution_centers;
```

