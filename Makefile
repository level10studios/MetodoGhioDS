#---------------------------------------------------------------------------------
# NOMBRE DEL PROYECTO
#---------------------------------------------------------------------------------
TARGET		:=	MetodoGhioDS
BUILD		:=	build
SOURCES		:=	.
INCLUDES	:=	.

#---------------------------------------------------------------------------------
# CONFIGURACIÓN DEL COMPILADOR (devkitARM)
#---------------------------------------------------------------------------------
include $(DEVKITARM)/ds_rules

export AS	:=	$(PREFIX)as
export CC	:=	$(PREFIX)gcc
export CXX	:=	$(PREFIX)g++
export AR	:=	$(PREFIX)ar
export OBJCOPY	:=	$(PREFIX)objcopy

# Flags de compilación para Nintendo DS
CFLAGS	:=	-g -Wall -O2\
		-march=armv5te -mtune=arm946e-s -fomit-frame-pointer\
		-ffast-math \
		$(ARCH)

LDFLAGS	=	-g $(ARCH) -Wl,-Map,$(notdir $@).map

# Librerías necesarias para texto y gráficos básicos
LIBS	:=	-lnds9

#---------------------------------------------------------------------------------
# REGLAS DE CONSTRUCCIÓN
#---------------------------------------------------------------------------------
.PHONY: all clean

all: $(TARGET).nds

$(TARGET).nds: $(TARGET).elf
$(TARGET).elf: main.o

clean:
	@rm -rf $(BUILD) *.elf *.nds *.map