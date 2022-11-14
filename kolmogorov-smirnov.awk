#!/usr/bin/awk -f
# two-sample K-S test
# ks(x,k)=(k<=0)?0:(exp(-(2*k-1)**2*pi**2/(8*x**2))*sqrt(2*pi)/x+ks(x,k-1))
ARGIND==1{w=NF>1?$2:1;a[$1]+=w;sumw_a+=w}
ARGIND==2{w=NF>1?$2:1;b[$1]+=w;sumw_b+=w}
END{
  asorti(a,as,"@ind_num_asc");
  asorti(b,bs,"@ind_num_asc");
  max = 0;
  i = 1;
  j = 1;
  sa = 0;
  sb = 0;
  while ((i<=length(a))&&(j<=length(b))) {
    inc = 0;
    while (as[i]<=bs[j]) {
      sa+=a[as[i]];
      ++i;
      inc = 1;
      if (i>length(a)) break;
    }
    if (inc==0) {
      while (as[i]>=bs[j]) {
        sb+=b[bs[j]];
        ++j;
        inc = 1;
        if (j>length(b)) break;
      }
    }
    if (inc==0) {
      if (i<length(a)) {
        inc = 1;
        ++i;
      } else {
        if (j<length(b)) {
          inc = 1;
          ++j;
        } else {
          break;
        }
      }
    }
    d = (sa*sumw_b - sb*sumw_a)/(sumw_a*sumw_b);
    d = d<0?-d:d;
    max = d>max?d:max;
  }
  print max*(length(a)*length(b))**(0.25);
}
