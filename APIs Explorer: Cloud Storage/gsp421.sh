

gsutil mb gs://$DEVSHELL_PROJECT_ID

gsutil mb gs://$DEVSHELL_PROJECT_ID-2


curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/main/APIs%20Explorer%3A%20Cloud%20Storage/demo-image1.png

curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/main/APIs%20Explorer%3A%20Cloud%20Storage/demo-image2.png

curl -LO raw.githubusercontent.com/Techbarsha/github_cloud/main/APIs%20Explorer%3A%20Cloud%20Storage/demo-image1-copy.png


gsutil cp demo-image1.png gs://$DEVSHELL_PROJECT_ID/demo-image1.png

gsutil cp demo-image2.png gs://$DEVSHELL_PROJECT_ID/demo-image2.png

gsutil cp demo-image1-copy.png gs://$DEVSHELL_PROJECT_ID-2/demo-image1-copy.png
