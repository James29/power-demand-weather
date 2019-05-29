#This merges the demand data and the weighted DD measures for the east and west ICs
setwd("~/Documents/BAs")
rm(list = ls())
gc()

library(data.table)
library(fasttime)
library(ggplot2)
library(parallel)
library(data.table)

#read in demand
demand.east <- readRDS("EIA930/demand_east.RDS")
demand.east[, sf := paste0("e.", sf)]
demand.west <- readRDS("EIA930/demand_west.RDS")
demand.west[, sf := paste0("w.", sf)]
demand <- rbindlist(list(demand.east, demand.west))
setnames(demand, "sf_id", "ID")
setkey(demand, sf, date_time)

#read in weather
wdh <- readRDS("wdh_by_ba.RDS")
wdh.w <- dcast(wdh, sf + date_time ~ ID, value.var = c("hdh_18", "cdh_18"), sep = ".", fill = NA, drop = T)
setkey(wdh.w, sf, date_time)

#merge
dt <- demand[wdh.w, nomatch = 0]

#create time variables
dt[, `:=`(
  year = as.integer(format(date_time, "%Y")),
  month = as.integer(format(date_time, "%m")),
  day = as.integer(format(date_time, "%j")),
  hour = as.integer(format(date_time, "%H"))
  ), by = date_time]
dt[, month.hour := as.factor(paste0(month, ".", hour))]
saveRDS(dt, "dt_for_reg.RDS")

