#ifndef FXALGOFOLIO_UTIL_BASE
#define FXALGOFOLIO_UTIL_BASE

#define DEFAULT_START_DATE D'2009.01.01 00:00'

#property strict

#include "Lock.mqh"
#include "Order.mqh"

sinput string SystemSymbol = "EURUSD";
sinput ENUM_TIMEFRAMES SystemPeriod = PERIOD_H1;

int SystemPipSize;
double SystemPipValue;

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
   LockInit();

   // Detect pip size.
   int digits = Digits();
   SystemPipSize = (digits == 3 || digits == 5) ? 10 : 1;
   Print("Pip size is ", SystemPipSize, " points.");
   SystemPipValue = Point() * SystemPipSize;

   return INIT_SUCCEEDED;
}

void OnTick()
{
   if (!IsConnected() || IsStopped() || !IsTradeAllowed())
   {
      return;
   }

   // Set up system bar.
   static datetime lastBar;
   datetime newBar = iTime(SystemSymbol, SystemPeriod, 0);
   if (lastBar == 0)
   {
      lastBar = newBar;
   }

   // Run system.
   if (lastBar != newBar && LockAcquire())
   {
      // Update dynamic parameters.
      DoSystemSetExterns();

      bool error = false;

      if (!SelectOpenOrder() && !DoSystemEntry())
      {
         error = true;
         Alert("Failed to enter trade.");
      }

      if (SelectOpenOrder() && !DoSystemExit())
      {
         error = true;
         Alert("Failed to exit trade.");
      }

      if (!error)
      {
         lastBar = newBar;
      }

      LockRelease();
   }
}

double Random(double max)
{
   return max * MathRand() / 32768;
}

double Random()
{
   return Random(1);
}

#endif
