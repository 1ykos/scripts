#!/usr/bin/awk -f
BEGIN{
  c=ARGV[1];
  n=ARGV[2];
  srand();
  for(i=0;i!=n;++i) {
    a=sqrt(3)*(rand()+rand()+rand()+rand()-2);
    x=a+sqrt(3)*(rand()+rand()+rand()+rand()-2)*c;
    y=a+sqrt(3)*(rand()+rand()+rand()+rand()-2)*c;
    print x,y
  }
}
