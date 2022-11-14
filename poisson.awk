#!/bin/awk -f
function poisson(l){
  L = exp(-l);
  p = 1.0;
  for (k=0;p>L;++k) p*=rand();
  return k-1;
};
BEGIN{
  l = ARGC>1?ARGV[1]:1.0;
  n = ARGC>2?int(ARGV[2]):1;
  if (ARGC>3) srand(ARGV[3]);
  for (i=0;i!=n;++i) print poisson(l);
  delete ARGV;
}
