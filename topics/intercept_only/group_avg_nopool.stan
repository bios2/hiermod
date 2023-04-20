data{
  int N;
  int N_groups;
  array[N] int group_id;
  array[N] int abd;
}
parameters{
  vector[N_groups] group_mean;
}
model {
  abd ~ poisson_log(group_mean[group_id]);
  group_mean ~ normal(6, 1);
}