data {
  // number of rows in dataset
  int<lower=0> Nsites;
  // number of species
  int<lower=0> Nspp;
  // one environmental variable to use in prediction
  vector[Nsites*Nspp] x;
  // species ids
  array[Nsites*Nspp] int spp_id;
  // site ids
  array[Nsites*Nspp] int site_id;
  // response site (rows) by species (columns) 2D array
  array[Nsites*Nspp] int <lower=0> y;
}
parameters {
  real b0;
  vector[Nspp] b0_sp;
  real<lower=0> sd_b0_sp;
  // vector[Nsites] b0_site;
  // real<lower=0> sd_b0_site;
  vector[Nspp] b_water_sp;
  real mu_b_water_sp;
  real<lower=0> sd_b_water_sp;
}
generated quantities {
  
  vector[Nsites*Nspp] presabs_pred;
  
  presabs_pred = log1m_exp(b0 + //b0_site[site_id] + 
  b0_sp[spp_id] + b_water_sp[spp_id] .* x);
  
}

