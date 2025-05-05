data {
  // number of rows in dataset
  int<lower=0> Nsites;
  // number of species
  int<lower=0> Nspp;
  // one environmental variable to use in prediction
  vector[Nsites*Nspp] x;
  // species ids
  array[Nsites*Nspp] int spp_id;
  // site ids
  array[Nsites*Nspp] int site_id;
  // response site (rows) by species (columns) 2D array
  array[Nsites*Nspp] int <lower=0,upper=1> y;
}
parameters {
  real b0;
  vector[Nspp] b0_sp;
  real<lower=0> sd_b0_sp;
  vector[Nsites] b0_site;
  real<lower=0> sd_b0_site;
  vector[Nspp] b_water_sp;
  real mu_b_water_sp;
  real<lower=0> sd_b_water_sp;
}
model {

  y ~ bernoulli_logit(b0 + b0_site[site_id] + b0_sp[spp_id] + b_water_sp[spp_id] .* x);

  // priors
  b0          ~ normal(0, .5);
  b0_site     ~ normal(0, sd_b0_site);
  b0_sp       ~ normal(0, sd_b0_sp);
  b_water_sp  ~ normal(mu_b_water_sp, sd_b_water_sp);
  sd_b0_site ~ exponential(2); 
  sd_b0_sp ~ exponential(2);
  mu_b_water_sp ~ normal(0, 1);
  sd_b_water_sp ~ exponential(2);
  
}

