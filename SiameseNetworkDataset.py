from torch.utils.data import Dataset
import torch
import numpy as np
from PIL import Image

import random
class SiameseNetworkDataset(Dataset):
    def __init__(self, imageFolderDataset, transform=None):
        # self.root_dir = root_dir
        # self.label = label
        # self.transform=transform
        self.imageFolderDataset=imageFolderDataset
        self.transform=transform
    def __getitem__(self, index):

        # img0 = Image.open(self.root_dir + '/pair1/' + str(index) + '.bmp')
        # img1 = Image.open(self.root_dir + '/pair2/' + str(index) + '.bmp')
        #
        # img0=img0.convert("L")
        # img1=img1.convert("L")
        #
        # if self.transform is not None:
        #     img0=self.transform(img0)
        #     img1=self.transform(img1)
        #
        # return img0,img1, torch.from_numpy(np.array([int(self.label[index])],dtype=np.float32))

        img0_tuple=random.choice(self.imageFolderDataset.imgs)
        should_get_same_patch=random.randint(0,1)
        image0=Image.open(img0_tuple[0])
        if should_get_same_patch:
            image1=image0
        else:
            img1_tuple = random.choice(self.imageFolderDataset.imgs)
            while img1_tuple[0]!=img0_tuple[0]:
                break
            image1=Image.open(img1_tuple[0])

        x=random.randint(0,359)
        image1=image1.rotate(x)

        image0 = image0.convert('L')
        image1 = image1.convert('L')

        if self.transform is not None:
            image0=self.transform(image0)
            image1=self.transform(image1)
        return image0, image1, torch.from_numpy(np.array([should_get_same_patch],dtype=np.float32))

    def __len__(self):
        return len(self.imageFolderDataset.imgs)


