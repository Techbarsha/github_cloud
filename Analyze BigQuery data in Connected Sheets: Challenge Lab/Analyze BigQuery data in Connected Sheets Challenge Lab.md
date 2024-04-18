# Analyze BigQuery data in Connected Sheets: Challenge Lab || [ARC103](https://www.cloudskillsboost.google/focuses/60443?locale=es&parent=catalog) ||

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/mrJHiMwd5IE)

### Task 1. Open Google Sheets and connect to a BigQuery dataset

1. Select `Data` > `Data Connectors` > `Connect to BigQuery`.

2. If you see a `Connect and Analyze big data in Sheets` pop-up, click `Get Connected`.

3. Select `YOUR PROJECT ID` > `Public datasets` > `new_york_taxi_trips`.

4. Select `tlc_yellow_trips_2022` and click `Connect`.

### Task 2. Use a formula to count rows that meet a specific criteria

Select `Function` > `COUNTIF` and add it to a new sheet.

Ensure `New Sheet` is selected and click Create to add it to a new sheet.

Specify the company column by changing the value of your cell at `row 1`, `column A` to this:

```
=COUNTIF(tlc_yellow_trips_2022!airport_fee, "1")
```

### Task 3. Create charts to visualize BigQuery data

1. Return to the `tlc_yellow_trips_2022` tab by clicking on it at the bottom of your `Google Sheets` page.

2. Click on the `Chart` button. Ensure `New Sheet` is selected and click `Create`.

3. In the Chart editor window, under Chart type, select `Pie chart`.

Various columns of the data are listed to the right. Drag `payment_type` to the `Label` field. Then drag `fare_amount` into the `Value` field and click `Apply`.

### Task 4. Extract data from BigQuery to Connected Sheets

1.Return to the `tlc_yellow_trips_2022` tab by clicking on it at the bottom of your `Google Sheets` page.

2. Click on the `Extract` button.

3. Ensure `New sheet` is selected and `click Create`.

4. In the `Extract editor` window, click `Edit` under the Columns section and select the `pickup_datetime`, `dropoff_datetime`, `trip_distance`, and `fare_amount`. Click outside the dropdown box to continue.

5. Click `Add` under the `Sort` section and `select trip_distance`.

6. Click on `Desc` to toggle between ascending and descending order.

7. Under Row limit, leave 10,000 as it is to import 10,000 rows.

8. Click `Apply`.

### Task 5. Calculate new columns to transform existing column data

1.Return to the `tlc_yellow_trips_2022` tab by clicking on it at the bottom of your `Google Sheets` page.

2. Click on the `Calculated columns` button.

3. Enter your `COLUMN NAME`.

4. Then copy and paste the following formula into the formula field:

```
=IF(fare_amount>0,tip_amount/fare_amount*100,0)
```
5. Click `Add`

6. Click `Apply`.

### Congratulations 🎉 for completing the Lab !😄

# Thanks For Watching:)
