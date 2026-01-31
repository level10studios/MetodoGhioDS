#---------------------------------------------------------------------------------
# CONFIGURACIÓN DEL PROYECTO
#---------------------------------------------------------------------------------
TARGET      := MetodoGhioDS
DEVKITPRO   := /opt/devkitpro
DEVKITARM   := $(DEVKITPRO)/devkitARM

# Importamos las reglas de devkitPro
include $(DEVKITARM)/ds_rules

# Forzamos el uso del compilador de ARM para todas las tareas
CC      := arm-none-eabi-gcc
LD      := arm-none-eabi-gcc

# Flags corregidos para evitar errores de Linker y encontrar las librerías
CFLAGS  := -DARM9 -march=armv5te -mtune=arm946e-s -O2 -Wall \
           -I$(DEVKITPRO)/libnds/include

# Specs es el archivo que define la memoria de la NDS
LDFLAGS := -specs=ds_arm9.specs -mthumb -mthumb-interwork $(ARCH) \
           -L$(DEVKITPRO)/libnds/lib -Wl,-Map,$(TARGET).map

LIBS    := -lnds9

#---------------------------------------------------------------------------------
# REGLAS DE COMPILACIÓN
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
