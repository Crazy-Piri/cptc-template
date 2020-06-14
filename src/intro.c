#include "intro.h"


void intro_screen_settings(void)
{
    switchTo192x160();


    cpc_ClrScr();                       // fills scr with ink 0

    char hwInk[27] = {0x14, 0x04, 0x15, 0x1C, 0x18, 0x1D, 0x0C, 0x05, 0x0d, 0x16, 0x06, 0x17, 0x1E, 0x00, 0x1f, 0x0e, 0x07, 0x0f, 0x12, 0x02, 0X13, 0x1A, 0x19, 0x1B, 0x0A, 0x03, 0x0B};
    char col[16] = {0x00, 0x1A, 0x19, 0x14, 0x0C, 0x0A, 0x18, 0x04, 0x13, 0x17, 0x08, 0x10, 0x09, 0x0E, 0x16, 0x0F};
    int n;

    for (n = 0; n < 16; n++) {
        cpc_SetColour(n, hwInk[col[n]]);
    }
    cpc_SetColour(16, 0x04);
}


char intro(void)
{
    u16 frame = 0;

    CPC_SCENE retour = SC_INTRO;

    intro_screen_settings();


// Menu

#ifdef SOUND
    __asm
    push af
    push bc
    push ix
    push iy

    ld hl, #_TETRISA_START
    xor a, a
    call _PLY_AKG_INIT

    ld hl, #_SOUNDEFFECTS_SOUNDEFFECTS
    xor a, a
    call _PLY_AKG_INITSOUNDEFFECTS

    pop iy
    pop ix
    pop bc
    pop af
       __endasm;
#endif

    lzsa_expand(G_background_192x160_scr, (char *)(0xC000));


    while (retour == SC_INTRO) { // Repeat until ESC pressed - Small scrolling effect

        scr_waitVSYNC();

        if ((cpc_TestKey_withWait(KEY_FIRE) == 1) | (cpc_TestKey_withWait(KEY_JOY_FIRE1))) {
            retour = SC_GAME;
        }

        if ((cpc_TestKey_withWait(KEY_ESCAPE)) | (cpc_TestKey_withWait(KEY_JOY_FIRE2))) {     // Escape
            return SC_END;
        }


    }

    while (cpc_AnyKeyPressed()) {

    }



    return (char)retour;

}     /* intro */
