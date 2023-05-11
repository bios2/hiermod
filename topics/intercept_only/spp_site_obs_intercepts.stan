data{
  int N;
  int N_spp;
  array[N] int<lower=1,upper=N_spp> spp_id;
  int N_sites;
  array[N] int<lower=1,upper=N_sites> site_id;
  array[N] int abd;
}
parameters{
  vector[N_spp] spp_effects;
  vector[N_sites] site_effects;
  vector[N] obs_effects;
  real mu;
  real<lower=0> sigma_spp;
  real<lower=0> sigma_sites;
  real<lower=0> sigma_obs;
}
model {
  abd ~ poisson_log(mu + spp_effects[spp_id] + site_effects[site_id] + obs_effects);
  spp_effects ~ normal(0, sigma_spp);
  site_effects ~ normal(0, sigma_sites);
  obs_effects ~ normal(0, sigma_obs);
  mu ~ normal(6, .5);
  sigma_spp ~ exponential(3);
  sigma_sit ~ exponential(3);
  sigma_obs ~ exponential(3);
}
