data {
  int<lower=0> N;
  array[N] int y;
  int<lower=0> Nsite;
  array[N] int<lower=0, upper=Nsite> site_id;
  int<lower=0> Nspp;
  array[N] int<lower=0, upper=Nspp> spp_id;
}
parameters {
  real b_avg;
  vector[Nsite] b_site;
  vector[Nspp] b_spp;
  real<lower=0> sigma_spp;
}
model {
  y ~ bernoulli_logit(b_avg + b_site[site_id] + b_spp[spp_id]);
  b_spp ~ normal(0, .2);
  b_spp ~ normal(0, sigma_spp);
  b_avg ~ normal(0, .5);
  sigma_spp ~ exponential(2);
}
generated quantities {
  matrix[Nspp, Nsite] prob_occurence;
  
  for (i in 1:Nspp){
    for (j in 1:Nsite) {
      prob_occurence[i,j] = b_avg + b_site[j] + b_spp[i];
    }
  }
}
