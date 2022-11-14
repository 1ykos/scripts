#!/usr/bin/awk -f
{sxy+=($1*$2); sx+=$1; sy+=$2; sxx+=($1*$1); syy+=($2*$2);} 
END {
#  print "sx \t sxx \t sy \t syy \t sxy \t n" > "/dev/stderr"
#  print sx,"\t",sxx,"\t",sy,"\t",syy,"\t",sxy,"\t",NR > "/dev/stderr"
  ssx  = sxx - ((sx*sx)/NR);
  ssy  = syy - ((sy*sy)/NR); 
  ssxy = sxy - ((sx*sy)/NR);
  r=ssxy/sqrt(ssx*ssy);
  print r;
}
