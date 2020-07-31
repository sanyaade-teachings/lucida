#!/bin/bash
if [ -z $THREADS ]; then
  THREADS=`nproc`
fi

installCheck () {
#  g++ check_opencv.cpp -o check_opencv
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

if [ ! -d opencv-4.4.0 ]; then
  git clone https://github.com/opencv/opencv.git opencv-4.4.0
  if [ $? -ne 0 ]; then
    echo "Could not clone OpenCV!!! Please try again later..."
    exit 1
  fi
fi
cd "opencv-4.4.0" \
  && git checkout "4.4.0" \
  && mkdir -p build \
  && cd build \
  && cmake ..  \
  && make -j$THREADS \
  && make -j$THREADS install \
  && cd ../../

if installCheck "$0"; then
  echo "OpenCV installed";
  exit 0;
else
  echo "Failed to install OpenCV";
  exit 1;
fi
