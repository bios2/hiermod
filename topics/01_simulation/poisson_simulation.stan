data {
  int<lower=0> n_people;
}
generated quantities {
  real<lower=0> avg_birds_per_person;
  // an array -- like a list in R
  array[n_people] int<lower=0> bird_count;
  
  // simulate averages
  avg_birds_per_person = uniform_rng(0, 60);
  // simulate observations with that average
  for (i in 1:n_people){
    bird_count[i] = poisson_rng(avg_birds_per_person);
  }
}
