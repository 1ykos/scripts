#!/bin/awk -f
BEGIN{
  mean = 0;
  mean2= 0;
  var  = 0;
  var2 = 0;
  sumw = 0;
  sumw2= 0;
  sumws= 0;
}
{
  i     = NR-1;
  x     = $1;
  w     = $2+(NF<2);
  sumw += w;
  sumw2+= w*w;
  sumws+= w*w*((w>0)-(w<0));
  dx    = x-mean;
  dx2   = x-mean2;
  mean += dx *w  /sumw;
  mean2+= dx2*w*w/sumw2;
  var  += ((x-mean )*dx -var )*w  /sumw;
  var2 += ((x-mean2)*dx2-var2)*w*w/sumw2;
}
END{
  var  = var <0?-var :var ;
  var2 = var2<0?-var2:var2;
  #ineff = sumw2/sumw**2; # sumw**2*sumw**(-1)
  ineff = sumws/sumw**2;
  bessel_correction = 1;
  #if (bessel_correction) ineff = sumw2/(sumw**2-sumw2);
  if ((bessel_correction)&&(sumw**2>sumws)) ineff = sumws/(sumw**2-sumws);
  print mean, var, var*ineff,(var2+(mean-mean2)**2)*ineff
  # mean
  # expected variance of the samples
  # variance of the weighted mean when the weights are independend of the variance, for unbiased use var*(sumw2*(sumw**2-sumw2)**(-1))
  # square weighted variance divided by effective sample size
}
