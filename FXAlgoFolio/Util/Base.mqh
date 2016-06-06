#ifndef FXALGOFOLIO_UTIL_BASE
#define FXALGOFOLIO_UTIL_BASE

input string SystemSymbol = "EURUSD";
input ENUM_TIMEFRAMES SystemPeriod = PERIOD_H1;
sinput int OrderMagic = 1010101;

int OnInit()
{
   if (!SymbolSelect(SystemSymbol, true))
   {
      Print("Failed to select the specified symbol: ", SystemSymbol);
      return INIT_FAILED;
   }

   return INIT_SUCCEEDED;
}

void OnTick()
{
   // Set up system bar.
   static datetime lastBar;
   datetime newBar = iTime(SystemSymbol, SystemPeriod, 0);
   if (lastBar == 0)
   {
      lastBar = newBar;
   }

   // Run system.
   if (lastBar != newBar)
   {
      // TODO Acquire trading lock.

      // Run bar.
      lastBar = newBar;
      OnSystemBar();
   }
}

#endif
