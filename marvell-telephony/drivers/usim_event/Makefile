usimeventk-objs := usim_event.o

.PHONY: all clean

all:modules

obj-m := usimeventk.o

modules:
	$(MAKE) -C $(KERNELDIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) M=$(shell pwd) modules

clean:
	rm -rf    \
	*.o       \
	*~        \
	core      \
	.*.d      \
	./.tmp*   \
	.*.cmd    \
	*.ko      \
	*.mod.c   \
	modules.order \
	Module.symvers
