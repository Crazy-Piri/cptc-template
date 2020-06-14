#include <stdlib.h>
#include <string.h>

#include "shared.h"

#include "game.h"


char mainGame(void)
{
    lzsa_expand(G_background_192x160_scr, (char *)(0xC000));

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