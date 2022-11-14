#!/usr/bin/awk -f
BEGIN{
  a = ARGV[1];
  x = ARGV[2];
  y = ARGV[3];
  z = ARGV[4];
  delete ARGV;
  c = cos(a);
  s = sin(a);
  t = 1-c;
  n = 1.0/sqrt(x*x+y*y+z*z);
  x*=n;
  y*=n;
  z*=n;
  m0 = t*x*x + c;
  m1 = t*x*y - z*s;
  m2 = t*x*z + y*s;
  m3 = t*x*y + z*s;
  m4 = t*y*y + c;
  m5 = t*y*z - x*s;
  m6 = t*x*z - y*s;
  m7 = t*y*z + x*s;
  m8 = t*z*z + c;
}
{
  print m0*$1+m1*$4+m2*$7,m0*$2+m1*$5+m2*$8,m0*$3+m1*$6+m2*$9,
        m3*$1+m4*$4+m5*$7,m3*$2+m4*$5+m5*$8,m3*$3+m4*$6+m5*$9,
        m6*$1+m7*$4+m8*$7,m6*$2+m7*$5+m8*$8,m6*$3+m7*$6+m8*$9;
}
