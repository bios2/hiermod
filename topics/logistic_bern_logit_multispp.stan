data {
  // number of rows in dataset
  int<lower=0> n;
  // number of species
  int<lower=0> S;
  // one environmental variable to use in prediction
  vector[n] x;
  // response site (rows) by species (columns) 2D array
  array[n,S] int<lower=0,upper=1> y;
}
parameters {
  // parameters are now VECTORS
  vector[S] intercept;
  vector[S] slope;
}
model {
  for (s in 1:S){
    y[,s] ~ bernoulli_logit(intercept[s] + slope[s] * x);
  }
  // priors don't change because Stan is vectorized:
  // every element of the vector gets the same prior
  intercept ~ std_normal();
  slope ~ std_normal();
}

