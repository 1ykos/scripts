#!/usr/bin/awk -f
# two-sample K-S test modified to increase sensitivity at tails
function max(a,b) {
  return a>b?a:b;
}
ARGIND==1{w=NF>1?$2:1;a[$1]+=w;sumw_a+=w}
ARGIND==2{w=NF>1?$2:1;b[$1]+=w;sumw_b+=w}
END{
  asorti(a,as,"@ind_num_asc");
  asorti(b,bs,"@ind_num_asc");
  max_d = 0;
  i = 1;
  j = 1;
  sa = 0;
  sb = 0;
  max_i = 0;
  max_j = 0;
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
    qa = (sa+sumw_a*length(a)**(-1))/(sumw_a*(1+2*length(a)**(-1)));
    qb = (sb+sumw_b*length(b)**(-1))/(sumw_b*(1+2*length(b)**(-1)));
    d *= (length(a)*length(b)*((qa+qb)*((1-qa)+(1-qb)))**(-1))**(0.25);
    #max_d = max(max_d,d);
    if (d>max_d) {
      max_d = d;
      max_i = i;
      max_j = j;
    }
  }
  print max_d,max_i,max_j,as[max_i],bs[max_j];
}
