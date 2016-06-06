#ifndef FXALGOFOLIO_TESTMODE
#define FXALGOFOLIO_TESTMODE

#include "Util/Base.mqh"
#include "Util/Test.mqh"

input TestType SystemTest;
input int TestIteration = 1000;

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
   switch (SystemTest)
   {
   case System:
   case Entry_RandomExit:
   case Entry_FixedBarExit:
   case Entry_FixedLevelExit:
      SystemEntry();
      break;

   case Exit_RandomEntry:
      TestRandomEntry();
      break;

   case Exit_SimilarEntry:
      TestSimilarEntry();
      break;
   }

   switch (SystemTest)
   {
   case System:
   case Exit_RandomEntry:
   case Exit_SimilarEntry:
      SystemExit();
      break;

   case Entry_RandomExit:
      TestRandomExit();
      break;

   case Entry_FixedBarExit:
      TestFixedBarExit();
      break;

   case Entry_FixedLevelExit:
      TestFixedLevelExit();
      break;
   }
}

#endif
