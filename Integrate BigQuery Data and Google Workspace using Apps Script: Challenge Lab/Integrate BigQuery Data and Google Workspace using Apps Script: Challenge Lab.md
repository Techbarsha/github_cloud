# Integrate BigQuery Data and Google Workspace using Apps Script: Challenge Lab || [ARC133](https://www.cloudskillsboost.google/games/5019/labs/32745) ||

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/mrJHiMwd5IE)

### **TASK 1:-** 
### open [AppsScript](http://script.google.com/) >> create appscript >> services >> Choose ``` Bigquery API ```
### Copy & paste and run your application code
```
/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at apache.org/licenses/LICENSE-2.0.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Filename for data results
var QUERY_NAME = "Most common words in all of Shakespeare's works";
var PROJECT_ID = "PROJECT_ID";
if (!PROJECT_ID) throw Error('Project ID is required in setup');

/**
 * Runs a BigQuery query; puts results into Sheet. You must enable
 * the BigQuery advanced service before you can run this code.
 * @see http://developers.google.com/apps-script/advanced/bigquery#run_query
 * @see http://github.com/gsuitedevs/apps-script-samples/blob/master/advanced/bigquery.gs
 *
 * @returns {Spreadsheet} Returns a spreadsheet with BigQuery results
 * @see http://developers.google.com/apps-script/reference/spreadsheet/spreadsheet
 */
function runQuery() {
  // Replace sample with your own BigQuery query.
  var request = {
    query:
        'SELECT ' +
            'LOWER(word) AS word, ' +
            'SUM(word_count) AS count ' +
        'FROM [bigquery-public-data:samples.shakespeare] ' +
        'GROUP BY word ' +
        'ORDER BY count ' +
        'DESC LIMIT 10'
  };
  var queryResults = BigQuery.Jobs.query(request, PROJECT_ID);
  var jobId = queryResults.jobReference.jobId;

  // Wait for BQ job completion (with exponential backoff).
  var sleepTimeMs = 500;
  while (!queryResults.jobComplete) {
    Utilities.sleep(sleepTimeMs);
    sleepTimeMs *= 2;
    queryResults = BigQuery.Jobs.getQueryResults(PROJECT_ID, jobId);
  }

  // Get all results from BigQuery.
  var rows = queryResults.rows;
  while (queryResults.pageToken) {
    queryResults = BigQuery.Jobs.getQueryResults(PROJECT_ID, jobId, {
      pageToken: queryResults.pageToken
    });
    rows = rows.concat(queryResults.rows);
  }

  // Return null if no data returned.
  if (!rows) {
    return Logger.log('No rows returned.');
  }

  // Create the new results spreadsheet.
  var spreadsheet = SpreadsheetApp.create(QUERY_NAME);
  var sheet = spreadsheet.getActiveSheet();

  // Add headers to Sheet.
  var headers = queryResults.schema.fields.map(function(field) {
    return field.name.toUpperCase();
  });
  sheet.appendRow(headers);

  // Append the results.
  var data = new Array(rows.length);
  for (var i = 0; i < rows.length; i++) {
    var cols = rows[i].f;
    data[i] = new Array(cols.length);
    for (var j = 0; j < cols.length; j++) {
      data[i][j] = cols[j].v;
    }
  }

  // Start storing data in row 2, col 1
  var START_ROW = 2;      // skip header row
  var START_COL = 1;
  sheet.getRange(START_ROW, START_COL, rows.length, headers.length).setValues(data);

  Logger.log('Results spreadsheet created: %s', spreadsheet.getUrl());
}
```
### Save 👍
### Rename file name 
## code.gs >> ``` bq-sheets-slides.gs ```

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
