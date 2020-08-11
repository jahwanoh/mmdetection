#!/bin/bash
####
# source ~/venv/bepro-video-util/bin/activate

pip install torch==1.3.1 torchvision==0.4.2
pip install cython
pip install pycocotools==2.0.0
pip install mmcv==0.6.2

# pip install -v -e .

mkdir data
ln -s $COCO_ROOT data

/snap/bin/gsutil -m cp gs://bepro-server-storage/dsort_tracking_data/installation/nccl-repo-ubuntu1804-2.6.4-ga-cuda10.0_1-1_amd64.deb .
sudo dpkg -i nccl-repo-ubuntu1804-2.6.4-ga-cuda10.0_1-1_amd64.deb
sudo apt update
sudo apt install libnccl2=2.4.8-1+cuda10.0 libnccl-dev=2.4.8-1+cuda10.0

/snap/bin/gsutil -m cp gs://bepro-server-storage/dsort_tracking_data/checkpoints/crcnn_r50_bepro_stitch.pth .

mkdir demo/dump

## nvcc fatal : Unsupported gpu architecture 'compute_75'
# export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}^C
# export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
python setup.py develop

cp -r configs ~/bepro-video-util 
cp crcnn_r50_bepro_stitch.pth ~/bepro-video-util

## test with
# python demo/mmdetection_demo.py PVO4R8Dh-trim.mp4 configs/cascade_rcnn/cascade_rcnn_r50_fpn_1x_bepro.py crcnn_r50_bepro_stitch.pth 0 1000 ./tmp/
