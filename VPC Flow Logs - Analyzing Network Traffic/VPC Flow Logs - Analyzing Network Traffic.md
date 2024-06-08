# VPC Flow Logs - Analyzing Network Traffic || [GSP212](https://www.cloudskillsboost.google/focuses/71931?parent=catalog) ||
# Follow the video and lab instructions step by step

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/2MtpsN8tRvo)

### Run the following Commands in CloudShell

```
export ZONE=
```
```
curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/main/VPC%20Flow%20Logs%20-%20Analyzing%20Network%20Traffic/gsp212.sh
sudo chmod +x gsp212.sh
./gsp212.sh
```
```
CP_IP=$(gcloud compute instances describe web-server --zone=$ZONE --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

export MY_SERVER=$CP_IP

for ((i=1;i<=50;i++)); do curl $MY_SERVER; done
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)

