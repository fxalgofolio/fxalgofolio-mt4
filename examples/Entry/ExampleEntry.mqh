
sinput int ExampleEntryLots = 1.0;
extern int ExampleEntryPeriod = 10;

bool ExampleEntry()
{
   double rsi = iRSI(SystemSymbol, SystemPeriod, ExampleEntryPeriod, PRICE_CLOSE, 1);
   if (rsi >= 70)
   {
      return OrderMarketOpen(ExampleEntryLots, false, 0, 0, "Example entry");
   }
   else if (rsi <= 30)
   {
      return OrderMarketOpen(ExampleEntryLots, true, 0, 0, "Example entry");
   }

   return true;
}
