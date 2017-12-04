from net1 import SiameseNetwork
from torchvision import transforms
from PIL import Image
import torch
from torch.autograd import Variable
import scipy.io
import time
import numpy as np
def compute_desc():
    net=SiameseNetwork()

    net.load_state_dict(torch.load('model.pt'))
    transform=transforms.ToTensor()
    imgs=scipy.io.loadmat('patch.mat')['patches']
    imgs=imgs.reshape(imgs.shape[0],1,imgs.shape[1],imgs.shape[2])
    imgs=np.delete(imgs,[imgs.shape[0]-1],axis=0)
    X=torch.from_numpy(imgs)
    _,output=net(Variable(X.float()),Variable(X.float()))

    #print 'time:'+str(end-start)
    mat=output.data.numpy()
    scipy.io.savemat('learned_desc.mat',mdict={'desc':mat})
    # print mat.tolist()
    return 0
if __name__ == "__main__":
    compute_desc()

