# Nombre del archivo final
TARGET      := MetodoGhioDS

# Importar las reglas de devkitARM
ifeq ($(strip $(DEVKITARM)),)
$(error "DEVKITARM no detectado")
endif

include $(DEVKITARM)/ds_rules

# Usamos pkg-config para obtener las rutas exactas de libnds automáticamente
# Esto soluciona el error de calico.h y de la arquitectura ARM9
PKG_CFLAGS  := $(shell pkg-config --cflags libnds)
PKG_LIBS    := $(shell pkg-config --libs libnds)

# Configuración de Flags
CFLAGS      := -g -Wall -O2 $(ARCH) $(PKG_CFLAGS)
LDFLAGS     := -specs=ds_arm9.specs -g $(ARCH)
LIBS        := $(PKG_LIBS)

# Reglas de construcción
.PHONY: all clean

all: $(TARGET).nds

$(TARGET).nds: $(TARGET).elf
	@ndstool -c $@ -9 $<

$(TARGET).elf: main.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o *.elf *.nds *.map
