#ifndef FXALGOFOLIO_UTIL_TEST
#define FXALGOFOLIO_UTIL_TEST

sinput datetime TestStartDate;
sinput double TestOrderLots = 1.0;
sinput double TestTradeProbability = 0.5;
sinput double TestTradePercentLong = 0.5;
sinput double TestHoldBars = 5;
sinput int TestHoldPips = 20;

#define TEST_BREAKOUT_PERIOD 20
#define TEST_RSI_PERIOD 14

bool TestRandomExit()
{
   // Close after a random number of bars distributed around given count.
   if (OrderBarsSinceOpen() >= Random(2 * TestHoldBars))
   {
      return OrderMarketClose();
   }

   return true;
}

bool TestFixedBarExit()
{
   if (OrderBarsSinceOpen() >= TestHoldBars)
   {
      return OrderMarketClose();
   }

   return true;
}

bool TestFixedLevelExit()
{
   double stopLoss = OrderStopLoss();
   double takeProfit = OrderTakeProfit();

   if (stopLoss == 0 || takeProfit == 0)
   {
      int direction = OrderIsLong() ? 1 : -1;
      double holdPipsDist = direction * TestHoldPips * SystemPipValue;

      if (stopLoss == 0)
      {
         stopLoss = OrderOpenPrice() - holdPipsDist;
      }

      if (takeProfit == 0)
      {
         takeProfit = OrderOpenPrice() + holdPipsDist;
      }

      return OrderMarketModify(stopLoss, takeProfit);
   }

   return true;
}

bool TestRandomEntry()
{
   // Open randomly at given probability.
   if (Random() < TestTradeProbability)
   {
      // Open random number of long orders distributed around given percentage.
      bool isLong = Random() <= TestTradePercentLong;
      return OrderMarketOpen(TestOrderLots, isLong, 0, 0, "Random entry");
   }

   return true;
}

bool TestTrendFollowingEntry()
{
   double high = iHighest(SystemSymbol, SystemPeriod, MODE_HIGH, TEST_BREAKOUT_PERIOD, 2);
   double low = iLowest(SystemSymbol, SystemPeriod, MODE_LOW, TEST_BREAKOUT_PERIOD, 2)
   if (iHigh(SystemSymbol, SystemPeriod, 1) >= high)
   {
      return OrderMarketOpen(TestOrderLots, true, 0, 0, "Test breakout entry");
   }
   else if (iLow(SystemSymbol, SystemPeriod, 1) <= low)
   {
      return OrderMarketOpen(TestOrderLots, false, 0, 0, "Test breakout entry");
   }

   return true;
}

bool TestCounterTrendEntry()
{
   double rsi = iRSI(SystemSymbol, SystemPeriod, TEST_RSI_PERIOD, PRICE_CLOSE, 1);
   double rsiPrev = iRSI(SystemSymbol, SystemPeriod, TEST_RSI_PERIOD, PRICE_CLOSE, 2);

   if (rsiPrev >= 80 && rsi < rsiPrev)
   {
      return OrderMarketOpen(TestOrderLots, false, 0, 0, "Test reversal entry");
   }
   else if (rsiPrev <= 20 && rsi > rsiPrev)
   {
      return OrderMarketOpen(TestOrderLots, true, 0, 0, "Test reversal entry");
   }

   return true;
}

#endif
