
smear <- "positive"
dat   <- analysis$all_data[analysis$all_data$smear_status == smear,]

standat <- list(
  N            = nrow(dat),
  K            = max(dat$cohort_id),
  n_at_risk    = dat$n_at_risk,
  n_new_deaths = dat$n_new_deaths,
  t_start      = dat$t_start,
  delta_t      = dat$delta_t,
  cohort_id    = dat$cohort_id,
  mu           = analysis$mu
)

library(rstan)
options(mc.cores = parallel::detectCores())

#------  non-hierarchical model  ------

# fit the model
fit1 <- stan(file = "stan_model.stan", 
             data = standat)

# choose which parameters to summarise
pars <- c("mu_t", "gamma")

# summary statistics for posterior
summary(fit1, pars = pars)$summary

# plots of posterior density and trace 
plot(fit1, pars = pars, plotfun = "dens")
plot(fit1, pars = pars, plotfun = "trace")
plot(fit1, pars = pars, plotfun = "trace", inc_warmup = TRUE)

#------  hierarchical model  ------

# fit the model
fit2 <- stan(file = "stan_model_hierarchical.stan", 
             data = standat)

# choose which parameters to summarise
pars <- c("lambda_mu_t", "lambda_gamma", "sigma_mu_t", "sigma_gamma")

# summary statistics for posterior
summary(fit2, pars = pars)$summary

# plots of posterior density and trace 
plot(fit2, pars = pars, plotfun = "dens")
plot(fit2, pars = pars, plotfun = "trace")
plot(fit2, pars = pars, plotfun = "trace", inc_warmup = TRUE)
