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
  for(i=0;i<n;++i) {
    r=0;
    for (j=0;j!=6;++j) {
      r+=rand()-rand();
    }
    print s*r+m;
  }
}
