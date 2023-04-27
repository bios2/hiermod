data {
  int<lower=0> n_people;
  real avg_observed;
}
generated quantities {
  // an array -- like a list in R
  array[n_people] int<lower=0> observations;
  
  for (i in 1:n_people){
    observations[i] = poisson_rng(avg_observed);
  }
}
