###########################################################
# Descriptive Statistics for DWD Climate Data (via rdwd)
#
# Requirements:
#
install.packages(c("rdwd","dplyr","ggplot2","lubridate"))
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

############################################################
## 1. Choose station and product
############################################################

station_name <- "Frankfurt/Main"

res <- "daily"
var <- "kl"
per <- "recent"

cat("### Selecting DWD link via rdwd::selectDWD\n")
link <- selectDWD(name = station_name, res = res, var = var, per = per)

cat("Selected link(s):\n")
print(link)

############################################################
## 2. Download & read data via rdwd
############################################################

cat("### Downloading and reading data with dataDWD()...\n")
dwd_raw <- dataDWD(link, dir = "DWDdata", read = TRUE)

cat("### Structure of raw DWD data:\n")
str(dwd_raw)

cat("### Head of raw data:\n")
print(head(dwd_raw))

############################################################
## 3. Clean and prepare
############################################################

dwd <- dwd_raw %>%
  mutate(
    date = ymd(MESS_DATUM)
  ) %>%
  select(
    station = STATIONS_ID,
    date,
    t_mean = TMK,
    t_max = TXK,
    t_min = TNK,
    precip = RSK,
    sun = SDK
  )

cat("### Summary after column selection:\n")
print(summary(dwd))

cat("### Missing values per column:\n")
print(colSums(is.na(dwd)))

dwd <- dwd %>% filter(date >= as.Date("2010-01-01"))

############################################################
## 4. Univariate analysis: mean temperature
############################################################

ggplot(dwd, aes(t_mean)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "white") +
  labs(
    title = "Histogram of Daily Mean Temperature",
    x = "Mean Temperature (degrees C)",
    y = "Count"
  ) +
  theme_minimal()

p_small <- ggplot(dwd, aes(t_mean)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "white") +
  labs(
    title = "Very Small Bin Width (0.5 degrees C)",
    x = "Mean Temperature (degrees C)",
    y = "Count"
  ) +
  theme_minimal()

p_medium <- ggplot(dwd, aes(t_mean)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "white") +
  labs(
    title = "Moderate Bin Width (2 degrees C)",
    x = "Mean Temperature (degrees C)",
    y = "Count"
  ) +
  theme_minimal()

p_large <- ggplot(dwd, aes(t_mean)) +
  geom_histogram(binwidth = 5, fill = "navy", color = "white") +
  labs(
    title = "Very Large Bin Width (5 degrees C)",
    x = "Mean Temperature (degrees C)",
    y = "Count"
  ) +
  theme_minimal()

p_small
p_medium
p_large

ggplot(dwd, aes(t_mean)) +
  stat_ecdf(geom = "step") +
  labs(
    title = "ECDF of Daily Mean Temperature",
    x = "Mean Temperature (degrees C)",
    y = "F_n(x)"
  ) +
  theme_minimal()

cat("### Numerical summary of mean temperature:\n")
print(summary(dwd$t_mean))

cat("### Quartiles of mean temperature:\n")
print(quantile(dwd$t_mean, probs = c(0.25, 0.5, 0.75), na.rm = TRUE))

############################################################
## 5. Seasonal patterns: boxplots by month & season
############################################################

dwd <- dwd %>%
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
  )

ggplot(dwd, aes(month, t_mean)) +
  geom_boxplot(fill = "lightgray") +
  labs(
    title = "Monthly Distribution of Daily Mean Temperature",
    x = "Month",
    y = "Mean Temperature (degrees C)"
  ) +
  theme_minimal()

ggplot(dwd, aes(season, t_mean)) +
  geom_boxplot(fill = "lightgray") +
  labs(
    title = "Seasonal Distribution of Daily Mean Temperature",
    x = "Season",
    y = "Mean Temperature (degrees C)"
  ) +
  theme_minimal()

############################################################
## 6. Precipitation analysis
############################################################

cat("### Precipitation summary:\n")
print(summary(dwd$precip))

ggplot(dwd, aes(precip)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "white") +
  coord_cartesian(xlim = c(0,50)) +
  labs(
    title = "Histogram of Daily Precipitation (0–50 mm)",
    x = "Precipitation (mm)",
    y = "Count"
  ) +
  theme_minimal()

dwd <- dwd %>% mutate(wet = precip > 0)

cat("### Wet vs dry days:\n")
print(table(dwd$wet))
print(prop.table(table(dwd$wet)))

############################################################
## 7. Bivariate analysis: Temperature vs Sunshine
############################################################

ggplot(dwd, aes(sun, t_mean)) +
  geom_point(alpha = 0.4) +
  labs(
    title = "Daily Mean Temperature vs Sunshine Duration",
    x = "Sunshine Duration (hours)",
    y = "Mean Temperature (degrees C)"
  ) +
  theme_minimal()

cat("### Correlation (sunshine vs temperature):\n")
print(cor(dwd$sun, dwd$t_mean, use = "complete.obs"))

model_temp_sun <- lm(t_mean ~ sun, data = dwd)

cat("### Regression: t_mean ~ sun\n")
print(summary(model_temp_sun))

ggplot(dwd, aes(sun, t_mean)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Regression of Mean Temperature on Sunshine",
    x = "Sunshine Duration (hours)",
    y = "Mean Temperature (degrees C)"
  ) +
  theme_minimal()

############################################################
## 8. Contingency table: wet vs dry by season
############################################################

tab_wet_season <- table(dwd$wet, dwd$season)

cat("### Wet vs dry by season:\n")
print(tab_wet_season)

cat("### Relative frequencies (within season):\n")
print(prop.table(tab_wet_season, margin = 2))

ggplot(dwd, aes(season, fill = wet)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Relative Frequency of Wet vs Dry Days by Season",
    x = "Season",
    y = "Proportion"
  ) +
  theme_minimal()
