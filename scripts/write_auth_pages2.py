import os, sys
BASE = "/Users/vince/Codes/Anchor/web/src/pages"

LOGIN = open("/Users/vince/Codes/Anchor/scripts/_login.tsx","r").read()
REGISTER = open("/Users/vince/Codes/Anchor/scripts/_register.tsx","r").read()

with open(os.path.join(BASE,"LoginPage.tsx"),"w",encoding="utf-8") as f: f.write(LOGIN)
with open(os.path.join(BASE,"RegisterPage.tsx"),"w",encoding="utf-8") as f: f.write(REGISTER)
print("Done")
