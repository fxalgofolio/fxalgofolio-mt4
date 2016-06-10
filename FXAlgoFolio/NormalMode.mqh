#ifndef FXALGOFOLIO_NORMALMODE
#define FXALGOFOLIO_NORMALMODE

#include "Util/Base.mqh"

void DoSystemSetExterns()
{
   SystemSetExterns();
}

bool DoSystemEntry()
{
   return SystemEntry();
}

bool DoSystemExit()
{
   return SystemExit();
}

#endif
