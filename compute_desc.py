from net1 import SiameseNetwork
from torchvision import transforms
from PIL import Image
import torch
from torch.autograd import Variable
import scipy.io

def compute_desc():
    net=SiameseNetwork()
    #
    net.load_state_dict(torch.load('model.pt'))
    transform=transforms.ToTensor()
    img=Image.open('tmp.bmp')
    img=img.convert('L')
    img=transform(img)
    img=img.unsqueeze(0)
    img.view(img.size()[0],-1)
    _,output=net(Variable(img),Variable(img))
    #
    mat=output.data.numpy()

    scipy.io.savemat('learned_desc.mat',mdict={'learned_desc':mat})
    #print mat.tolist()
    return 0
if __name__ == "__main__":
    compute_desc()

