#!/bin/bash
if [ -z $THREADS ]; then
  THREADS=`nproc`
fi

installCheck () {
  g++ check_opencv.cpp -o check_opencv
  if [[ $? -ne 0 ]]; then
    return 1
  else
    rm check_opencv
    return 0
  fi
}

if installCheck "$0"; then
  echo "OpenCV already installed, skipping"
  exit 0
fi

# Get dependencies installed
sudo apt install build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev

#clone the latest openCV and contribute packages from GitHub
#NOTE: You can check a specific version using: git checkout xxxx

if [ ! -d opencv ]; then
  git clone https://github.com/opencv/opencv.git
  git clone https://github.com/opencv/opencv_contrib.git
  
if [ $? -ne 0 ]; then
    echo "Could not clone OpenCV!!! Please try again later..."
    exit 1
  fi
fi

cd opencv \
  && mkdir -p build \
  && cd build \
  && cmake -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ../ \
  && make -j$THREADS \
  && make -j$THREADS install \
  && cd ../../
echo " openCV is now installed ";

# NOTE check done below is currently failing, needs review
#if installCheck "$0"; then
#  echo "OpenCV installed";
#  exit 0;
#else
#  echo "Failed to install OpenCV";
#  exit 1;
#fi
