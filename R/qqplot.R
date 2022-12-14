#' Plot a Poisson Regression Model.
#' This function plots a Poisson regression model:
#' @param x an object inherited from svi data.frame.
#' @param model which model should be plotted.
#' @return diagnostic plots of the regression model.
#' @importFrom dplyr filter
#' @importFrom stats glm rstandard
#' @importFrom graphics par
#' @importFrom ggplot2 ggplot geom_qq geom_abline
#' @examples
#' data(svi)
#' model_plot(svi, model = 1)
#' @export
#'
model_plot <- function(x, model) {
  x[x == -999] <- NA
  x <- x |>
    filter(E_TOTPOP != 0)
  model1 <- glm(E_POV ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT,
               data=x, family="poisson")
  model2 <- glm(E_UNEMP ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT,
               data=x, family="poisson")
  model3 <- glm(E_CROWD ~ E_DISABL + E_LIMENG + E_MINRTY + E_NOHSDP + E_SNGPNT +
                 E_UNEMP + E_POV + E_PCI, data=x, family="poisson")
  if (model == 1) {
    ggplot() +
      geom_qq(aes(sample = rstandard(model1))) +
      geom_abline(color = "red")
  }
  else if (model == 2) {
    ggplot() +
      geom_qq(aes(sample = rstandard(model2))) +
      geom_abline(color = "red")
  }
  else {
    ggplot() +
      geom_qq(aes(sample = rstandard(model3))) +
      geom_abline(color = "red")
  }
}
