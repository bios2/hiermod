data {
  int<lower=0> N;
  matrix[N, 1] x;
  array[N] int<lower=0,upper=1> y;
}
parameters {
  real intercept;
  vector[1] slope;
}
model {
  intercept ~ normal(-2.5, .5);
  slope ~ normal(0, .5);
  y ~ bernoulli_logit_glm(x, intercept, slope);
}

