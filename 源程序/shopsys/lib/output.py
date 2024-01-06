import os
fileList = os.walk("./")
ff = open("代码.md",'w',encoding='utf-8')
for i in fileList:
    for j in i[2]:
        if 'dart' not in j:
            continue
        print(i[0][2:]+'/'+j)
        ff.write("##"+i[0][2:]+'/'+j+'\n')
        ff.write("```dart\n")
        f = open('./'+i[0][2:]+'/'+j,encoding='utf-8')
        ff.write(f.read())
        ff.write("\n```\n")
        f.close()
ff.close()
