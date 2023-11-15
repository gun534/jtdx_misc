#!/bin/bash

if [ $# -ne 2 ]; then
  echo "[Usage] jtdx_setup.sh [username] [root password(for sudo)]" 1>&2
  exit 1
fi

echo "username: $1"
echo "root password(for sudo): $2"
read -p "Continue?(y/N): " yn
case "$yn" in [yY]*) ;; *) echo "Abort." ; exit ;; esac

# システム更新、ネットツール、デスクトップのインストール
echo $2 | sudo -S apt -y update
echo $2 | sudo -S apt -y upgrade
echo $2 | sudo -S apt -y install net-tools
echo $2 | sudo -S apt -y install ubuntu-desktop

echo "Sync and Wait 5sec..."
sync
sleep 5

# swap 1GB設定
echo $2 | sudo -S fallocate -l 1g /swapfile
echo $2 | sudo -S chmod 600 /swapfile
echo $2 | sudo -S mkswap /swapfile
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab
echo $2 | sudo -S sudo swapon -a

echo "Sync and Wait 3sec..."
sync
sleep 3

#必要モジュールのインストール
echo $2 | sudo -S apt-get -y install build-essential cmake automake libtool gfortran pkg-config asciidoc asciidoctor qttools5-dev qttools5-dev-tools qt5-default qtmultimedia5-dev libqt5serialport5-dev libudev-dev fftw3 libfftw3-dev cmake git libhamlib-dev libhamlib-utils portaudio19-dev libqt5multimedia5-plugins coderay dialog libsamplerate0-dev python3-pip python3-tk python3-dev python3-numpy python3-setuptools python3-dev subversion texinfo libfreetype6-dev libgtk-3-dev libgtk2.0-dev libjpeg-dev liblcms2-dev libtiff5-dev libwebp-dev tcl8.6-dev tk8.6-dev  libusb-dev libusb-1.0-0-dev .imagetk libgfortran4 libgd-dev

echo "Sync and Wait 3sec..."
sync
sleep 3

echo $2 | sudo -S apt-get -y install lcl*2.0 lazarus*2.0 fp*3.0.4 fpc*3.0.4 libssl-dev git build-essential libmariadbclient-dev
echo $2 | sudo -S ln -s /usr/lib/aarch64-linux-gnu/libmariadbclient.so /usr/lib/libmysqlclient.so

echo "Sync and Wait 3sec..."
sync
sleep 3

#cqrlogのインストール
cd ~/Downloads
wget https://github.com/ok2cqr/cqrlog/archive/refs/tags/v2.5.2.tar.gz
tar xvzf v2.5.2.tar.gz
cd cqrlog-2.5.2
make
echo $2 | sudo -S make install

echo "Sync and Wait 3sec..."
sync
sleep 3

#mariadbのインストール
echo $2 | sudo -S sudo apt -y install mariadb-server
git 
#hamlibのインストール
cd ~
mkdir ~/hamlib-prefix
cd ~/hamlib-prefix
git clone https://github.com/jtdx-project/jtdxhamlib src
cd src
./bootstrap
mkdir ../build
cd ../build
../src/configure --prefix=$HOME/hamlib-prefix --disable-shared --enable-static --without-cxx-binding --disable-winradio CFLAGS="-g -O2 -fdata-sections -ffunction-sections" LDFLAGS="-Wl,--gc-sections"
make
make install-strip

echo "Sync and Wait 3sec..."
sync
sleep 3

#JTDXのインストール
mkdir -p ~/jtdx-prefix/build
cd ~/jtdx-prefix
git clone https://git.code.sf.net/p/jtdx/code src
cd ~/jtdx-prefix/build
echo $2 | sudo -S apt -y install build-essential cmake automake libtool gfortran pkg-config asciidoc asciidoctor qttools5-dev-tools qt5-default qtmultimedia5-dev libqt5serialport5-dev libudev-dev  libfftw3-dev git libhamlib-dev libhamlib-utils portaudio19-dev libqt5multimedia5-plugins coderay dialog libsamplerate0-dev python3-pip python3-tk python-dev-is-python2 python3-numpy python3-setuptools python3-dev subversion texinfo libfreetype6-dev libgtk-3-dev libgtk2.0-dev libjpeg-dev liblcms2-dev libtiff5-dev libwebp-dev tcl8.6-dev tk8.6-dev libusb-dev libusb-1.0-0-dev libgfortran4 libfftw3-3 libboost1.67-all-dev libqt5websockets5-dev

cmake -D CMAKE_PREFIX_PATH=~/hamlib-prefix -D CMAKE_INSTALL_PREFIX=~/jtdx-prefix ../src
cmake --build .
echo $2 | sudo -S cmake --build . --target install

echo "Sync and Wait 3sec..."
sync
sleep 3

#JTDX用のアイコンを移動
#cd ~
#git clone https://github.com/gun534/jtdx_misc.git
mkdir ~/Pictures
cp ~/jtdx_misc/jtdx.png ~/Pictures

#アプリのショートカットを作成
echo "[Desktop Entry]" > ~/JTDX.desktop
echo "GenericName=JTDX Application" >> ~/JTDX.desktop
echo "Name=JTDX" >> ~/JTDX.desktop
echo "Comment=JTDX V2.2.159" >> ~/JTDX.desktop
echo "Exec=/home/$1/jtdx-prefix/bin/jtdx" >> ~/JTDX.desktop
echo "Terminal=false" >> ~/JTDX.desktop
echo "Type=Application" >> ~/JTDX.desktop
echo "Categories=Network;WebBrowser;" >> ~/JTDX.desktop
echo "Icon=/home/$1/Pictures/jtdx.png" >> ~/JTDX.desktop
echo "Encoding=UTF-8" >> ~/JTDX.desktop
chmod 775 ~/JTDX.desktop
echo $2 | sudo -S mv ~/JTDX.desktop /usr/share/applications/

echo "Sync and Wait 5sec..."
sync
sleep 5

echo "Process is Completed!!!!!"

#再起動
echo $2 | sudo -S reboot

exit 0
