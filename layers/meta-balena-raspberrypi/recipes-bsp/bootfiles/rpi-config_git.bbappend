do_deploy:append() {
    # Enable i2c by default
    echo "dtparam=i2c_arm=on" >>${DEPLOYDIR}/bootfiles/config.txt
    # Enable SPI by default
    echo "dtparam=spi=on" >>${DEPLOYDIR}/bootfiles/config.txt
    # Disable firmware splash by default
    echo "disable_splash=1" >>${DEPLOYDIR}/bootfiles/config.txt
    # Disable firmware warnings showing in non-debug images
    if ! ${@bb.utils.contains('DISTRO_FEATURES','osdev-image','true','false',d)}; then
        echo "avoid_warnings=1" >>${DEPLOYDIR}/bootfiles/config.txt
    fi
    # Enable audio (loads snd_bcm2835)
    echo "dtparam=audio=on" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:fincm3() {
	# Use the Balena Fin device tree overlay
	echo "dtoverlay=balena-fin" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:npe-x500-m3() {
  # Use the NPE X500 M3 device tree overlay
  echo "dtoverlay=npe-x500-m3" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:revpi-connect() {
	# Use the RevPi Connect device tree overlay
	echo "dtoverlay=revpi-connect" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:revpi-connect-s() {
	# Use the RevPi Connect device tree overlay
	echo "dtoverlay=revpi-connect" >> ${DEPLOYDIR}/bootfiles/config.txt
        echo "dtoverlay=dwc2" >> ${DEPLOYDIR}/bootfiles/config.txt
        echo "dr_mode=host" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:raspberrypi3-unipi-neuron() {
	# Use the dt overlays required by the UniPi Neuron family of boards
	echo "dtoverlay=neuronee" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=i2c-rtc,mcp7941x" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=neuron-spi-new" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:raspberrypi4-superhub() {
	# Disable spi0
	sed -i '/dtparam=spi=on/ c\dtparam=spi=off' ${DEPLOYDIR}/bootfiles/config.txt

	# Use the dt overlays required by the raspberrypi4 superhub boards
	echo "dtparam=ant2" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=dwc2,dr_mode=host" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=i2c-rtc,pcf8563" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=pca953x,pca9555" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=pca953x,pca9555,addr=0x21" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=pca953x,pca9555,addr=0x22" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=uart3" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=uart5" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=ed-gpio-wdt" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=ed-spi1-1cs" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=ed-infineon-tpm" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=ed-sdhost" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:raspberrypi4-unipi-neuron() {
	# Use the dt overlays required by the UniPi Neuron family of boards
	echo "dtoverlay=neuronee" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=i2c-rtc,mcp7941x" >> ${DEPLOYDIR}/bootfiles/config.txt
	echo "dtoverlay=neuron-spi-new" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:revpi-core-3() {
    cat >> ${DEPLOYDIR}/bootfiles/config.txt << EOF

# serial port needs to be kept clean for RS485 communication
avoid_warnings=1

dtoverlay=revpi-core

EOF
    # prevent u-boot logging on uart
    sed -i 's/enable_uart=1//' ${DEPLOYDIR}/bootfiles/config.txt
}

# On Raspberry Pi 3 and Raspberry Pi Zero WiFi, serial ttyS0 console is only
# usable if ENABLE_UART = 1. On OS development images, we want serial console
# available, production devices can enable it with a configuration variable.
ENABLE_UART ?= "${@bb.utils.contains('DISTRO_FEATURES','osdev-image','1','0',d)}"

do_deploy:append:chipsee-ppc-cm4() {
	cat << EOF > ${DEPLOYDIR}/bootfiles/config.txt
arm_boost=1
core_freq=250
disable_overscan=1
disable_splash=1
dtoverlay=i2c0,pins_44_45
dtoverlay=i2c-rtc,ds1307,addr=0x32
dtoverlay=vc4-kms-v3d
dtoverlay=pwm-backlight,pin=18,func=2,pwm_0
dtoverlay=gt9xx,interrupt=20,reset=21
dtoverlay=miniuart-bt
dtoverlay=uart2
dtoverlay=uart3
dtoverlay=uart5
gpio=6=op,dh
gpio=18=op,dh
gpio=496-499=ip
gpu_mem=256
avoid_warnings=1
enable_uart=1
display_auto_detect=1
hdmi_drive=2
hdmi_force_hotplug=1
hdmi_group=2
hdmi_ignore_edid=0xa5000080
hdmi_mode=87
hdmi_timings=1024 0 160 10 160 600 0 12 1 23 0 0 0 60 0 52000000 6
hdmi_pixel_encoding=4
EOF
}