#ifndef FXALGOFOLIO_TESTMODE
#define FXALGOFOLIO_TESTMODE

#include "Util/Base.mqh"

input TestType SystemTest;

enum TestType
{
   System, // Baseline system
   Entry_RandomExit, // Entry - random exit
   Entry_FixedBarExit, // Entry - fixed-bar exit
   Entry_FixedLevelExit, // Entry - fixed-level (SL & TP) exit
   Exit_RandomEntry, // Exit - random entry
   Exit_SimilarEntry, // Exit - similar entry
};

void OnSystemBar()
{
   // TODO
}

#endif
