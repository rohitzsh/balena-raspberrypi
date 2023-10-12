SUMMARY = "Goodix GT9xx touchscreen driver"
DESCRIPTION = "Bitbake recipe for Goodix GT9xx touchscreen driver"
SECTION = "kernel/modules"
PRIORITY = "optional"
LICENSE = "CLOSED"

SRCREV = "8a380313418b5159a89623a4e0a00b85365bfbea"
SRC_URI = "git://github.com/rohitzsh/chipsee-driver-gt9xx.git;branch=5.15.61;protocol=https"

S="${WORKDIR}/git"

inherit module

do_compile() {
   oe_runmake 'MODPATH="${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/drivers/input/touchscreen" ' \
               'KDIR="${STAGING_KERNEL_DIR}"' \
               'KERNEL_VERSION="${KERNEL_VERSION}"'
}

do_install() {
   install -d ${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/drivers/input/touchscreen
   install -m 0644 ${S}/g*${KERNEL_OBJECT_SUFFIX} ${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/drivers/input/touchscreen
}

RPROVIDES_${PN} += "kernel-module-touchscreen"

KERNEL_MODULE_AUTOLOAD += "gt9xx"