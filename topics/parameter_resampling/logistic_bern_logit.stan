data {
  int<lower=0> n;
  vector[n] x;
  array[n] int<lower=0,upper=1> y;
}
parameters {
  real intercept;
  real slope;
}
model {
  y ~ bernoulli_logit(intercept + slope * x);
  intercept ~ normal(-2.5, .5);
  slope ~ normal(0, .5);
}

