from net1 import SiameseNetwork
from torchvision import transforms
from PIL import Image
import torch
from torch.autograd import Variable

net=SiameseNetwork()

net.load_state_dict(torch.load('model.pt'))
transform=transforms.ToTensor()
img=Image.open('tmp.bmp')
img=img.convert('L')
img=transform(img)
img=img.unsqueeze(0)
img.view(img.size()[0],-1)
_,output=net(Variable(img),Variable(img))
print output


