#worksheet just goes over general syntax of R

#typical KRR formula
t(train.labels) %*% solve(K+diag(a,n)) %*% k