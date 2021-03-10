#include <stdlib.h>
#include <string.h>

#include "shared.h"

#include "game.h"


char mainGame(void)
{
      #ifdef SOUND
    __asm
    push af
    push bc
    push ix
    push iy

    ld hl, #_MYSUPERSONG_START
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
#endif /* ifdef SOUND */

    lzsa_expand(G_background_192x160, (char *)(0xC000));

    k_PrintGphStr("MAIN", cpc_GetScrAddress((96 - 4 * 3) / 2, 32));

    u8 inGame = 1;

    while (inGame) {                                                       // Repeat until ESC pressed
        scr_waitVSYNC();

        if ((cpc_TestKey_withWait(KEY_ESCAPE)) || (cpc_TestKey_withWait(KEY_JOY_FIRE2))) {
            inGame = 0;
        }
    }

    while (cpc_AnyKeyPressed()) {
    }


    return (char)SC_INTRO;

}     /* mainGame */