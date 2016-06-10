#ifndef FXALGOFOLIO_TESTMODE
#define FXALGOFOLIO_TESTMODE

#define FXALGOFOLIO_INIT_EXTRA TestInit

#include "Util/Base.mqh"
#include "Util/Test.mqh"

enum TestType
{
   Test_System, // Baseline system
   Test_Entry_RandomExit, // Entry - random exit
   Test_Entry_FixedBarExit, // Entry - fixed-bar exit
   Test_Entry_FixedLevelExit, // Entry - fixed-level (SL & TP) exit
   Test_Exit_RandomEntry, // Exit - random entry
   Test_Exit_TrendFollowingEntry, // Exit - trend-following entry
   Test_Exit_CounterTrendEntry, // Exit - counter-trend entry
};

sinput TestType SystemTest;
sinput bool TestSetExterns = true;
input int TestIteration = 1;

void TestInit()
{
   // Ensure each test run is a different distribution of random numbers.
   MathSrand(GetTickCount() + (100 * TestIteration));
}

void DoSystemSetExterns()
{
   if (TestSetExterns)
   {
      SystemSetExterns();
   }
}

bool DoSystemEntry()
{
   switch (SystemTest)
   {
   case Test_System:
   case Test_Entry_RandomExit:
   case Test_Entry_FixedBarExit:
   case Test_Entry_FixedLevelExit:
      return SystemEntry();

   case Test_Exit_RandomEntry:
      return TestRandomEntry();

   case Test_Exit_TrendFollowingEntry:
      return TestTrendFollowingEntry();

   case Test_Exit_CounterTrendEntry:
      return TestCounterTrendEntry();
   }

   return false;
}

bool DoSystemExit()
{
   switch (SystemTest)
   {
   case Test_System:
   case Test_Exit_RandomEntry:
   case Test_Exit_TrendFollowingEntry:
   case Test_Exit_CounterTrendEntry:
      return SystemExit();

   case Test_Entry_RandomExit:
      return TestRandomExit();

   case Test_Entry_FixedBarExit:
      return TestFixedBarExit();

   case Test_Entry_FixedLevelExit:
      return TestFixedLevelExit();
   }

   return false;
}

#endif
