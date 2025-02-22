# mini lab : BigQuery : 3 || [LAB](https://www.cloudskillsboost.google/focuses/1774?parent=catalog) ||
---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/2MtpsN8tRvo)

### Run the following Commands in CloudShell

```
bq query --use_legacy_sql=false "
CREATE VIEW \`$(gcloud config get-value project).Inventory.Product_View\` AS
SELECT 
    p.product_name, 
    p.price
FROM 
    \`$(gcloud config get-value project).Inventory.products\` AS p
INNER JOIN 
    \`$(gcloud config get-value project).Inventory.category\` AS c
ON 
    p.category_id = c.category_id
WHERE 
    p.category_id = 1;"
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)

