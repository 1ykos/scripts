#!/bin/awk -f
function log_choose(n,k) {
  if (k<0.5) return 0; # not stricly correct, but this is awk, come on
  return log_choose(n-1,k-1)+log(n)-log(k);
}
function choose(n, k) {
  if (k<0.5) return 1; # not stricly correct, but this is awk, come on
  return (n*choose(n-1,k-1))/k;
}
{x[NR-1]=$1}
END{
  asort(x,x,"@val_num_asc");
  for (i=0;i!=NR;++i) x[i]=x[i+1];
  median = 0.5*(x[int((NR-1)/2)]+x[int((NR+0)/2)]);
  v = 0;
  d = 0;
  c[0] = 0;
  for (i=1;i<int(NR/2);++i) {
    c[i] = c[i-1]+log(NR-1-i+1)-log(i);
  }
  c[NR-1] = 0;
  for (i=NR-2;i>=int(NR/2);--i) {
    c[i] = c[i+1]-log(NR-1-i)+log(i+1);
  }
  for (i=0;i!=NR;++i) {
    e = c[i]-(NR-1)*log(2);
    if (e<-700) continue;
    e = exp(e);
    v += e*(x[i]-median)**2;
  }
  m = int((NR-1)/2)-int(sqrt(NR+1)*0.5);
  p = int((NR+0)/2)+int(sqrt(NR+1)*0.5);
  print median,v,0.25*(x[p]-x[m])**2
}
