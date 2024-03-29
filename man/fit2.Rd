% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit2.R
\name{fit2}
\alias{fit2}
\title{Create a Poisson Regression Model.
This function creates a Poisson regression model:
E_UNEMP ~ E_DISABL + E_LIMENG + E_MINRTY+ E_NOHSDP + E_SNGPNT + E_POV + E_PCI}
\usage{
fit2(x)
}
\arguments{
\item{x}{an object inherited from svi data.frame.}
}
\value{
the summary table of the regression model, the pseudo r-squared,
the correlation matrix for the variables.
}
\description{
Create a Poisson Regression Model.
This function creates a Poisson regression model:
E_UNEMP ~ E_DISABL + E_LIMENG + E_MINRTY+ E_NOHSDP + E_SNGPNT + E_POV + E_PCI
}
\examples{
data(svi)
fit2(svi)
}
