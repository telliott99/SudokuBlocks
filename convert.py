fn = "src.txt"
FH = open(fn)
data = FH.read().strip().split("\n")
FH.close()

def f(s):
    s = s.strip()
    L = s.split()
    t = L[0]
    s = L[-1].replace("'","")
    return (t,s)

for item in data:
    t,s = f(item)
    print "\t<key>" + t + "</key>"
    print "\t<string>" + s + "</string>"