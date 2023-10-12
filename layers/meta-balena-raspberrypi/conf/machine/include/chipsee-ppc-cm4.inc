IMAGE_INSTALL:append = " cslcd"
IMAGE_INSTALL:append = " gt9xx"
IMAGE_INSTALL:append = " lsm6ds3"

KERNEL_DEVICETREE:append = " overlays/gt9xx.dtbo"
KERNEL_DEVICETREE:append = " overlays/cs-i2c0.dtbo"
KERNEL_DEVICETREE:append = " overlays/pwm-backlight.dtbo"
