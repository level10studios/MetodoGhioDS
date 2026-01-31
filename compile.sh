#!/bin/bash
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export PATH=$DEVKITARM/bin:$DEVKITPRO/tools/bin:$PATH

echo "--- Iniciando Compilación Forzada ---"

# 1. Compilar el objeto con todas las rutas y definiciones
arm-none-eabi-gcc -c main.c -o main.o \
    -DARM9 -D__NDS__ \
    -march=armv5te -mtune=arm946e-s -mthumb -mthumb-interwork -O2 \
    -I/opt/devkitpro/libnds/include \
    -I/opt/devkitpro/libnds/include/protocol

# 2. Enlazar el ELF
arm-none-eabi-gcc main.o -o MetodoGhioDS.elf \
    -specs=ds_arm9.specs -mthumb -mthumb-interwork \
    -L/opt/devkitpro/libnds/lib -lnds9

# 3. Crear el NDS
ndstool -c MetodoGhioDS.nds -9 MetodoGhioDS.elf

echo "--- ¡PROCESO FINALIZADO! ---"