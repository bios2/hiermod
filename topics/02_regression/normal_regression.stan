data {
  int<lower=0> N;
  vector[N] bill_len;
  vector[N] bill_dep;
  // posterior predictions
  int<lower=0> npost;
  vector[npost] pred_values;
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
}
generated quantities {
  vector[npost] post_bill_dep_obs;
  vector[npost] post_bill_dep_average;
  
  // calculate expectation
  post_bill_dep_average = intercept + slope * pred_values;
  
  // make fake observations
  for (i in 1:npost) {
    post_bill_dep_obs[i] = normal_rng(intercept + slope * pred_values[i], sigma);
  }  
  
}

