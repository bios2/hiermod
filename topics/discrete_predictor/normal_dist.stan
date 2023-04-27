data {
  int N;
  vector[N] measurements;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  measurements ~ normal(mu, sigma);
  mu ~ normal(17,2);
  sigma ~ exponential(1);
}
