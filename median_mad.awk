#!/bin/awk -f
{ a[NR]=$1; }
END{
  asort(a,a,"@val_num_asc");
  median=0.5*(a[1+int((length(a)-1)/2)]+a[1+int(length(a)/2)]);
  for (i=1;i<=length(a);++i) a[i]=a[i]>median?a[i]-median:median-a[i];
  asort(a,a,"@val_num_asc");
  mad=   0.5*(a[1+int((length(a)-1)/2)]+a[1+int(length(a)/2)]);
  print median,mad,mad/sqrt(NR);
}
