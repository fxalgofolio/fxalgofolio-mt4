#ifndef FXALGOFOLIO_TESTMODE
#define FXALGOFOLIO_TESTMODE

#define FXALGOFOLIO_INIT_EXTRA TestInit

#include "Util/Base.mqh"
#include "Util/Test.mqh"

sinput TestType SystemTest;
input int TestIteration = 1;

enum TestType
{
   System, // Baseline system
   Entry_RandomExit, // Entry - random exit
   Entry_FixedBarExit, // Entry - fixed-bar exit
   Entry_FixedLevelExit, // Entry - fixed-level (SL & TP) exit
   Exit_RandomEntry, // Exit - random entry
   Exit_TrendFollowingEntry, // Exit - trend-following entry
   Exit_CounterTrendEntry, // Exit - counter-trend entry
};

void TestInit()
{
   // Ensure each test run is a different distribution of random numbers.
   MathSrand(GetTickCount() + (100 * TestIteration));
}

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

   case Exit_TrendFollowingEntry:
      TestTrendFollowingEntry();
      break;

   case Exit_CounterTrendEntry:
      TestCounterTrendEntry();
      break;
   }

   if (SelectOpenOrder())
   {
      switch (SystemTest)
      {
      case System:
      case Exit_RandomEntry:
      case Exit_TrendFollowingEntry:
      case Exit_CounterTrendEntry:
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
}

#endif
