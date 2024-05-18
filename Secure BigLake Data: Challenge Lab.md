## Use this Query to verify the column-level security
```
SELECT *  EXCEPT(zip, latitude, ip_address, longitude)
FROM `PROJECT_ID.online_shop.user_online_sessions`
```
