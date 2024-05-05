data {
  // number of rows in dataset
  int<lower=0> Nsites;
  // number of species
  int<lower=0> S;
  // one environmental variable to use in prediction
  vector[Nsites] x;
  // response site (rows) by species (columns) 2D array
  array[Nsites,S] int <lower=0,upper=1> y;
}
parameters {
  // parameters are now VECTORS
  vector[S] intercept;
  vector[S] slope;
  real<lower=0> sigma_intercept;
  real<lower=0> sigma_slope;
  real avg_intercept;
  real avg_slope;
}
model {
  for (s in 1:S){
    y[,s] ~ bernoulli_logit(intercept[s] + slope[s] * x);
  }
  // priors don't change because Stan is vectorized:
  // every element of the vector gets the same prior
  intercept ~ normal(avg_intercept, sigma_intercept);
  slope ~ normal(avg_slope, sigma_slope);
  avg_intercept ~ normal(0, 1);
  avg_slope ~ normal(0, 1);
  sigma_intercept ~ exponential(5);
  sigma_slope ~ exponential(5);
  
}

