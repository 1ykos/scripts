#!/bin/awk -f
function gauss_cdf(x,m,v){
  return 0.5*(1+erf((x-m)/sqrt(2*v)));
}
function gauss_integral(x,m,v,a,b){
  return gauss_integral(b,m,v)-gauss_integral(a,m,v);
}
{
  # weights ideally are inverse standard deviations or proportional to density
  sumw += (w=(NF>1)?$2:1);
  sumw2+=  w*w;
  a[$1]+=  w;
}
END{
  if (NR==0) {
    print 0,0,0;
    exit;
  }
  asorti(a,b,"@ind_num_asc");
  t=0;
  for (i=1;i<=length(b);++i) if ((t+=a[b[i]])>=sumw*0.5) break;
  median0=b[i];
  asorti(a,b,"@ind_num_desc");
  t=0;
  for (i=1;i<=length(b);++i) if ((t+=a[b[i]])>=sumw*0.5) break;
  median1=b[i];
  median = (median0*a[median0]+median1*a[median1])/(a[median0]+a[median1]);
  v = 0;
  n = length(b);
  d = 0;
  t = 0;
  s2 = 0.25*sumw2/sumw**2;
  is2 = 1.0/s2;
  for (i=1;i<=n;++i) {
    #e = -0.5*((t+0.5*a[b[i]]*(1-((b[i]>median)-(b[i]<median))))/sumw-0.5)**2*is2;
    e = -0.5*((t+0.5*a[b[i]])/sumw-0.5)**2*is2;
    t+=  a[b[i]];
    if (e<-700) continue;
    w =  exp(e)*a[b[i]];
    #print w, b[i];
    v += w*(b[i]-median)**2;
    d += w;
  }
  #c[0] = 0;
  #for (i=1;i<int(NR/2);++i) {
  #  c[i] = c[i-1]+log(NR-1-i+1)-log(i);
  #}
  #c[NR-1] = 0;
  #for (i=NR-2;i>=int(NR/2);--i) {
  #  c[i] = c[i+1]-log(NR-1-i)+log(i+1);
  #}
  #for (i=0;i!=NR;++i) {
  #  e = c[i]-(NR-1)*log(2);
  #  if (e<-700) continue;
  #  w =  exp(e)*a[b[i]];
  #  v += w*(b[i]-median)**2;
  #  d += w;
  #}
  print median,v/d
}
