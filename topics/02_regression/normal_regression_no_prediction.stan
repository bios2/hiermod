data {
  int<lower=0> N;
  vector[N] bill_len;
  vector[N] bill_dep;
}
parameters {
  real intercept;
  real slope;
  real<lower=0> sigma;
}
model {
  bill_dep ~ normal(intercept + slope * bill_len, sigma);
  intercept ~ normal(17, 2);
  slope ~ normal(0, 1);
  sigma ~ exponential(.7);
}
