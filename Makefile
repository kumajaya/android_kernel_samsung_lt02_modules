#
# This file will be copied to <topdir>/kernel and change the name to Makefile by repo.
# If you don't use repo, please copy this file to <topdir>/kernel folder manually.
#

#hide:=@
log=@echo [$(shell date "+%Y-%m-%d %H:%M:%S")]

MAKE_JOBS?=1
KERNEL_TOOLCHAIN_PREFIX := /opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
KERNEL_CONFIG?=pxa986_lt02wifi_defconfig
KERNEL_OUTDIR?= out

MODULES_BUILT=
MODULES_CLEAN=
define add-module
	MODULES_BUILT+=$(1)
	MODULES_CLEAN+=clean_$(1)
endef

export ARCH?=arm
export CROSS_COMPILE?=$(KERNEL_TOOLCHAIN_PREFIX)
export KERNELDIR?=$(shell pwd)/common

.PHONY:help
help:
	$(hide)echo "======================================="
	$(hide)echo "= This file wraps the build of kernel and modules"
	$(hide)echo "= make all: to make  kernel, all modules. The kernel and modules will be output to 'out' directory."
	$(hide)echo "= make kernel: only make the kernel. Using KERNEL_CONFIG variable to specify the kernel config file to be used. By default it is: $(KERNEL_CONFIG)"
	$(hide)echo "= make modules: only make all the modules. The kernel should already be built. Otherwise building modules will fail."
	$(hide)echo "= make clean: clean the kernel and modules"
	$(hide)echo "======================================="

all: kernel modules

.PHONY: menuconfig
menuconfig:
	$(hide)cd kernel && \
	make $(KERNEL_CONFIG) && \
	make menuconfig
	$(hide)cp kernel/.config kernel/arch/arm/configs/$(KERNEL_CONFIG)

.PHONY: kernel clean_kernel
kernel:
	$(log) "making kernel [$(KERNEL_CONFIG)]..."

	$(hide)cd common && \
	make $(KERNEL_CONFIG) && \
	make -j$(MAKE_JOBS) && \
	$(hide)mkdir -p $(KERNEL_OUTDIR)
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)cp common/System.map $(KERNEL_OUTDIR)/
	$(hide)cp common/vmlinux $(KERNEL_OUTDIR)/
	$(log) "kernel [$(KERNEL_CONFIG)] done"

.PHONY:clean_kernel clean_modules
clean_kernel:
	$(hide)cd common &&\
	make distclean
	$(hide)rm -f $(KERNEL_OUTDIR)/zImage
	$(log) "Kernel cleaned."

clean: clean_kernel clean_modules
	$(hide)rm -fr $(KERNEL_OUTDIR)

define my-build-pxafsimage-ext2-target
	@mkdir -p $(dir $(2))
	$(hide) num_inodes=`find $(1) | wc -l` ; num_inodes=`expr $$num_inodes + 8192    `; \
	../out/host/linux-x86/bin/genext2fs -d $(1) -b $(5) -N $$num_inodes -m 0 $(2)
	$(if $(strip $(3)),\
		$(hide) tune2fs -L $(strip $(3)) $(2))
	$(if $(strip $(4)),\
		$(hide) tune2fs -j $(2))
	tune2fs -C 1 $(2) -O filetype
	e2fsck -fy $(2) ; [ $$? -lt 4 ]
endef

GC1000_DRVSRC:= graphics/galcore_src
export KERNEL_DIR:=$(KERNELDIR)
.PHONY: gc1000 clean_gc1000
gc1000:
	$(log) "make gc1000 driver..."
	$(hide)cd $(GC1000_DRVSRC) &&\
	make -j$(MAKE_JOBS)
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)cp $(GC1000_DRVSRC)/hal/driver/galcore.ko $(KERNEL_OUTDIR)/modules
	$(log) "gc1000 driver done."

clean_gc1000:
	$(hide)cd $(GC1000_DRVSRC) &&\
	make clean
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/galcore.ko
	$(log) "gc1000 driver cleaned."

$(eval $(call add-module,gc1000) )


SD8787_DRVSRC:= sd8787/
.PHONY: sd8787_wifi clean_sd8787_wifi
sd8787_wifi:
	$(log) "making sd8787 wifi driver..."
	$(hide)cd $(SD8787_DRVSRC)/wlan_src && \
	make -j$(MAKE_JOBS) default
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)cp $(SD8787_DRVSRC)/wlan_src/sd8xxx.ko $(KERNEL_OUTDIR)/modules/sd8787.ko
	$(hide)cp $(SD8787_DRVSRC)/wlan_src/mlan.ko $(KERNEL_OUTDIR)/modules/mlan.ko
	$(log) "sd8787 wifi driver done."

clean_sd8787_wifi:
	$(hide)cd $(SD8787_DRVSRC)/wlan_src &&\
	make clean
	rm -f $(KERNEL_OUTDIR)/modules/sd8787.ko
	rm -f $(KERNEL_OUTDIR)/modules/mlan.ko
	$(log) "sd8787 wifi driver cleaned."

$(eval $(call add-module,sd8787_wifi) )

.PHONY: sd8787_bt clean_sd8787_bt
sd8787_bt:
	$(log) "making sd8787 BT driver..."
	$(hide)cd $(SD8787_DRVSRC)/bt_src && \
	make -j$(MAKE_JOBS) default
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)cp $(SD8787_DRVSRC)/bt_src/bt8xxx.ko $(KERNEL_OUTDIR)/modules/bt8787.ko
	$(log) "sd8787 bt driver done."

clean_sd8787_bt:
	$(hide)cd $(SD8787_DRVSRC)/bt_src &&\
	make clean
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/bt8787.ko
	$(log) "sd8787 bt driver cleaned."

$(eval $(call add-module,sd8787_bt) )

$(eval $(call add-module,telephony_modules) )

TELEPHONY_DRVSRC:= marvell-telephony/drivers
.PHONY: telephony_modules clean_telephony_modules
telephony_modules:
	$(log) "making telephony drivers..."
	$(hide)cd $(TELEPHONY_DRVSRC) && \
	make -j1 TARGET_DEVICE=$(TARGET_DEVICE) KERNEL_OUTDIR=$(KERNEL_OUTDIR) hide=$(hide)
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(log) "telephony driver done."

clean_telephony_modules:
	$(hide)cd $(TELEPHONY_DRVSRC) &&\
	make clean TARGET_DEVICE=$(TARGET_DEVICE) KERNEL_OUTDIR=$(KERNEL_OUTDIR) hide=$(hide)
	$(log) "telephony driver cleaned."

GEU_DRVSRC:= security/wtpsp/drv/src
.PHONY: geu clean_geu
geu:
	$(log) "making security driver..."
	$(hide)cd $(GEU_DRVSRC) && \
	make KDIR=$(KERNELDIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD)
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)cp $(GEU_DRVSRC)/geu.ko $(KERNEL_OUTDIR)/modules/geu.ko
	$(log) "security driver done."

clean_geu:
	$(hide)cd $(GEU_DRVSRC)/ && \
	make clean
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/geu.ko
	$(log) "security driver cleaned."

$(eval $(call add-module,geu) )

PHYSRW_DRVSRC:= physrw
.PHONY: physrw clean_physrw
physrw:
	$(log) "making register dump driver..."
	$(hide)cd $(PHYSRW_DRVSRC) && \
	make KDIR=$(KERNELDIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) M=$(PWD)
	$(hide)mkdir -p $(KERNEL_OUTDIR)/modules/
	$(hide)cp $(PHYSRW_DRVSRC)/physrw.ko $(KERNEL_OUTDIR)/modules/physrw.ko
	$(log) "register dump driver done."

clean_physrw:
	$(hide)cd $(PHYSRW_DRVSRC)/ && \
	make clean
	$(hide)rm -f $(KERNEL_OUTDIR)/modules/physrw.ko
	$(log) "register dump driver cleaned."

$(eval $(call add-module,physrw) )
#insert any module declaration above

.PHONY: modules
modules:$(MODULES_BUILT)

clean_modules: $(MODULES_CLEAN)
