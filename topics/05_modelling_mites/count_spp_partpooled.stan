data {
  // number of rows in dataset
  int<lower=0> Nsites;
  // number of species
  int<lower=0> S;
  // one environmental variable to use in prediction
  row_vector[Nsites] x;
  // response site (rows) by species (columns) 2D array
  array[Nsites,S] int <lower=0> y;
}
parameters {
  // parameters are now VECTORS
  vector[S] intercept;
  array[S] vector[1] slope;
  real<lower=0> sigma_intercept;
  real<lower=0> sigma_slope;
  real avg_intercept;
  real avg_slope;
}
model {
  for (s in 1:S){
    y[,s] ~ poisson_log_glm(x, intercept[s], slope[s]);
  }
  // priors don't change because Stan is vectorized:
  // every element of the vector gets the same prior
  intercept ~ normal(avg_intercept, sigma_intercept);
  for (s in 1:S){
    slope[s] ~ normal(avg_slope, sigma_slope);
  }
  avg_intercept ~ normal(0, 1);
  avg_slope ~ normal(0, 1);
  sigma_intercept ~ exponential(5);
  sigma_slope ~ exponential(5);
  
}

