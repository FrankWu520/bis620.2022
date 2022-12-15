#' Plot a Poisson Regression Model.
#' This function plots a Poisson regression model:
#' @param x an object inherited from svi data.frame.
#' @param y an object inherited from covid data.frame.
#' @param model which model should be plotted.
#' @return diagnostic plots of the regression model.
#' @importFrom dplyr filter group_by summarize across rename
#' @importFrom stats glm rstandard
#' @importFrom graphics par
#' @importFrom ggplot2 ggplot geom_qq geom_abline
#' @examples
#' data(svi)
#' data(covid)
#' model_plot(svi, covid, model = 1)
#' @export
#'
model_plot <- function(x, y, model) {
  # Data cleaning
  x[x == -999] <- NA
  x <- x |>
    filter(E_TOTPOP != 0)
  # Poisson regression model
  model1 <- glm(E_POV ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT,
               data = x, family = "poisson")
  model2 <- glm(E_UNEMP ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT,
               data = x, family = "poisson")
  model3 <- glm(E_CROWD ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT +
                 E_UNEMP + E_POV + E_PCI, data = x, family = "poisson")
  # Create regression qq-plot
  if (model == 1) {
    ggplot() +
      geom_qq(aes(sample = rstandard(model1))) +
      geom_abline(color = "red")
  } else if (model == 2) {
    ggplot() +
      geom_qq(aes(sample = rstandard(model2))) +
      geom_abline(color = "red")
  } else if (model == 3) {
    ggplot() +
      geom_qq(aes(sample = rstandard(model3))) +
      geom_abline(color = "red")
  } else {
    # SVI data
    x <- x |>
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
    model4 <- glm(E_CASE ~ E_DISABL + E_LIMENG + E_NOHSDP + E_SNGPNT + E_UNEMP +
                    E_POV + E_PCI, data = xy, family = "poisson")
    ggplot() +
      geom_qq(aes(sample = rstandard(model4))) +
      geom_abline(color = "red")
  }
}
