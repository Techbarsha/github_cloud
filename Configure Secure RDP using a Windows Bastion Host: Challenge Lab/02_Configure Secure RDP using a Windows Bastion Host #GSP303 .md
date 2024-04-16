# GSP303
>🚨 [PLEASE SUBSCRIBE OUR CHANNEL CLOUDHUSTLER](https://www.youtube.com/@cloudhustlers) **&** [JOIN OUR COMMUNITY](https://chat.whatsapp.com/KBfUcSleGGEFf2Xvvm8FW3)
## Run in Cloudshell
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
