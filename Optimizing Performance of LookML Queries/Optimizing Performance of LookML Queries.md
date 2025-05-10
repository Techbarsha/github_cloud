#  Optimizing Performance of LookML Queries || [GSP985](https://www.cloudskillsboost.google/focuses/22355?parent=catalog) ||
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
## Solution [here](https://youtu.be/a7DKb_QbkgE)

### Create View Named **`incremental_pdt`** and add the following LookML code->

```lookml
# If necessary, uncomment the line below to include explore_source.
# include: "training_ecommerce.model.lkml"

view: incremental_pdt {
  derived_table: {
    datagroup_trigger: daily_datagroup
    increment_key: "created_date"
    increment_offset: 3
    explore_source: order_items {
      column: order_id {}
      column: sale_price {}
      column: created_date {}
      column: created_week {}
      column: created_month {}
      column: state { field: users.state }
    }
  }
  dimension: order_id {
    description: ""
    primary_key:  yes
    type: number
  }
  dimension: sale_price {
    description: ""
    type: number
  }
  dimension: created_date {
    description: ""
    type: date
  }
  dimension: created_week {
    description: ""
    type: date_week
  }
  dimension: created_month {
    description: ""
    type: date_month
  }
  dimension: state {
    description: "Arcade Crew"
  }
  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }
  measure: total_revenue {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }
}
```

###  Update **`training_ecommerce.model`**->
```lookml
connection: "bigquery_public_data_looker"

# include all the views
include: "/views/*.view"
include: "/z_tests/*.lkml"
include: "/**/*.dashboard"

datagroup: training_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: training_ecommerce_default_datagroup

datagroup: daily_datagroup {
  sql_trigger: SELECT FORMAT_TIMESTAMP('%F',
    CURRENT_TIMESTAMP(), 'America/Los_Angeles') ;;
  max_cache_age: "24 hours"
}

label: "E-Commerce Training"

explore: order_items {
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: events {
  join: event_session_facts {
    type: left_outer
    sql_on: ${events.session_id} = ${event_session_facts.session_id} ;;
    relationship: many_to_one
  }
  join: event_session_funnel {
    type: left_outer
    sql_on: ${events.session_id} = ${event_session_funnel.session_id} ;;
    relationship: many_to_one
  }
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: incremental_pdt {}


explore: +order_items {
  label: "Order Items - Aggregate Sales"
  aggregate_table: aggregate_sales {
    query: {
      dimensions: [order_items.created_date, users.state]
      measures: [order_items.average_sale_price,
        order_items.total_revenue]
    }
    materialization: {
      datagroup_trigger: daily_datagroup
      increment_key: "created_date"
      increment_offset: 3
    }
  }
}

explore: aggregated_orders {
  from: order_items
  label: "Aggregated Sales"
  join: users {
    type: left_outer
    sql_on: ${aggregated_orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  aggregate_table: aggregate_sales {
    query: {
      dimensions: [aggregated_orders.created_date,
        users.state]
      measures: [aggregated_orders.average_sale_price,
        aggregated_orders.total_revenue]
    }
    materialization: {
      datagroup_trigger: daily_datagroup
      increment_key: "created_date"
      increment_offset: 3
    }
  }
}
```
### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
