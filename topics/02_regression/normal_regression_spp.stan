data {
  int<lower=0> N;
  vector[N] bill_len;
  vector[N] bill_dep;
  // species IDs
  array[N] int spp_id;
  // posterior predictions
  int<lower=0> npost;
  vector[npost] pred_values;
  array[npost] int pred_spp_id;
}
parameters {
  vector[3] intercept;
  real slope;
  real<lower=0> sigma;
}
model {
  bill_dep ~ normal(intercept[spp_id] + slope * bill_len, sigma);
  intercept ~ normal(17, 2);
  slope ~ normal(0, 1);
}
generated quantities {
  vector[npost] post_bill_dep_obs;
  vector[npost] post_bill_dep_average;
  
  // calculate expectation
  post_bill_dep_average = intercept[pred_spp_id] + slope * pred_values;
  
  // make fake observations
  for (i in 1:npost) {
    post_bill_dep_obs[i] = normal_rng(intercept[pred_spp_id[i]] + slope * pred_values[i], sigma);
  }  
  
}
