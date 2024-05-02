data {
  int<lower=0> N;
  vector[N] water;
  array[N] int y;
  // for prediction
  int<lower=0> Npred;
  vector[Npred] water_pred;
}
parameters {
  real b_avg;
  real b_water;
  real<lower=0> sigma_site;
  vector[N] site_intercepts;
}
model {
  b_avg ~ normal(0, .3);
  b_water ~ normal(0, .2);
  site_intercepts ~ normal(0, sigma_site);
  sigma_site ~ exponential(.5);
  y ~ poisson_log(b_avg + b_water * water + site_intercepts);
}
generated quantities {
  array[N] int fake_obs;
  for (i in 1:N){
    fake_obs[i] = poisson_log_rng(b_avg + b_water * water[i] + site_intercepts[i]);
  }
  
  // confidence interval for the line
  
  // prediction interval for the line
  vector[Npred] new_site_intercepts;
  array[Npred] int line_obs;
  for (j in 1:Npred){
    new_site_intercepts[j] = normal_rng(0, sigma_site);
  }
  
  vector[Npred] line_avg;
  line_avg = exp(b_avg + b_water * water_pred + new_site_intercepts);
  
  for(k in 1:Npred){
    line_obs[k] = poisson_rng(line_avg[k]);
  }
}
