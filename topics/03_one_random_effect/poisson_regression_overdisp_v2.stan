data {
  int<lower=0> N;
  vector[N] water;
  array[N] int y;
  
  // for prediction
  int<lower=0> Npred;
  vector[Npred] water_pred;
}

parameters {
  real b_water;
  real<lower=0> sigma_site;
  vector[N] b_avg;
}

model {
  b_water ~ normal(0, .2);
  b_avg ~ normal(0, sigma_site);
  sigma_site ~ exponential(.5);
  y ~ poisson_log(b_avg + b_water * water);
}

generated quantities {
  array[N] int fake_obs;
  for (i in 1:N){
    fake_obs[i] = poisson_log_rng(b_avg[i] + b_water * water[i]);
  }
  
  // prediction interval for the line
  vector[Npred] new_b_avg;
  array[Npred] int line_obs;
  for (j in 1:Npred){
    new_b_avg[j] = normal_rng(0, sigma_site);
  }
  
  vector[Npred] line_avg;
  line_avg = exp(new_b_avg + b_water * water_pred);
  
  for(k in 1:Npred){
    line_obs[k] = poisson_rng(line_avg[k]);
  }
}
