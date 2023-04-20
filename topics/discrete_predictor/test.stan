data {
  int N;
  vector[N] measurements;
  array[N] int<lower=1,upper=3> spp_id;
}
parameters {
  vector[3] mu;
  vector<lower=0>[3] sigma;
}
model {
  measurements ~ normal(mu[spp_id], sigma[spp_id]);
  mu ~ normal(17,2);
  sigma ~ exponential(1);
}
generated quantities{
  vector[N] yrep;
  for (i in 1:N){
    yrep[i] = normal_rng(mu[spp_id[i]], sigma[spp_id[i]]);
  }
}
