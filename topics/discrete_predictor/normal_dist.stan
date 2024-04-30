data {
  int N;
  vector[N] measurements;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  // priors
  mu ~ normal(17,2);
  sigma ~ exponential(1);
  // likelihood
  measurements ~ normal(mu, sigma);
}
