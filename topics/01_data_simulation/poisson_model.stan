data {
  int<lower=0> n_people;
  array[n_people] int<lower=0> observed;
}
parameters {
  real avg_observed;
}
model {
  observed ~ poisson(avg_observed);
  avg_observed ~ normal(1, 1);
}
generated quantities {
  // an array -- like a list in R
  array[n_people] int<lower=0> observations;
  
  for (i in 1:n_people){
    observations[i] = poisson_rng(avg_observed);
  }
}
