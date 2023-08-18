#! /bin/sh

# rtl-sdr
apt purge ^librtlsdr
rm -rvf /usr/lib/librtlsdr* /usr/include/rtl-sdr* /usr/local/lib/librtlsdr* /usr/local/include/rtl-sdr* /usr/local/include/rtl_* /usr/local/bin/rtl_*
apt-get install libusb-1.0-0-dev git cmake make gcc g++
git clone https://github.com/rtlsdrblog/rtl-sdr-blog
cd rtl-sdr-blog
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make -j`nproc`
make install
cp ../rtl-sdr.rules /etc/udev/rules.d/
ldconfig
echo 'blacklist dvb_usb_rtl28xxu' | tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
cd
rm -rf rtl-sdr-blog

# rtl-wmbus
cd
git clone https://github.com/xaelsouth/rtl-wmbus.git
cd rtl-wmbus
make release
make install
cd
rm -rf rtl-wmbus

# wmbusmeters
git clone https://github.com/wmbusmeters/wmbusmeters.git
cd wmbusmeters
./configure
make -j`nproc`
make install
systemctl daemon-reload
cd
rm -rf wmbusmeters

reboot