import sys

def comp(s):
    compdict = {"A":"T", "T":"A", "C":"G", "G":"C", "N":"N","a":"t","t":"a","c":"g","g":"c","n":"n"}
    retstr = ""
    for i in range(0,len(s)):
        retstr += compdict[s[i]]
    return retstr
  
fh = open(sys.argv[1],'r')

scaf = ">"+sys.argv[2].strip()

pr = 0
mystr = ""
for line in fh:
    if line.split(' ')[0] == scaf or line.strip() == scaf:
        pr = 1
        print line.strip()
        continue
    if pr ==1 and line[0] != ">":
        mystr += line.strip()
    if line[0] == ">" and pr == 1:
        break
 
mystr = mystr[::-1]
mystr = comp(mystr.upper())

i = 0
while i < len(mystr):
    print mystr[i:(i+100)]
    i += 100  
 
