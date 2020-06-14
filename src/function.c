
#include "shared.h"


void scr_waitVSYNC(void)
{
    #ifdef DEBUG

    __asm


    // change border colour to black
    ld bc, #0x7F10
    out(c), c
    LD BC, #0x7F4B
    out(c), c

 ff_debug:
    ld b, #0xf5

 ffl_debug:
    in a, (c)
    rra
    jr nc, ffl_debug

    // change border colour to blue
    ld bc, #0x7F10
    out(c), c
    LD BC, #0x7F54
    OUT(C), C

    __endasm;
#else  /* ifdef DEBUG */
    __asm


 ff:
    ld b, #0xf5

 ffl:
    in a, (c)
    rra
    jr nc, ffl



    __endasm;
    #endif /* ifdef DEBUG */
}     /* scr_waitVSYNC */


void switchTo192x160(void)
{

// Resize to 192x160 (max 32768 in mode 0)
//    x1=0,x2=96 => width 96 (*2)  max 96
//    y1=14,y2=54 => height = 40 (*4) max 68

// reg1 = (x2-x1)/2 => 48
// reg2 = (100-x1)/2 => 50
// reg6 = (y2-y1)/2 => 20
// reg7 = (70-y1)/2 => 28

    __asm

    ld bc, #0xbc00 + 1
    out(c), c
    ld bc, #0xbd00 + 48
    out(c), c

    ld bc, #0xbc00 + 2
    out(c), c
    ld bc, #0xbd00 + 50
    out(c), c

    ld bc, #0xbc00 + 6
    out(c), c
    ld bc, #0xbd00 + 20
    out(c), c

    ld bc, #0xbc00 + 7
    out(c), c
    ld bc, #0xbd00 + 28
    out(c), c



    __endasm;
} /* switchTo192x160 */

u8 frkey[KEY_COUNT];

u8 cpc_TestKey_withWait(MY_KEY key)
{
    if (cpc_TestKey(key)) {
        if (frkey[key] == 0) {
            frkey[key] = 20;
            return 1;
        } else {
            frkey[key]--;
        }
    } else {
        frkey[key] = 0;
    }
    return 0;
}


void k_PrintGphStr(char *text, int destino)
{
    u8 *car = text;

    while (*car != 0) {
        const u8 *sprite = 0;
        u16 pos = 0;

        if ((*car >= '0') && (*car <= '9')) {
            pos = (((u16)(*car) - '0') + 1) * 24;
        } else if ((*car >= 'A') && (*car <= 'Z')) {
            pos = (((u16)(*car) - 'A') + 12) * 24;
        } else if (*car == '@') {
            pos = 11 * 24;
        }

        sprite = G_font8pix + pos;

        cpc_PutSp((char *)sprite, 8, 3, destino);


        destino += 3;
        car++;
    }



} /* k_PrintGphStr */

void inttostring(unsigned int value, char *string, signed char padding, u8 pad)
{
    signed char index = 0, i = 0;

    /* generate the number in reverse order */
    do {
        string[index] = '0' + (value % 10);
        if (string[index] > '9')
            string[index] += 'A' - '9' - 1;
        value /= 10;
        index++;
    } while (value != 0);

    while (index < padding) {
        string[index] = pad;
        index++;
    }

    /* null terminate the string */
    string[index--] = '\0';

    /* reverse the order of digits */
    while (index > i) {
        char tmp = string[i];
        string[i] = string[index];
        string[index] = tmp;
        i++;
        index--;
    }
} /* inttostring */

void drawInteger(u16 x, u16 y, u16 i, u8 len)
{
    char text[12];

    inttostring(i, text, len, '0');

    k_PrintGphStr(text, cpc_GetScrAddress(x, y));


}