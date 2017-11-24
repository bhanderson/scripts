#!/usr/bin/python3
import os
import datetime
import time
import csv

print('running test')
a = os.popen("python /home/bhanderson/speedtest-cli --simple").read()
print('ran')
lines = a.split('\n')
ts = time.time()
date = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
#print(a)
if "Cannot" in a:
    p = 999
    d = 0
    u = 0
else:
    p = lines[0].split(' ')[1]
    d = lines[1].split(' ')[1]
    u = lines[2].split(' ')[1]
print("{0},{1},{2},{3}".format(date,p,d,u))
outfile = open('outfile.csv', 'a')
writer = csv.writer(outfile)
writer.writerow((ts*1000,p,d,u))
outfile.close()
