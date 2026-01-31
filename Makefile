#---------------------------------------------------------------------------------
# NOMBRE DEL PROYECTO
#---------------------------------------------------------------------------------
TARGET      := MetodoGhioDS
BUILD       := build
SOURCES     := .
INCLUDES    := .

# Requisito: DEVKITARM debe estar definido
ifeq ($(strip $(DEVKITARM)),)
$(error "Por favor, establece DEVKITARM en tu entorno. Revisa tu instalación de devkitPro")
endif

# Importamos las reglas oficiales (esto define ARCH, PREFIX, etc.)
include $(DEVKITARM)/ds_rules

#---------------------------------------------------------------------------------
# CONFIGURACIÓN DEL COMPILADOR
#---------------------------------------------------------------------------------
# Usamos += para no borrar lo que ds_rules ya configuró (como -DARM9)
CFLAGS   += -g -Wall -O2 -ffast-math
CXXFLAGS += $(CFLAGS)
# El flag -Wl debe pasarse a través de GCC, no directamente a LD
LDFLAGS  += -g $(ARCH) -Wl,-Map,$(notdir $@).map

# Librerías
LIBS     := -lnds9

#---------------------------------------------------------------------------------
# REGLAS DE CONSTRUCCIÓN
#---------------------------------------------------------------------------------
.PHONY: all clean

all: $(TARGET).nds

# Regla para generar el .nds
$(TARGET).nds: $(TARGET).elf
	@ndstool -c $@ -9 $<

# Regla para el enlazado (usamos $(CC) para que gestione el linker correctamente)
$(TARGET).elf: main.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

# Regla para compilar el main.o
main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -rf $(BUILD) *.elf *.nds *.map *.o
