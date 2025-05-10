# Using Custom Fields in Looker Explores || [GSP983](https://www.cloudskillsboost.google/focuses/22212?parent=catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
<div align="center" style="padding: 5px;">
  <h3>📱 Join the EduTech Barsha Community</h3>
  
  <a href="https://whatsapp.com/channel/0029Va5J2r5Jf05cKT1pZh31">
    <img src="https://img.shields.io/badge/Join_WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="Join WhatsApp">
  </a>
  &nbsp;
  <a href="https://t.me/edutechbarsha">
    <img src="https://img.shields.io/badge/Join_Telegram-229ED9?style=for-the-badge&logo=telegram&logoColor=white" alt="Join Telegram">
  </a>
  &nbsp;
  <a href="https://www.youtube.com/@edutechbarsha?sub_confirmation=1">
    <img src="https://img.shields.io/badge/Subscribe-EduTech%20Barsha-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube Channel">
  </a>
</div>

# Follow the instructions
## Solution [here](https://youtu.be/ckTp8NUu01A)

---

###  **Task 1: Create a custom measure**

1.  Toggle on **Development Mode** (find it at the bottom-left corner).
2.  Navigate to **Explore > E-Commerce Training > Order Items**.
3.  Expand the **Inventory Items** section.
4.  Click the **More options (⋮)** icon next to the **Cost** field.
5.  Choose **Aggregate > Average**.
6.  Expand **Custom Fields** to see your newly created measure.
7.  Alternatively, you can create it manually:
  *   In **Custom Fields**, click **+ Add > Custom Measure**.
  *   **Field to measure**: `Inventory Items > Cost`
  *   **Measure type**: `Average`
  *   **Name**: `Average of Cost`
  *   **Format**: `U.S. Dollars`
  *   **Decimals**: `2`
  *   Click **Save**.

---

###  **Task 2: Create a custom grouping**

1.  In the **Custom Fields** section, select your **Average of Cost** measure (the one at the bottom if there are duplicates) to add it to your query.
2.  Add **Product Name** (from Inventory Items) to the query.
3.  Add **Country** (from Users), then click the filter icon:
  *   Set the filter to **is equal to** > **USA**.
4.  Click the **More options (⋮)** icon next to **State** (from Users) and select **Group**.
5.  Configure the **Group By State** settings:
  *   **Group name**: `Pacific Northwest`
  *   Add these values: **Oregon**, **Idaho**, **Washington**.
  *   Ensure **Group remaining values** is checked.
  *   Click **Save**.
6.  Select the newly created **State Groups** field to add it to your view.
7.  Click **Run**.

---

### **Task 3: Adding a filter to a custom measure**

1.  In **Custom Fields**, find your **Average of Cost** measure (again, the bottom one if duplicated) and click its **Filter by field** icon.
2.  Set the filter condition to **is greater than** > **200**.
3.  Click **Run**.

---

###  **Task 4: Using table calculations**

1.  Add **Order Count** (from Order Items) to your query.
2.  Click the **Settings (⚙️)** icon on the **Order Count** column in your results table.
3.  Select **Calculations > % of column**.
4.  Click **Run**.

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
