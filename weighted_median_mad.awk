#!/bin/awk -f
BEGIN{
  sumw=0;
}
{
  a[$1]+=$2;
  sumw +=$2;
  sumw2+=$2*$2;
}
END{
  if (NR==0) {
    print 0,0,0;
    exit;
  }
  asorti(a,b,"@ind_num_asc");
  median=b[1];
  t=0;
  for (i=1;i<=length(b);++i) {
    median = b[i];
    if (t<sumw/2) {
      t+=a[b[i]];
    } else {
      break;
    }
  }
  for (v in a) c[v<median?median-v:v-median]+=a[v];
  asorti(c,d,"@ind_num_asc");
  mad = 0;
  t = 0;
  for (i=1;i<=length(d);++i) {
    mad = d[i];
    if (t<sumw/2) {
      t+=c[d[i]];
    } else {
      break;
    }
  }
  sqineff = sqrt(sumw2)/sumw;
  print median,mad,mad*sqineff;
}
