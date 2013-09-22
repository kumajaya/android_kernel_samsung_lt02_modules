SHELL = bash

ifneq ($(M),)
CONFIG_FILE := $(M)/.config
-include $(CONFIG_FILE)
EXTRA_CFLAGS += -I$(M)
else
CONFIG_FILE := $(PWD)/.config
-include $(CONFIG_FILE)
EXTRA_CFLAGS += -I$(PWD)
endif

export EXTRA_CFLAGS


ifeq ($(CONFIG_PXA988), y)
CONFIG_PXA9XX=y
CONFIG_PXA3XX=y
KERNELDIR ?= /usr/src/arm/linux-3.4.5-pxa988
CROSS_COMPILE ?= /usr/local/arm-eabi-4.4.3/bin/arm-eabi-
endif

ifeq ($(CONFIG_BG2), y)
CONFIG_PXA9XX=y
CONFIG_PXA3XX=y
KERNELDIR ?= /usr/src/arm/linux-3.0.8-bg2
CROSS_COMPILE ?= /usr/local/arm-eabi-4.4.3/bin/arm-eabi-
endif

ifeq ($(CONFIG_PXA978T), y)
CONFIG_PXA9XX=y
endif
ifeq ($(CONFIG_T3T), y)
CONFIG_PXA9XX=y
endif
ifeq ($(CONFIG_PXA955), y)
CONFIG_PXA9XX=y
endif
ifeq ($(CONFIG_PXA950), y)
CONFIG_PXA9XX=y
endif
ifeq ($(CONFIG_PXA920), y)
CONFIG_PXA9XX=y
endif
ifeq ($(CONFIG_PXA9XX), y)
EXTRA_CFLAGS += -DPXA9XX
ifeq ($(CONFIG_T3T), y)
ifeq ($(KMINORVER),410_JB)
KERNELDIR ?= /usr/src/arm/linux-3.4.10-JB-T3T/
CROSS_COMPILE ?= /usr/local/arm-eabi-4.6/bin/arm-eabi-
else
KERNELDIR ?= /usr/src/arm/linux-3.1.10-JB-T3T/
endif
CROSS_COMPILE ?= /usr/local/arm-eabi-4.4.3/bin/arm-eabi-
else
ifeq ($(CONFIG_PXA978T), y)
ifeq ($(KMINORVER),31)
KERNELDIR ?= /usr/src/arm/linux-3.0.31-pxa978t
else
KERNELDIR ?= /usr/src/arm/linux-3.0.8-pxa978t
endif
CROSS_COMPILE ?= /usr/local/arm-marvell-linux-gnueabi/bin/arm-marvell-linux-gnueabi-
else
ifeq ($(CONFIG_PXA955), y)
EXTRA_CFLAGS += -DPXA955
KERNELDIR ?= /home/sst/mg1/src/ML8DSP2.01.08/android_base/kernel/kernel
CROSS_COMPILE ?= /home/sst/mg1/src/ML8DSP2.01.08/android_base/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
else
ifeq ($(CONFIG_PXA950), y)
EXTRA_CFLAGS += -DPXA950
KERNELDIR ?= /usr/src/arm/linux-2.6.29-pxa950
CROSS_COMPILE ?= /usr/local/arm-marvell-linux-gnueabi/bin/arm-marvell-linux-gnueabi-
else
ifeq ($(CONFIG_PXA920), y)
EXTRA_CFLAGS += -DPXA920
ifeq ($(KVER),3)
KERNELDIR ?= /usr/src/arm/linux-3.0.8-pxa920
else
ifeq ($(KMINORVER),35)
KERNELDIR ?= /usr/src/arm/linux-2.6.35-pxa920
else
ifeq ($(KMINORVER),32)
KERNELDIR ?= /usr/src/arm/linux-2.6.32-pxa920
else
KERNELDIR ?= /usr/src/arm/linux-2.6.29-pxa920
endif
endif
endif
CROSS_COMPILE ?= /usr/local/arm-marvell-linux-gnueabi/bin/arm-marvell-linux-gnueabi-
else
ifeq ($(KMINORVER),25)
KERNELDIR ?= /usr/src/arm/linux-2.6.25-pxa9xx
CROSS_COMPILE ?= /usr/local/arm/4.1.1/bin/arm-linux-
else
KERNELDIR ?= /usr/src/arm/linux-2.6.24-pxa9xx
CROSS_COMPILE ?= /usr/local/arm/4.1.1/bin/arm-linux-
endif
endif
endif
endif
endif
endif
ARCH ?= arm
else
ifeq ($(CONFIG_MOORESTOWN), y)
ARCH ?= i386
KERNELDIR ?= /usr/src/moorestown/kernel
CROSS_COMPILE ?= /usr/local/i686-unknown-linux-gnu-4.2.1/bin/i686-unknown-linux-gnu-
else
KERNELDIR ?= /lib/modules/$(shell uname -r)/build
endif
endif

MBT_CHAR_OBJS := mbt_char.o hci_wrapper.o
obj-m := mbtchar.o
mbtchar-objs := $(MBT_CHAR_OBJS)

BINDIR = ../bin_mbtchar

PWD   := $(shell pwd)

default:
ifeq ($(CONFIG_PXA9XX), y)
	$(MAKE) -C $(KERNELDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules
else
ifeq ($(CONFIG_MOORESTOWN), y)
	$(MAKE) -C $(KERNELDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules
else
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
endif
endif

build: default
	@if [ ! -d $(BINDIR) ]; then \
		mkdir $(BINDIR); \
	fi 
	@cp -f mbtchar.ko $(BINDIR)
	@cp -f README $(BINDIR)

clean:
	echo "pwd" $(PWD)
	-find . -name "*.o" -exec rm {} \;
	-find . -name "*.ko" -exec rm {} \;
	-find . -name ".*.cmd" -exec rm {} \;
	-find . -name "*.mod.c" -exec rm {} \;
	-find . -name "*.symvers" -exec rm {} \;
	-find . -name "modules.order" -exec rm {} \;
	-rm -rf .tmp_versions

PXA9XX PXA955 PXA950 PXA978T PXA920 BG2 X86 MOORESTOWN T3T PXA988:
	@echo CONFIG_$@=y > $(CONFIG_FILE)
3.4.5:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=45" >> $(CONFIG_FILE)

3.0.10:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=110" >> $(CONFIG_FILE)

3.0.31:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=31" >> $(CONFIG_FILE)

3.4.10_JB:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=410_JB" >> $(CONFIG_FILE)

3.0.10_JB:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=110_JB" >> $(CONFIG_FILE)

3.1.10_JB:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=410_JB" >> $(CONFIG_FILE)

3.0.8:
	@echo "KVER=3" >> $(CONFIG_FILE)
	@echo "KMINORVER=08" >> $(CONFIG_FILE)

2.6.25:
	@echo "KMINORVER=25" >> $(CONFIG_FILE)

2.6.32:
	@echo "KMINORVER=32" >> $(CONFIG_FILE)

2.6.35:
	@echo "KMINORVER=35" >> $(CONFIG_FILE)

2.6.39:
	@echo "KMINORVER=39" >> $(CONFIG_FILE)
