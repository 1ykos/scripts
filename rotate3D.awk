#!/usr/bin/awk -f
BEGIN{
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
  print m0*$1+m1*$2+m2*$3,m3*$1+m4*$2+m5*$3,m6*$1+m7*$2+m8*$3;
}
