#!/usr/bin/awk -f
BEGIN{n=0}
{
  for (i=1;i<=NF;++i) {
    m[n++]=$i;
    if (n==9) exit;
  }
}
END{
  a = m[0];
  b = m[1];
  c = m[2];
  d = m[3];
  e = m[4];
  f = m[5];
  g = m[6];
  h = m[7];
  i = m[8];
  A = (e*i-f*h);
  B =-(d*i-f*g);
  C = (d*h-e*g);
  D =-(b*i-c*h);
  E = (a*i-c*g);
  F =-(a*h-b*g);
  G = (b*f-c*e);
  H =-(a*f-c*d);
  I = (a*e-b*d);
  idet = 1.0/(a*A + b*B + c*C);
  print A*idet, D*idet, G*idet;
  print B*idet, E*idet, H*idet;
  print C*idet, F*idet, I*idet;
}
