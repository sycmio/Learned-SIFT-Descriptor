from net1 import SiameseNetwork
from torchvision import transforms
from PIL import Image
import torch
from torch.autograd import Variable
import scipy.io
import time
import numpy as np
def compute_desc():
    net=SiameseNetwork().cuda()

    net.load_state_dict(torch.load('model.pt'))
    net.train(False)
    # transform=transforms.ToTensor()
    imgs=scipy.io.loadmat('patch.mat')['patches']
    N=len(imgs)
    mat=np.zeros([N-1,128])
    for i in range(N-1):
        img=imgs[i]
        img=img.reshape(1,1,img.shape[0],img.shape[1])
        X=torch.from_numpy(img)

        _,output=net(Variable(X.float()).cuda(),Variable(X.float()).cuda())

        #print 'time:'+str(end-start)
        mat[i]=output.data.cpu().numpy()
    scipy.io.savemat('learned_desc.mat',mdict={'desc':mat})
    # print mat.tolist()
    return 0
if __name__ == "__main__":
    compute_desc()

