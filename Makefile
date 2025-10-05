# Makefile
# modify CROSS if you use a prefixed cross-toolchain 
CROSS ?= i686-elf-
AS   = $(CROSS)as
LD   = $(CROSS)ld
GCC  = $(CROSS)gcc

BUILD = build
ISO   = iso
KERNEL = $(BUILD)/kernel.elf

.PHONY: all clean iso run

all: $(KERNEL)

$(BUILD):
	mkdir -p $(BUILD)

$(KERNEL): $(BUILD) boot.S kernel.c linker.ld
	$(AS) --32 boot.S -o $(BUILD)/boot.o
	$(GCC) -m32 -ffreestanding -fno-builtin -nostdlib -g -c kernel.c -o $(BUILD)/kernel.o
	$(LD) -m elf_i386 -T linker.ld $(BUILD)/boot.o $(BUILD)/kernel.o -o $(KERNEL)

iso: all
	mkdir -p $(ISO)/boot/grub
	cp $(KERNEL) $(ISO)/boot/kernel.elf
	cp grub.cfg $(ISO)/boot/grub/grub.cfg
	# create a bootable ISO (grub-mkrescue provided by GRUB tools)
	grub-mkrescue -o myos.iso $(ISO)

run: iso
	qemu-system-i386 -cdrom myos.iso

clean:
	rm -rf $(BUILD) $(ISO) myos.iso
