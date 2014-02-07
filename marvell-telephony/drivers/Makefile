# File: Makefile
# Copyright (C) 2007-2012, Marvell International Ltd.
#
PWD  := $(shell pwd)
BUILDROOT := $(PWD)

SUDO :=

PXA_SRC_ANDROID_DEVICE_DIR := $(BUILDROOT)/../../../../../

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld

BACKUP := /root/backup
YMD := `date +%Y%m%d%H%M`

#############################################################################
# Select Platform Tools
#############################################################################

KERNELDIR ?= $(PXA_SRC_ANDROID_DEVICE_DIR)kernel/kernel

KERNEL_OUTDIR ?= $(PXA_SRC_ANDROID_DEVICE_DIR)out/target/product/pxa988dkb/kernel

CROSS_COMPILE ?= $(PXA_SRC_ANDROID_DEVICE_DIR)prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

INSTALLDIR ?= /tftpboot/

ARCH ?= arm

LD += -S

.EXPORT_ALL_VARIABLES:

install-target: compile
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)$(SUDO) cp -f citty/src/citty.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f ccinetdev/ccinetdev.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f cidatastub/cci_datastub.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f cidatatty/cidatattydev.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f cimodemtty/build/gs_modem.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f shmem/msocket/msocketk.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f diag/gs_diag.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f diag/diag.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f cp_load/cploaddev.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f errorhandler/build/seh.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f hwmap/hwmap.ko $(KERNEL_OUTDIR)/modules
	$(hide)$(SUDO) cp -f usim_event/usimeventk.ko $(KERNEL_OUTDIR)/modules

compile: cp_load_drv msocketk cci_datastub_drv citty_drv cidatatty_drv ccinetdev_drv gs_modem_drv diag_drv seh_drv hwmap_drv usim_event_drv

msocketk: cp_load_drv
	make -C shmem/msocket

diag_drv: msocketk
	make -C diag

citty_drv:
	make -C citty

ccinetdev_drv: cci_datastub_drv
	make -C ccinetdev

cci_datastub_drv: msocketk
	make -C cidatastub

cidatatty_drv: cci_datastub_drv
	make -C cidatatty

gs_modem_drv: cci_datastub_drv
	make -C cimodemtty

hwmap_drv:
	make -C hwmap

seh_drv: cp_load_drv
	make -C errorhandler

cp_load_drv:
	make -C cp_load

usim_event_drv:
	make -C usim_event

clean:
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/citty.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/ccinetdev.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/cci_datastub.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/cidatattydev.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/gs_modem.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/msocketk.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/gs_diag.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/diag.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/cploaddev.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/seh.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/hwmap.ko
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/usimeventk.ko
	make -C shmem/msocket clean
	make -C diag clean
	make -C cimodemtty clean
	make -C errorhandler clean
	make -C hwmap clean
	make -C ccinetdev clean
	make -C cidatastub clean
	make -C cidatatty clean
	make -C citty clean
	make -C cp_load clean
	make -C usim_event clean
	-find -name '*.cmd' -exec rm {} \;
	-find -name '*.o' -exec rm {} \;
	-find -name '*.order' -exec rm {} \;
