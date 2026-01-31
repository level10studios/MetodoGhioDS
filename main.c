#define ARM9
#define __NDS__
#include <nds.h>
#include <stdio.h>

int main(void) {
    // Inicializar las consolas de texto en ambas pantallas
    consoleDemoInit(); 

    // Pantalla Superior: Título
    videoSetMode(MODE_0_2D);
    vramSetBankA(VRAM_A_MAIN_BG);
    
    printf("\n\n   INGLES BASICO - METODO GHIO\n");
    printf("   ============================\n");
    printf("   Primer Examen (Pag. 16)\n\n");
    printf("   Presiona START para salir\n\n");

    // Lista de palabras extraídas de tu PDF
    printf("   1. OFFER    - Oferta\n");
    printf("   2. MONDAY   - Lunes\n");
    printf("   3. BLUE     - Azul\n");
    printf("   4. SON      - Hijo\n");
    printf("   5. BAD      - Malo\n");
    printf("   6. HOUSE    - Casa\n");
    printf("   7. PLATE    - Plato\n");
    printf("   8. WATER    - Agua\n");
    printf("   9. IDEA     - Idea\n");
    printf("   10. FLOWER  - Flor\n");
    printf("   11. GARDEN  - Jardin\n");
    printf("   12. LIGHT   - Luz\n");
    printf("   13. CLEAN   - Limpio\n");
    printf("   14. FORK    - Tenedor\n");
    printf("   15. SKY     - Cielo\n");

    while(1) {
        swiWaitForVBlank();
        scanKeys();
        if (keysDown() & KEY_START) break;
    }

    return 0;
}
