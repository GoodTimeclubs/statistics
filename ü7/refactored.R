###########################################################
# Descriptive Statistics for DWD Climate Data (via rdwd)
#
# Requirements:
#
#install.packages(c("rdwd","dplyr","ggplot2","lubridate"))
#
# This script:
#
# - auto-downloads daily climate (KL) data from DWD
#
# - performs basic descriptive analysis:
#   * histograms (bin width comparison)
#   * ECDF
#   * boxplots by month / season
#   * precipitation distribution
#   * correlation + regression (temp ~ sunshine)
#   * contingency table: wet vs dry by season
############################################################

library(rdwd)
library(dplyr)
library(ggplot2)
library(lubridate)
# install.packages("broom")
# install.packages("lmtest")
# install.packages("car")

#Task 2

dwd <- selectDWD("Frankfurt/Main", res = "daily", var = "kl", per = "recent") %>%
  dataDWD(link, dir = "DWDdata", read = TRUE) %>%
  mutate( date = ymd(MESS_DATUM)) %>%
  select(
    station = STATIONS_ID,
    date,
    t_mean = TMK,
    t_max = TXK,
    t_min = TNK,
    precip = RSK,
    sun = SDK
  ) %>% 
  filter(date >= as.Date("2010-01-01")) %>% 
  mutate(
    month = factor(
      month(date),
      levels = 1:12,
      labels = c("Jan","Feb","Mar","Apr","May","Jun",
                 "Jul","Aug","Sep","Oct","Nov","Dec")
    ),
    season = case_when(
      month(date) %in% c(12,1,2) ~ "Winter",
      month(date) %in% c(3,4,5) ~ "Spring",
      month(date) %in% c(6,7,8) ~ "Summer",
      TRUE ~ "Autumn"
    ),
    season = factor(season, levels = c("Winter","Spring","Summer","Autumn"))
  ) %>% as_tibble() 


############################################################
## 3. Replace Printed Summaries by Tidy Summaries
############################################################



numericSummary <- dwd %>% 
  summarise(
    mean = mean(dwd$t_mean),
    SD = sd(dwd$t_mean),
    quantiles = list(quantile(t_mean, na.rm = TRUE))
  )
numericSummary

precipitationSummary <- dwd %>%
  summarise(
    mean = mean(precip, na.rm = TRUE),
    median = median(precip, na.rm = TRUE),
    highQuantile = list(quantile(precip, probs = c(0.9, 0.95, 0.99), na.rm = TRUE))
    )
precipitationSummary


dwd %>%
  summarise(across(everything(), ~sum(is.na(.))))



#T4

dwd %>%
  mutate(
    wet = precip > 0
  ) -> dwd

dwd %>%
  filter(!is.na(wet)) %>%
  group_by(season) %>%
  count(wet) %>%
  mutate(
    prob = n / sum(n)
  ) %>%
  as_tibble() -> contingencyTable

contingencyTable

#T5

dwd %>% 
  ggplot(aes(x = t_mean))+
  geom_histogram() +
  
dwd %>% 
  ggplot(aes(x = t_mean, colour = season))+
  stat_ecdf(na.rm = TRUE)

dwd %>%
  ggplot(aes(x = t_mean, colour = season))+
  geom_boxplot(na.rm = TRUE)

dwd %>%
  filter(!is.na(wet)) %>%
  ggplot(aes(x = wet, colour = season))+
  geom_bar()

#T6
library(broom)
 model <- lm(t_mean ~ sun, data = dwd)
 nlsfit <- nls(t_mean ~ sun, data = dwd)

 tidy(model)
 glance(model)
