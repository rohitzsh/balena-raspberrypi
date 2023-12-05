deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

REVPI_DEBUG = "While not having the Revolution Pi board powered, connect your system to the board's USB port via a micro-USB cable."
REVPI_POWER = "Power on the Revolution Pi board."
REVPI_WRITE = "Write the OS to the internal MMC storage device. We recommend using <a href=http://www.etcher.io/>Etcher</a>."
REVPI_POWEROFF = "When flashing is complete, power off the board and unplug the micro-USB cable."

module.exports =
	version: 1
	slug: 'revpi-connect-4'
	name: 'Revolution Pi Connect 4'
	arch: 'aarch64'
	state: 'new'

	instructions: [
		REVPI_DEBUG
		REVPI_POWER
		REVPI_WRITE
		REVPI_POWEROFF
		instructions.CONNECT_AND_BOOT
	]

	gettingStartedLink:
		windows: 'https://www.balena.io/docs/learn/getting-started/raspberrypi4/nodejs/'
		osx: 'https://www.balena.io/docs/learn/getting-started/raspberrypi4/nodejs/'
		linux: 'https://www.balena.io/docs/learn/getting-started/raspberrypi4/nodejs/'

	options: [ networkOptions.group ]

	yocto:
		machine: 'revpi-connect-4'
		image: 'balena-image'
		fstype: 'balenaos-img'
		version: 'yocto-kirkstone'
		deployArtifact: 'balena-image-revpi-connect-4.balenaos-img'
		compressed: true

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
