#!/bin/bash

#Note: modified by Sanyaade Adekoya for setting latest MongoDB vesrion 
# and MongoDB C/C++ Drivers
# if you want a specific version then do add the followings
# && git checkout r1.16 \
# && git checkout r3.5.0 \
# && git checkout legacy \
# && mkdir build_ \
#   -DCMAKE_BUILD_TYPE=Release \
#    -DCMAKE_INSTALL_PREFIX=/usr/local \
# g++ check_mongodb.cpp -std=c++11 -I/usr/local/include -L/usr/local/lib -lmongoclient -lboost_thread -lboost_filesystem -lboost_regex -lboost_program_options -lboost_system -pthread -lssl -lcrypto -o check_mongodb

# c++ --std=c++11 test.cpp $(pkg-config --cflags --libs libmongocxx) -Wl,-rpath,/usr/local/lib

# need to clean up this sooner

export MONGO_C_DRIVER_VERSION=1.16.2



installCheck () {
# g++ --std=c++11 check_mongodb_new.cpp -o check_mongodb_new $(pkg-config --cflags --libs libmongocxx)

g++ --std=c++11 check_mongodb_new.cpp -o check_mongodb_new $(pkg-config --cflags --libs libmongocxx) -Wl,-rpath,/usr/local/lib

#g++ --std=c++11 check_mongodb_new.cpp \
 #-I/usr/local/include/mongocxx/v_noabi \
  #  -I/usr/local/include/bsoncxx/v_noabi \
   # -L/usr/local/lib -lmongocxx -lbsoncxx \
   #-o check_mongodb_new

  if [[ $? -ne 0 ]]; then
    return 1
  fi
 if [[ $(./check_mongodb_new | grep "Connection ok") == "Connection ok" ]]; then
    rm check_mongodb_new
    return 0
  else
    return 1
  fi
}

if installCheck "$0"; then
  echo "MongoDB and C++ driver installed";
  exit 0;
fi

# MongoDB.
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
#echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list


apt-get update
apt-get install -y mongodb-org
service mongod start

if [ `ps -ef | grep -cPe "\Wmongod "` -lt 1 ]; then
  cp mongodb.service /lib/systemd/system/mongodb.service
  systemctl enable mongodb.service
  chown -R mongodb:mongodb /var/lib/mongodb
  chown -R mongodb:mongodb /var/log/mongodb
  systemctl start mongodb
fi


# C driver.
apt-get install git gcc automake autoconf libtool
if [ ! -d mongo-c-driver ]; then
  git clone https://github.com/mongodb/mongo-c-driver.git
  if [ $? -ne 0 ]; then
    echo "Could not clone mongo-c-driver!!! Please try again later..."
    exit 1
  fi
fi
cd mongo-c-driver \
 && git checkout r1.16 \
 && cd build \
 && cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF .. \
 && sudo make install \
 && cd ../..
if [ $? -ne 0 ]; then
  echo "Error installing mongo-c-driver!!! Please review the errors above"
  exit 1
fi

# uncomment below line if you need to ==> Upgrade CMake.
#apt-get install -y software-properties-common
#add-apt-repository -y ppa:george-edison55/cmake-3.x
#apt-get -y update
#apt-get install -y cmake
#if [ $? -ne 0 ]; then
#  echo "Error installing cmake-3.x!!! Please review the errors above"
#  exit 1
#fi
#apt-get -y upgrade


# C++ driver.
if [ ! -d mongo-cxx-driver ]; then
  git clone https://github.com/mongodb/mongo-cxx-driver
  if [ $? -ne 0 ]; then
    echo "Could not clone mongo-cxx-driver!!! Please try again later..."
    exit 1
  fi
fi

cd mongo-cxx-driver \
   && git checkout r3.5.0 \
   && cd build \
   && cmake .. \
    -DCMAKE_BUILD_TYPE=Release          \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
   && make \
   && make install \
   && cd ../..

echo "       MongoDB and C++ driver installed     ";
exit 0;

if installCheck "$0"; then
  echo "MongoDB and C++ driver installed";
  exit 0;
else
  echo "Failed to install MongoDB and C++ driver";
  exit 1;
fi
