
extern int ExampleEntryPeriod = 10;

bool ExampleEntry()
{
   double rsi = iRSI(SystemSymbol, SystemPeriod, ExampleEntryPeriod, PRICE_CLOSE, 1);
   if (rsi >= 80)
   {
      return OrderMarketOpen(TestOrderLots, false, 0, 0, "Example entry");
   }
   else if (rsi <= 20)
   {
      return OrderMarketOpen(TestOrderLots, true, 0, 0, "Example entry");
   }

   return true;
}
