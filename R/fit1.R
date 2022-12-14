#' Create a Poisson Regression Model.
#' This function creates a Poisson regression model:
#' E_POV ~ E_DISABL + E_LIMENG + E_MINRTY+ E_NOHSDP + E_SNGPNT + E_UNEMP + E_PCI
#' @param x an object inherited from svi data.frame.
#' @return the summary table of the regression model, the pseudo r-squared,
#' the correlation matrix for the variables.
#' @importFrom dplyr filter
#' @importFrom stats glm coef pnorm
#' @importFrom sandwich vcovHC
#' @importFrom pscl pR2
#' @examples
#' data(svi)
#' fit1(svi)
#' @export

fit1 <- function(x) {
  x[x == -999] <- NA
  x <- x |>
    filter(E_TOTPOP != 0) |>
    select(E_POV, E_DISABL, E_LIMENG, E_MINRTY, E_NOHSDP, E_SNGPNT)
  model <- glm(E_POV ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT,
               data=x, family="poisson")
  cov_model <- vcovHC(model, type="HC0")
  std_err <- sqrt(diag(cov_model))
  rob_est <- cbind(Estimate= coef(model), "Robust SE" = std_err,
                   "Pr(>|z|)" = 2 * pnorm(abs(coef(model)/std_err), lower.tail=FALSE),
                   LL = coef(model) - 1.96 * std_err,
                   UL = coef(model) + 1.96 * std_err)
  print(rob_est)
  print(pR2(model)['McFadden'])
}
