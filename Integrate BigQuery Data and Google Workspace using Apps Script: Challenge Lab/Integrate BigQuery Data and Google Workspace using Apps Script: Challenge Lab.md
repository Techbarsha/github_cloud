# Integrate BigQuery Data and Google Workspace using Apps Script: Challenge Lab || [ARC133](https://www.cloudskillsboost.google/games/5019/labs/32745) ||

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/mrJHiMwd5IE)

### **TASK 1:-** 
### open [AppsScript](http://script.google.com/) >> create appscript >> services >> Choose ``` Bigquery API ```
### check lab instructions page

### **TASK 2:-** 
### ▶️ Find out how many taxi companies there are in Chicago.
```
=COUNTUNIQUE(taxi_trips!company)
```

### Find the percentage of taxi rides in Chicago that included a tip.
```
=COUNTIF(taxi_trips!tips,">0")

```

### Find the total number of trips where the fare was greater than 0.
```
=COUNTIF(taxi_trips!fare,">0")

```

### **Task 3:-** 

### * As a pie chart, what forms of payments are people using for their taxi rides?

### Drag ``` payment_type ``` to the Label field. Then drag ``` fare ``` into the Value field 

### Under Value > ``` Fare ``` change ``` Sum to Count ``` Click Apply.

### *As a line chart, how has revenue from mobile payments for taxi trips changed over time?

### *As a line chart, how have mobile payments changed over time since revenue peaked in 2015?

### Drag ``` trip_start_timestamp ``` to the X-axis field.

### Check the ``` Group by option ``` and select ``` Year-Month ``` from the dropdown list.

### Drag ``` fare ``` into the Series field.

### Under Filter click Add  ```payment_type ```

### Select the Showing all items status dropdown.

### Click on the Filter by Condition dropdown and select ``` Text contains ``` from the list.

### Input ``` mobile ``` in the Value field.

### Click ``` OK ```

### **Task 4:-** 

### create a new sheet >> click into the first cell in the upper-left corner (A1) >> enter this >>

### Enter the following address in the first cell
```
76 9th Ave, New York
```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
