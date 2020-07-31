# a quick and dirty packages installation testing script

sudo apt-get update -y

sudo apt-get install -y \
    g++ \
    cmake \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libiberty-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    pkg-config \
    libunwind-dev

# needed for fizz environment
sudo apt-get install -y \  
    pkg-config \
    libsodium-dev

# needed for fbthrift environment:
sudo apt-get install -y libpthread-stubs0-dev
sudo apt-get install -y openssl
sudo apt-get install -y python-six
sudo apt install -y python3-six
sudo pip install -U six
 
# Perform systems update
sudo apt-get update -y

### ============================================================

# build and install wangle: 
  git clone https://github.com/facebook/wangle
  cd wangle/wangle
  cmake .
  make
  ctest
  sudo make install
  echo "Facebook Wangle is installed";
  cd ../..

# lastly build and install faceboo fbthrift:
  git clone https://github.com/facebook/fbthrift
  cd fbthrift/build
  cmake .. # Add -DOPENSSL_ROOT_DIR for macOS. Usually in /usr/local/ssl
  make     # or cmake --build .

echo "Facebook fbthrift is installed";
exit 0;

