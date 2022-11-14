#!/usr/bin/awk -f
{x=$1;y=$2;d+=x>y?x-y:y-x;n+=x+y} 
END {
  print 2*d/n;
}
