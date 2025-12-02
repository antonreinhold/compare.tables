# compare.tables

**Function to compare two tables in R**  
**Version:** 0.2  
**Author:** Anton Reinhold  
**Date:** 2025-12-01  

---

This package is designed for situations where **two researchers have independently copied data from paper-and-pencil sheets into Excel**.  

**Important:** Both tables must have a common ID column. The comparison is done by merging the tables on this ID. You can load this package and use the `compare_tables()` function to identify any discrepancies between the two tables.

## How it works

- `-99` indicates **values that do not match**.  
  Example:  
  table1 <- data.frame(ID = 1:4, value = c(1, 2, 3, 4))  
  table2 <- data.frame(ID = 1:4, value = c(1, 2, 2, 4))  
  compare_tables(table1, table2, id = "ID")  
  value column shows `c(1, 2, -99, 4)`

- `-88` indicates **one missing value**.  
  Example:  
  table1 <- data.frame(ID = 1:4, value = c(1, 2, 3, 4))  
  table2 <- data.frame(ID = 1:4, value = c(1, 2, NA, 4))  
  compare_tables(table1, table2, id = "ID")  
  value column shows `c(1, 2, -88, 4)`

- **Two missing values** result in a missing value (`NA`).  
  Example:  
  table1 <- data.frame(ID = 1:4, value = c(1, 2, NA, 4))  
  table2 <- data.frame(ID = 1:4, value = c(1, 2, NA, 4))  
  compare_tables(table1, table2, id = "ID")  
  value column shows `c(1, 2, NA, 4)`

---

## Usage

library(compare.tables)  

result <- compare_tables(table1, table2, id = "ID")  
print(result)
