#include <cpcrslib.h>
#ifndef KK_SHARED
#define KK_SHARED

typedef unsigned int u16;
typedef unsigned char u8;
typedef signed int s16;
typedef signed char s8;

typedef enum
{
    KEY_UP = 0,
    KEY_DOWN,
    KEY_RIGHT,
    KEY_LEFT,
    KEY_FIRE,
    KEY_ESCAPE,
    KEY_JOY_UP,
    KEY_JOY_DOWN,
    KEY_JOY_LEFT,
    KEY_JOY_RIGHT,
    KEY_JOY_FIRE1,
    KEY_JOY_FIRE2,
    KEY_COUNT
} MY_KEY;

typedef enum
{
    SC_GAME,
    SC_END,
    SC_INTRO
} CPC_SCENE;

#define SOUND
// #define DEBUG

#include "sprite.h"

#include "function.h"
#include "cpc_func.h"

#endif
