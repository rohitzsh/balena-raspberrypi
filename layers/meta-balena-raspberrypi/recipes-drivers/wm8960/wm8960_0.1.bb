SUMMARY = "WM8960 Soc Audio driver"
DESCRIPTION = "Bitbake recipe for WM8960 Soc Audio driver"
SECTION = "kernel/modules"
PRIORITY = "optional"
LICENSE = "CLOSED"

SRCREV = "2471bf537ca67b2148b95e0f6b3eede76a6275b7"
SRC_URI = "git://github.com/rohitzsh/chipsee-driver-wm8960.git;branch=master;protocol=https"

S="${WORKDIR}/git"

inherit module

do_compile() {
   oe_runmake 'MODPATH="${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/sound/soc/codecs" ' \
               'KDIR="${STAGING_KERNEL_DIR}"' \
               'KERNEL_VERSION="${KERNEL_VERSION}"'
}

do_install() {
   install -d ${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/sound/soc/codecs
   install -m 0644 ${S}/w*${KERNEL_OBJECT_SUFFIX} ${D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/sound/soc/codecs
}

RPROVIDES_${PN} += "kernel-module-sound"

KERNEL_MODULE_AUTOLOAD += "wm8960"
