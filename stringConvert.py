file = "out.txt"
with open(file, "w") as img:

    while(True):
        str1 = input()
        if str1 == "a":
            break
        outStr = ""
        for s in str1:
            if s == ' ':
                outStr += "1"
            else:
                outStr += "0"
            
        outStr +="\n"
        img.write(outStr);
        
