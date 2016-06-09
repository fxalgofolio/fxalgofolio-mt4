#ifndef FXALGOFOLIO_UTIL_BASE
#define FXALGOFOLIO_UTIL_BASE

#include "Util/Lock.mqh"
#include "Util/Order.mqh"

sinput string SystemSymbol = "EURUSD";
sinput ENUM_TIMEFRAMES SystemPeriod = PERIOD_H1;

int OnInit()
{
   if (!SymbolSelect(SystemSymbol, true))
   {
      Print("Failed to select the specified symbol: ", SystemSymbol);
      return INIT_FAILED;
   }

   // Set up for MT4.
#ifdef FXALGOFOLIO_INIT_EXTRA
   FXALGOFOLIO_INIT_EXTRA();
#else
   MathSrand(GetTickCount());
#endif

   // TODO Detect pip size.

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
