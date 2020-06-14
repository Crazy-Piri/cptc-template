#include "shared.h"

void scr_waitVSYNC(void);
void switchTo192x160(void);
u8 cpc_TestKey_withWait(MY_KEY key);
void drawInteger(u16 x, u16 y, u16 i, u8 len);

void k_PrintGphStr(char *text, int destino);