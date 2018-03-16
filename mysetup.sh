__heredoc__='''
cd ~/code
git clone git@github.com:Erotemic/yolo2-pytorch.git
cd $HOME/code/yolo2-pytorch
sh mysetup.py
'''

mkdir -p $HOME/data/VOC
cd $HOME/data/VOC

# mv $HOME/code/yolo2-pytorch/VOC* $HOME/data/VOC
if [ ! -d "$HOME/data/VOC/VOCdevkit" ]; then
    if [ ! -f "VOCdevkit_08-Jun-2007.tar" ]; then
        wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar
        wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar
        wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCdevkit_08-Jun-2007.tar
    fi
    tar xvf VOCtrainval_06-Nov-2007.tar
    tar xvf VOCtest_06-Nov-2007.tar
    tar xvf VOCdevkit_08-Jun-2007.tar
fi

cd $HOME/code/yolo2-pytorch
./make.sh

if [ ! -d "$HOME/code/yolo2-pytorch/data/VOCdevkit2007" ]; then
    cd $HOME/code/yolo2-pytorch
    mkdir -p $HOME/code/yolo2-pytorch/data
    cd $HOME/code/yolo2-pytorch/data
    unlink VOCdevkit2007
    ln -s $HOME/data/VOC/VOCdevkit VOCdevkit2007
fi 

if [ ! -d "$HOME/code/yolo2-pytorch/data/darknet19.weights.npz" ]; then
    cd $HOME/code/yolo2-pytorch/data
    wget http://acidalia.kitware.com:8000/weights/darknet19.weights.npz
fi


# Train a model
run_train(){
    cd $HOME/code/yolo2-pytorch
    python train.py
}
