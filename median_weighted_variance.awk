#!/bin/awk -f
BEGIN{
}
{
  a[$1]+=$2;
  sumw +=$2;
  sumw2+=$2*$2
  sumw3+=$2*$2*$2;
}
END{
  asorti(a,b,"@ind_num_asc");
  tmp=0;
  for (i=1;i<=NR;++i) {
    tmp+=a[b[i]];
    if (tmp>sumw/2) break;
  }
  median = b[i];
  min = 0;
  if (i>1) {
    tmp = b[i-1]-median;
    tmp = tmp>0?tmp:-tmp;
    min+= tmp;
  }
  if (i<NR) {
    tmp = b[i+1]-median;
    tmp = tmp>0?tmp:-tmp;
    min+= tmp;
  }
  for (v in a) {
    tmp = v-median;
    tmp = tmp>0?tmp:-tmp;
    c[tmp]+=a[v];
  }
  asorti(c,b,"@ind_num_asc");
  tmp=0;
  for (i=1;i<=NR;++i) {
    tmp+=c[b[i]];
    if (tmp>sumw/2) break;
  }
  for (;i<=NR;++i) if (b[i]>0) break;
  mad = b[i];
  #print median,sqrt(min**2+mad**2*(sumw2/sumw**2));
  print median,sqrt(min**2+mad**2*sqrt(sumw3/sumw**3));
  #print median,sqrt(min**2+mad**2*(sumw2/sumw**2)**0.75);
  #print median,sqrt(min**2+mad**2*sqrt(sumw3/sumw**3)**0.75);
}
