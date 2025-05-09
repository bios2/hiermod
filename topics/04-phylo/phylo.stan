data {
  int n;
  int s;
  vector[n] x;
  vector[n] y;
  matrix[s, s] phyvcv;
}
parameters {
  real b0;
  real b1;
  real sigma_x;
  real sigma_y;
  real logit_lambda_x;
  real logit_lambda_y;
}
transformed parameters {
  real<lower=0,upper=1> lambda_x;
  lambda_x = inv_logit(logit_lambda_x);
  // y
  real<lower=0,upper=1> lambda_y;
  lambda_y = inv_logit(logit_lambda_y);
}
model {
  b0 ~ std_normal();
  b1 ~ normal(.5, .5);
  sigma_x ~ exponential(1);
  sigma_y ~ exponential(1);
  logit_lambda_x ~ normal(3, .2);
  logit_lambda_y ~ normal(0, .2);

  matrix[s, s] vcv_x;
  vcv_x = add_diag(sigma_x^2*lambda_x*phyvcv, sigma_x^2*(1 - lambda_x));


  matrix[s, s] vcv_y;
  vcv_y = add_diag(sigma_y^2*lambda_y*phyvcv, sigma_y^2*(1 - lambda_y));


  x ~ multi_normal(rep_vector(0, n), vcv_x);
  y ~ multi_normal(b0 + b1*x, vcv_y);
}
