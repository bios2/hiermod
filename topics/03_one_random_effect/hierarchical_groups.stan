data {
  int<lower=0> N;
  vector[N] y;
  int<lower=0> Ngroup;
  array[N] int<lower=0, upper=Ngroup> group_id;
}
parameters {
  real b_avg;
  vector[Ngroup] b_group;
  real<lower=0> sigma_obs;
  real<lower=0> sigma_grp;
}
model {
  y ~ normal(b_avg + b_group[group_id], sigma_obs);
  b_group ~ normal(0, sigma_grp);
  b_avg ~ normal(5, 2);
  sigma_obs ~ exponential(.5);
  sigma_grp ~ exponential(1);
}
generated quantities {
  vector[N] fake_obs;
  
  for (i in 1:N) {
    fake_obs[i] = normal_rng(b_avg + b_group[group_id[i]], sigma_obs);
  }
  
  // predict making one new observation per group
  vector[Ngroup] one_obs_per_group;
  
  for (k in 1:Ngroup) {
    one_obs_per_group[k] = normal_rng(b_avg + b_group[k], sigma_obs);
  }
  
  // difference for a new group
  real new_b_group = normal_rng(0, sigma_grp);
  
  // observations from that new group
  real one_obs_new_group = normal_rng(b_avg + new_b_group, sigma_obs);
  
}
