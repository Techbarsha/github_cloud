# Configure Secure RDP using a Windows Bastion Host: Challenge Lab || [GSP303](https://www.cloudskillsboost.google/focuses/1737?parent=catalog) ||

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/_brPr24pxP0)

### Run the following Commands in CloudShell

## EXPORT "ZONE"
```cmd
export ZONE=
```
```cmd
export REGION=${ZONE%-*}
gcloud compute networks create securenetwork --subnet-mode custom
gcloud compute networks subnets create securenetwork-subnet --network=securenetwork --region $REGION --range=192.168.16.0/20
gcloud compute firewall-rules create rdp-ingress-fw-rule --allow=tcp:3389 --source-ranges 0.0.0.0/0 --target-tags allow-rdp-traffic --network securenetwork
gcloud compute instances create vm-bastionhost --zone=$ZONE --machine-type=e2-medium --network-interface=subnet=securenetwork-subnet --network-interface=subnet=default,no-address --tags=allow-rdp-traffic --image=projects/windows-cloud/global/images/windows-server-2016-dc-v20220513
gcloud compute instances create vm-securehost --zone=$ZONE --machine-type=e2-medium --network-interface=subnet=securenetwork-subnet,no-address --network-interface=subnet=default,no-address --tags=allow-rdp-traffic --image=projects/windows-cloud/global/images/windows-server-2016-dc-v20220513
```
### Check the progress till task 5 
### Go to the lab and check if green tick came beside it or not.

##

##

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
