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
  abd ~ poisson_log(6 + group_mean[group_id]*.7);
  group_mean ~ std_normal();
}
