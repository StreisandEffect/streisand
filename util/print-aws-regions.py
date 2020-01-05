#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Generate code fragments for amazon.yml

names = (
    ("us-east-1",      "US East",      "N. Virginia"),
    ("us-east-2",      "US East",      "Ohio"),
    ("us-west-1",      "US West",      "N. California"),
    ("us-west-2",      "US West",      "Oregon"),
    ("ca-central-1",   "Canada",       "Central"),
    ("eu-central-1",   "EU",           "Frankfurt"),
    ("eu-west-1",      "EU",           "Ireland"),
    ("eu-west-2",      "EU",           "London"),
    ("eu-west-3",      "EU",           "Paris"),
    ("ap-northeast-1", "Asia Pacific", "Tokyo"),
    ("ap-northeast-2", "Asia Pacific", "Seoul"),
    ("ap-northeast-3", "Asia Pacific", "Osaka-Local"),
    ("ap-southeast-1", "Asia Pacific", "Singapore"),
    ("ap-southeast-2", "Asia Pacific", "Sydney"),
    ("ap-south-1",     "Asia Pacific", "Mumbai"),
    ("ap-east-1",      "Asia Pacific", "Hong Kong"),
    ("eu-north-1",     "EU",           "Stockholm"),
    ("sa-east-1",      "South America", "São Paulo"),
)

sorted_names = sorted(names)

print("")
print ("""
    regions:""")
for i in range(len(sorted_names)):
    j = i + 1
    o = sorted_names[i]
    print('      "{j}": "{symname}"'.format(j=j, symname=o[0]))

print ("----------------------")

print ("")
print ("""
        In what region should the server be located?""")
for i in range(len(sorted_names)):
    j = i + 1
    o = sorted_names[i]
    print("          {j:>2}. {symname:<15} {region:<14} ({nickname})".format(
        j=j, symname=o[0], region=o[1], nickname=o[2]))
