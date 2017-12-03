from torch.utils.data import DataLoader
import torchvision
import torch
import  matplotlib.pyplot as plt
import torchvision.transforms as transforms
import numpy as np
import torchvision.datasets as dset
from SiameseNetworkDataset import SiameseNetworkDataset



def imshow(img,text,should_save=False):
    npimg = img.numpy()
    plt.axis("off")
    if text:
        plt.text(75, 8, text, style='italic',fontweight='bold',
            bbox={'facecolor':'white', 'alpha':0.8, 'pad':10})
    plt.imshow(np.transpose(npimg, (1, 2, 0)))
    plt.show()

f=open('label.txt','r');
label=f.read()
dataset=SiameseNetworkDataset('.',label,transform=transforms.ToTensor())

vis_dataloader=DataLoader(dataset,shuffle=True,batch_size=8)
dataiter=iter(vis_dataloader)
example_batch = next(dataiter)
concatenated = torch.cat((example_batch[0],example_batch[1]),0)
imshow(torchvision.utils.make_grid(concatenated),'img')
print(example_batch[2].numpy())