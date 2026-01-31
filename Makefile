#---------------------------------------------------------------------------------
# CONFIGURACIÓN DEL PROYECTO
#---------------------------------------------------------------------------------
TARGET      := MetodoGhioDS
BUILD       := build
SOURCES     := .
INCLUDES    := .

# Importar configuraciones de devkitARM
ifeq ($(strip $(DEVKITARM)),)
$(error "DEVKITARM no está definido. Revisa tu instalación.")
endif

include $(DEVKITARM)/ds_rules

# Definir flags correctamente
# ARCH se define en ds_rules (normalmente -mthumb -mthumb-interwork)
CFLAGS   := -g -Wall -O2 -march=armv5te -mtune=arm946e-s -fomit-frame-pointer -ffast-math $(ARCH) -DARM9
CXXFLAGS := $(CFLAGS)
LDFLAGS  := -g $(ARCH) -mthumb -mthumb-interwork -Wl,-Map,$(TARGET).map

# Librerías
LIBS     := -lnds9

# Objetos
OFILES   := main.o

#---------------------------------------------------------------------------------
# REGLAS
#---------------------------------------------------------------------------------
.PHONY: all clean

all: $(TARGET).nds

$(TARGET).nds: $(TARGET).elf
	@ndstool -c $@ -9 $<

$(TARGET).elf: $(OFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -I$(INCLUDES) -c $< -o $@

clean:
	@rm -rf $(BUILD) *.elf *.nds *.map *.o
