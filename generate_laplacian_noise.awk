#!/usr/bin/awk -f
BEGIN{
  if (1 in ARGV) m=ARGV[1];
  else           m=0;
  if (2 in ARGV) s=ARGV[2];
  else           s=1;
  if (3 in ARGV) n=ARGV[3];
  else           n=1;
  if (4 in ARGV) srand(ARGV[4]);
  else           srand();
  for (i=0;i!=n;++i) {
    r=2*rand()-1;
    x=r;
    if (r>0) {
      x = -log(r);
    }
    if (r<0) {
      x =  log(-r);
    }
    print s*x+m;
  }
}
