data {
  int<lower=0> n;
  int<lower=0> s;
  vector[n] x;
  vector[n] y;
  cov_matrix[s] phyvcv;
}
transformed data {
  vector[n] zero_vec = rep_vector(0, n);
}
parameters {
  real b0;
  real<offset=0.5, multiplier=0.5> b1;
  real<lower=0> sigma_x;
  real<lower=0> sigma_y;
  real<lower=0,upper=1> lambda_x;
  real<lower=0,upper=1> lambda_y;
}
model {
  b0 ~ std_normal();
  b1 ~ normal(0.5, 0.5);
  sigma_x ~ exponential(1);
  sigma_y ~ exponential(1);
  lambda_x ~ beta(9, 1);
  lambda_y ~ beta(5, 5);

  matrix[s, s] vcv_x
    = sigma_x^2 * add_diag(lambda_x * phyvcv, 1 - lambda_x);
  matrix[s, s] vcv_y
    = sigma_y^2 * add_diag(lambda_y * phyvcv, 1 - lambda_y);
  x ~ multi_normal(zero_vec, vcv_x);
  y ~ multi_normal(b0 + b1 * x, vcv_y);
}
