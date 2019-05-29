setwd("~/Documents/BAs")
rm(list = ls())
gc()

library(data.table)
library(fasttime)
library(ggplot2)
library(parallel)
library(data.table)
library(lfe)
library(RColorBrewer)

dt <- readRDS("dt_for_reg.RDS")
dt[, demand := demand / 1000]
dt[, l.demand := log(demand)]
dt[, lag.l.demand := shift(l.demand, 1), by = list(sf, ID)]

dt.5 <- dt[sf %in% c("e.5", "w.5")]
dt.5[, sd(demand, na.rm = T)/mean(demand, na.rm = T), by = list(sf, ID)]

#very high auto correlation - 0.9 to 0.99
dt[sf %in% c("e.5", "w.5"), cor(l.demand, lag.l.demand, use = "complete.obs"), by = list(sf, ID)]

dt[sf %in% c("e.5", "w.5") & ID == 1, cor(hdh_18.1, shift(hdh_18.1, 1), use = "complete.obs"), by = list(sf, ID)]

mean.hr <- dt[sf %in% c("e.5", "w.5"), list(m.d = mean(demand, na.rm = T)), by = list(sf, ID, month, hour)]
mean.hr[, ID_p := paste0(substr(sf, 1, 1), ".", ID), by = list(sf, ID)]
mean.hr[, ID_p := as.factor(ID_p)]
mean.hr[, month := as.factor(month)]
mean.hr[, sf.d := m.d / mean(m.d), by = ID_p]
setkey(mean.hr, month, hour)
ggplot(mean.hr[sf == "w.5"], aes(x = hour, y = sf.d, color = ID_p)) + 
  geom_hline(yintercept = 1, col = 'red', linetype = 2) +
  geom_line() + 
  facet_grid(rows = vars(ID_p),
             cols = vars(month)) +
  scale_y_continuous(limits = c(0.5, 1.5), name = "Hourly Seasonal Factor (Demand)") +
  scale_x_continuous(breaks = c(0, 10, 20), name = "Hour (UTC)") + 
  scale_color_manual(values = brewer.pal(5, "Dark2"), guide = F)

ggplot(mean.hr[sf == "e.5"], aes(x = hour, y = sf.d, color = ID_p)) + 
  geom_hline(yintercept = 1, col = 'red', linetype = 2) +
  geom_line() + 
  facet_grid(rows = vars(ID_p),
             cols = vars(month)) +
  scale_y_continuous(limits = c(0.5, 1.5), name = "Hourly Seasonal Factor (Demand)") +
  scale_x_continuous(breaks = c(0, 10, 20), name = "Hour (UTC)") + 
  scale_color_manual(values = brewer.pal(5, "Dark2"), guide = F)
