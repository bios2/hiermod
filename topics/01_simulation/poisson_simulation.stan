data {
  int<lower=0> n_people;
}
generated quantities {
  // simulate a population average
  real<lower=0> avg_observed;
  avg_observed = uniform_rng(0, 60);
  // simulate observations with that average
  // an array -- like a list in R
  array[n_people] int<lower=0> observations;
  for (i in 1:n_people){
    observations[i] = poisson_rng(avg_observed);
  }
}
