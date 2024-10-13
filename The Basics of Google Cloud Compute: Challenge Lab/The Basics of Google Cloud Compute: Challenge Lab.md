# The Basics of Google Cloud Compute: Challenge Lab || [ARC120](https://www.cloudskillsboost.google/focuses/65384?parent=catalog) ||
---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---

# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/B_yaZVAnMSA)
## TASK 2:- 
### Run the following Commands in CloudShell
```
export ZONE=


gcloud compute instances create my-instance --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --tags=http-server --create-disk=auto-delete=yes,boot=yes,device-name=my-instance,image=projects/debian-cloud/global/images/debian-11-bullseye-v20230509,mode=rw,size=10,type=projects/$DEVSHELL_PROJECT_ID/zones/$ZONE/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any


gcloud compute disks create mydisk --size=200GB \
--zone=$ZONE

gcloud compute instances attach-disk my-instance --disk mydisk --zone=$ZONE

```
## TASK 3:-
```
gcloud compute ssh my-instance --zone=$ZONE
```
```
sudo apt-get update

sudo apt-get install -y nginx

ps auwx | grep nginx
```
### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
