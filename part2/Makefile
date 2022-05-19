obj-m += ili.o
ili-objs += ili_main.o ili_utils.o ili_handler.o

all: ili.ko bad_inst bad_inst_2

ili.ko:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) clean
	rm -f bad_inst bad_inst_2

bad_inst: inst_test.asm
	as -o $@.o $^
	ld -o $@ $@.o

bad_inst_2: inst_test_2.asm
	as -o $@.o $^
	ld -o $@ $@.o

$(KBUILD_EXTMOD)/ili_handler.o: ili_handler.asm
	as -o $@ $^
