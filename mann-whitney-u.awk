#!/usr/bin/awk -f
# two-sample Mann-Whitney-U test
BEGIN{n=0;m=0}
ARGIND==1{a[n++]=$1}
ARGIND==2{b[m++]=$1}
END{
  u = 0;
  for (j in b) {
    for (i in a) {
      #u += a[i]>b[j];
      #u -= a[i]<b[j]; # ()*2-1 for typical formulation of U 
      u += b[j]<a[i];
      u -= b[j]>a[i]; # ()*2-1 for typical formulation of U 
    }
  }
  s = sqrt(n*m*(n+m+1)/3);
  print u/s;
}
