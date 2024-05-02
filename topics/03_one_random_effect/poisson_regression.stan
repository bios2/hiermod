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
}
model {
  y ~ poisson_log(b_avg + b_water * water);
  b_water ~ normal(0, .2);
  b_avg ~ normal(0, .3);
}
generated quantities {
  array[N] int fake_obs;
  for (i in 1:N){
    fake_obs[i] = poisson_log_rng(b_avg + b_water * water[i]);
  }
  
  // confidence interval for the line
  vector[Npred] line_avg;
  line_avg = exp(b_avg + b_water * water_pred);
  
  // prediction interval for the line
  array[Npred] int line_obs;
  for (j in 1:Npred){
    line_obs[j] = poisson_rng(line_avg[j]);
  }
}
