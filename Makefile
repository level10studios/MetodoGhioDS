#---------------------------------------------------------------------------------
# CONFIGURACIÓN DEL PROYECTO
#---------------------------------------------------------------------------------
TARGET      := MetodoGhioDS
DEVKITPRO   := /opt/devkitpro
DEVKITARM   := $(DEVKITPRO)/devkitARM

# Importamos las reglas oficiales
include $(DEVKITARM)/ds_rules

# Forzamos los compiladores
CC      := arm-none-eabi-gcc
LD      := arm-none-eabi-gcc

# FLAGS CORREGIDOS:
# 1. Añadimos -DARM9 (Vital para que nds.h funcione)
# 2. Añadimos las rutas de inclusión de libnds Y calico
CFLAGS  := $(ARCH) -DARM9 -march=armv5te -mtune=arm946e-s -O2 -Wall \
           -I$(DEVKITPRO)/libnds/include \
           -I$(DEVKITPRO)/libnds/include/protocol

# LDFLAGS: Aseguramos el uso de specs para NDS
LDFLAGS := -specs=ds_arm9.specs $(ARCH) \
           -L$(DEVKITPRO)/libnds/lib -Wl,-Map,$(TARGET).map

LIBS    := -lnds9

#---------------------------------------------------------------------------------
# REGLAS
#---------------------------------------------------------------------------------
.PHONY: all clean

all: $(TARGET).nds

$(TARGET).nds: $(TARGET).elf
	@ndstool -c $@ -9 $<

$(TARGET).elf: main.o
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)

main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o *.elf *.nds *.map
