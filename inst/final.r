data(svi)
library(dplyr)
svi[svi == -999] <- NA
svi1 <- svi |>
  filter(E_TOTPOP != 0) |>
  select(E_CROWD, E_DISABL, E_LIMENG, E_MINRTY, E_NOHSDP, E_PCI, E_POV, E_SNGPNT, E_UNEMP)

fit1 <- glm(E_POV ~ E_DISABL + E_LIMENG + E_MINRTY+ E_NOHSDP + E_SNGPNT, data = svi1, family="poisson")
fit2 <- glm(E_UNEMP ~ E_DISABL + E_LIMENG + E_MINRTY+ E_NOHSDP + E_SNGPNT, data = svi1, family="poisson")
fit3 <- glm(E_CROWD ~ E_DISABL + E_LIMENG + E_MINRTY+ E_NOHSDP + E_SNGPNT + E_UNEMP + E_POV + E_PCI, data = svi1, family="poisson")
summary(fit1)

library(sandwich)
cov.fit1 <- vcovHC(fit1, type="HC0")
std.err <- sqrt(diag(cov.fit1))
r.est <- cbind(Estimate= coef(fit1), "Robust SE" = std.err,
               "Pr(>|z|)" = 2 * pnorm(abs(coef(fit1)/std.err), lower.tail=FALSE),
               LL = coef(fit1) - 1.96 * std.err,
               UL = coef(fit1) + 1.96 * std.err)

r.est

cov.fit2 <- vcovHC(fit2, type="HC0")
std.err <- sqrt(diag(cov.fit2))
r.est <- cbind(Estimate= coef(fit2), "Robust SE" = std.err,
               "Pr(>|z|)" = 2 * pnorm(abs(coef(fit2)/std.err), lower.tail=FALSE),
               LL = coef(fit2) - 1.96 * std.err,
               UL = coef(fit2) + 1.96 * std.err)

r.est

cov.fit3 <- vcovHC(fit3, type="HC0")
std.err <- sqrt(diag(cov.fit3))
r.est <- cbind(Estimate= coef(fit3), "Robust SE" = std.err,
               "Pr(>|z|)" = 2 * pnorm(abs(coef(fit3)/std.err), lower.tail=FALSE),
               LL = coef(fit3) - 1.96 * std.err,
               UL = coef(fit3) + 1.96 * std.err)

class(r.est)

1 - pchisq(27554086-13495840, 72401-72395)

par(mfrow=c(2,2))
plot(fit1)

data(svi)
fit1(svi)

library(pscl)
class(pR2(fit1)['McFadden'])

library(ggplot2)
ggplot() +
  geom_qq(aes(sample = rstandard(fit3))) +
  geom_abline(color = "red")
