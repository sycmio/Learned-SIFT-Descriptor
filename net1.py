import torch.nn as nn

class SiameseNetwork(nn.Module):
    def __init__(self):
        super(SiameseNetwork, self).__init__()
        self.cnn1 = nn.Sequential(
            nn.Conv2d(1,32, kernel_size=7),
            nn.MaxPool2d(2,stride=2),
            nn.ReLU(inplace=True),
            nn.Conv2d(32, 64, kernel_size= 6),
            nn.MaxPool2d(3,stride=3),
            nn.ReLU(inplace=True),
            nn.Conv2d(64,128,kernel_size= 5,),
            nn.MaxPool2d(4, stride=4)
        )
        self.fc1=nn.Sequential(
            nn.Linear(128,128)
        )
    def forward_once(self,x):
        output=self.cnn1(x)
        output=output.view(output.size()[0],-1)
        output =self.fc1(output)
        return output

    def forward(self, input1,input2):
        output1=self.forward_once(input1)
        output2=self.forward_once(input2)
        return output1,output2


