#' Create a Poisson Regression Model.
#' This function creates a Poisson regression model:
#' E_CASE ~ E_DISABL + E_LIMENG + E_NOHSDP + E_SNGPNT + E_UNEMP + E_POV + E_PCI
#' @param x an object inherited from svi data.frame.
#' @param y an object inherited from covid data.frame.
#' @return the summary table of the regression model, the pseudo r-squared,
#' the correlation matrix for the variables.
#' @importFrom dplyr filter group_by summarize across rename
#' @importFrom stats glm coef pnorm
#' @importFrom sandwich vcovHC
#' @importFrom pscl pR2
#' @examples
#' data(svi)
#' data(covid)
#' fit4(svi, covid)
#' @export

fit4 <- function(x, y) {
  # SVI data
  x[x == -999] <- NA
  x <- x |>
    filter(E_TOTPOP != 0) |>
    group_by(COUNTY) |>
    summarize(across(c(E_DISABL, E_LIMENG, E_NOHSDP, E_SNGPNT, E_UNEMP, E_POV,
                       E_PCI), sum), .groups = "drop")
  # Covid data
  y <- y |>
    group_by(county) |>
    summarize(E_CASE = sum(cases)) |>
    rename(COUNTY = county)
  # Merge data sets
  xy <- merge(x, y, by = "COUNTY", all.x = TRUE)
  # Poisson regression model
  model <- glm(E_CASE ~ E_DISABL + E_LIMENG + E_NOHSDP + E_SNGPNT + E_UNEMP +
                 E_POV + E_PCI, data = xy, family = "poisson")
  # Summary statistics
  cov_model <- vcovHC(model, type = "HC0")
  std_err <- sqrt(diag(cov_model))
  rob_est <- cbind(Estimate = coef(model), "Robust SE" = std_err,
                   "Pr(>|z|)" = 2 * pnorm(abs(coef(model) / std_err),
                                          lower.tail = FALSE),
                   LL = coef(model) - 1.96 * std_err,
                   UL = coef(model) + 1.96 * std_err)
  print(rob_est)
  print(pR2(model)["McFadden"])
}
