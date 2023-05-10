data {
  int<lower=0> N;
  array[N] int y;
  int<lower=0> Ngroup;
  array[N] int<lower=0, upper=Ngroup> group_id;
}
parameters {
  real b_avg;
  vector[Ngroup] b_group;
  real<lower=0> sigma_grp;
}
model {
  y ~ poisson_log(b_avg + b_group[group_id]);
  b_group ~ normal(0, sigma_grp);
  b_avg ~ normal(5, 2);
  sigma_grp ~ exponential(1);
}
generated quantities {
  vector[N] fake_obs;
  
  for (i in 1:N) {
    fake_obs[i] = poisson_log_rng(b_avg + b_group[group_id[i]]);
  }
  
  // predict making one new observation per group
  array[Ngroup] int one_obs_per_group;
  
  for (k in 1:Ngroup) {
    one_obs_per_group[k] = poisson_log_rng(b_avg + b_group[k]);
  }
  
  // difference for a new group
  real new_b_group = normal_rng(0, sigma_grp);
  
  // observations from that new group
  int one_obs_new_group = poisson_log_rng(b_avg + new_b_group);
  
}
