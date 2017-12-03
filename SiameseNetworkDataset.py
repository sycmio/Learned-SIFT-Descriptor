from torch.utils.data import Dataset
import torch
import numpy as np
from PIL import Image
class SiameseNetworkDataset(Dataset):
    def __init__(self, root_dir, label, transform=None):
        self.root_dir = root_dir
        self.label = label
        self.transform=transform
    def __getitem__(self, index):

        img0 = Image.open(self.root_dir + '/pair1/' + str(index) + '.bmp')
        img1 = Image.open(self.root_dir + '/pair2/' + str(index) + '.bmp')

        img0=img0.convert("L")
        img1=img1.convert("L")

        if self.transform is not None:
            img0=self.transform(img0)
            img1=self.transform(img1)

        return img0,img1, torch.from_numpy(np.array([int(self.label[index])],dtype=np.float32))
    def __len__(self):
        return len(self.label)


