## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(bis620.2022)
library(devtools)
document()

## -----------------------------------------------------------------------------
data(svi)
fit1(svi)

## -----------------------------------------------------------------------------
data(svi)
data(covid)
model_plot(svi, covid, model = 1)
model_plot(svi, covid, model = 2)
model_plot(svi, covid, model = 3)
model_plot(svi, covid, model = 4)

