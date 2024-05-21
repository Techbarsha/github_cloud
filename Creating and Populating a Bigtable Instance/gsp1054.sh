gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com
export REGION=${ZONE%-*}
gcloud bigtable instances create personalized-sales \
            --display-name="Personalized Sales" \
            --cluster-config=id=personalized-sales-c1,zone=$ZONE
cbt -instance personalized-sales createtable UserSessions
cbt -instance personalized-sales createfamily UserSessions Interactions
cbt -instance personalized-sales createfamily UserSessions Sales
cbt -instance personalized-sales lookup UserSessions
gsutil mb gs://$DEVSHELL_PROJECT_ID/
