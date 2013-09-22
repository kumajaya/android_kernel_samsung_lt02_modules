#
# Makefile for geu kernel module
#

obj-m    := geu.o
geu-objs := pxa-geu.o

.EXPORT_ALL_VARIABLES:
PWD  := $(shell pwd)
MAKE := make

.PHONY: all clean

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules 

clean:
	rm -rf *.o *.ko *.mod.c .*.cmd ./.tmp* *~ modules.order  Module.symvers

