## code to prepare `DATASET` dataset goes here

ukb_accel <- readRDS("accel.rds")
usethis::use_data(ukb_accel, overwrite = TRUE)

svi <- read.csv("SVI2018_US.csv")
usethis::use_data(svi, overwrite = TRUE)
