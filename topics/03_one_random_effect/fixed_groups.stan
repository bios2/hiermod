data {
  int<lower=0> N;
  vector[N] y;
  int<lower=0> Ngroup;
  array[N] int<lower=0, upper=Ngroup> group_id;
}
parameters {
  real b_avg;
  vector[Ngroup] b_group;
  real<lower=0> sigma;
}
model {
  y ~ normal(b_avg + b_group[group_id], sigma);
  b_group ~ std_normal();
  b_avg ~ normal(5, 2);
  sigma ~ exponential(.5);
}
generated quantities {
  
  vector[Ngroup] group_averages;
  
  for (k in 1:Ngroup){
    group_averages[k] = b_avg + b_group[k];
  }
  
  // predict making one new observation per group
  vector[Ngroup] one_obs_per_group;
  
  for (k in 1:Ngroup) {
    one_obs_per_group[k] = normal_rng(group_averages[k], sigma);
  }
}
