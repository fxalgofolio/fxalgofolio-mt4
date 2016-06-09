#ifndef FXALGOFOLIO_UTIL_TEST
#define FXALGOFOLIO_UTIL_TEST

sinput datetime TestStartDate;
sinput double TestOrderLots = 1.0;
sinput double TestTradeProbability = 0.5;
sinput double TestTradePercentLong = 0.5;
sinput double TestHoldBars = 5;
sinput int TestHoldPips = 10;

bool TestRandomExit()
{
   // Close after a random number of bars distributed around given count.
   if (OrderBarsSinceOpen() >= Random(2 * TestHoldBars))
   {
      return OrderCloseMarket(TestOrderLots);
   }

   return true;
}

bool TestFixedBarExit()
{
   if (OrderBarsSinceOpen() >= TestHoldBars)
   {
      return OrderCloseMarket(TestOrderLots);
   }

   return true;
}

bool TestFixedLevelExit()
{
   // TODO
}

bool TestRandomEntry()
{
   // Open randomly at given probability.
   if (Random() < TestTradeProbability)
   {
      // Open random number of long orders distributed around given percentage.
      bool isLong = Random() <= TestTradePercentLong;
      return OrderOpenMarket(TestOrderLots, isLong, "Random entry");
   }

   return true;
}

bool TestTrendFollowingEntry()
{
   // TODO
}

bool TestCounterTrendEntry()
{
   // TODO
}

#endif
