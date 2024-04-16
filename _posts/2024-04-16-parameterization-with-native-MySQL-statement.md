---
layout: post
title: Parameterization with native MySQL statement
tags: ["mysql","query","parameterization","native","statement"]
---


# Parameterization with native MySQL statement
```sql
-- Set the values for your parameters
SET @value1 := 'your_value1';
SET @value2 := 'your_value2';

-- Execute the prepared statement
PREPARE stmt FROM 'SELECT * FROM your_table WHERE column1 = ? AND column2 = ?';
EXECUTE stmt USING @value1, @value2;
DEALLOCATE PREPARE stmt;

```