data{
  int N;
  int N_groups;
  array[N] int group_id;
  array[N] int abd;
}
parameters{
  vector[N_groups] group_mean;
  real mu;
  real<lower=0> sigma;
}
model {
  abd ~ poisson_log(group_mean[group_id]);
  group_mean ~ normal(mu, sigma);
  mu ~ normal(6, .5);
  sigma ~ exponential(1);
}
