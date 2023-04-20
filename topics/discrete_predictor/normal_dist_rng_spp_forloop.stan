data {
  int N;
  vector[N] measurements;
  array[N] int<lower=1,upper=3> spp_id;
}
parameters {
  vector[3] mu;
  real<lower=0> sigma;
}
model {
  for (i in 1:N){
    measurements[i] ~ normal(mu[spp_id[i]], sigma);
  }
  mu ~ normal(17,2);
  sigma ~ exponential(1);
}
generated quantities{
  vector[N] yrep;
  for (i in 1:N){
    yrep[i] = normal_rng(mu[spp_id[i]], sigma);
  }
}
