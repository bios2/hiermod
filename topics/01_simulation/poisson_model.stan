data {
  int<lower=0> n_people;
  array[n_people] int<lower=0> bird_count_observed;
}
parameters {
  real avg_birds_per_person;
}
model {
  bird_count_observed ~ poisson(avg_birds_per_person);
  avg_birds_per_person ~ normal(1, 1);
}
generated quantities {
  // an array -- like a list in R
  array[n_people] int<lower=0> bird_count;
  
  // simulate observations with that average
  for (i in 1:n_people){
    bird_count[i] = poisson_rng(avg_birds_per_person);
  }
}
