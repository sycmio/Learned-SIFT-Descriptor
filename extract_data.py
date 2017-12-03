
from scipy import misc

imglist='liberty/m50_200000_200000_0.txt'

with open(imglist,'r') as f:
    content=f.read();

lines=content.split('\n')

num=len(lines)-1

f.close()

f=open('label.txt','w');

for i in range(num):
    if (i%1000==0):
       print i

    list=lines[i].split(' ')
    id1=int(list[0])
    id2=int(list[3])
    label=(list[1]==list[4])


    #first patch
    m=id1/256
    count=(id1)%256
    x=(count)%16
    y=count/16
    img=misc.imread('liberty/patches'+str(m).zfill(4)+'.bmp')
    x_=x*64
    y_=y*64
    patch = img[y_:y_ + 64, x_:x_ + 64]
    misc.imsave('pair1/'+str(i)+'.bmp',patch)

    #second patch
    m=id2/256
    count=(id2)%256
    x=(count)%16
    y=count/16
    img=misc.imread('liberty/patches'+str(m).zfill(4)+'.bmp')
    x_=x*64
    y_=y*64
    patch=img[y_:y_+64,x_:x_+64]
    misc.imsave('pair2/'+str(i)+'.bmp',patch)
    f.write(str(int(label)))
