#ifndef FXALGOFOLIO_WALKFORWARDMODE
#define FXALGOFOLIO_WALKFORWARDMODE

#define FXALGOFOLIO_INIT_EXTRA WalkForwardInit

#include "Util/Base.mqh"

enum PeriodUnit
{
   Period_Day, // Day
   Period_Week, // Week
   Period_Month, // Month
};

sinput datetime WalkForwardStart = DEFAULT_START_DATE;
sinput PeriodUnit WalkForwardPeriod = Period_Month;
sinput int WalkForwardPeriodIn = 12;
sinput int WalkForwardPeriodOut = 3;
input int WalkForwardPeriodOffset = 0;

datetime segmentStart;
datetime segmentEnd;

void WalkForwardInit()
{
   // Set up test interval.
   int unitInterval = 86400;

   switch (WalkForwardPeriod)
   {
      case Period_Week:
         unitInterval *= 7;
      case Period_Day:
         segmentStart = WalkForwardStart + WalkForwardPeriodOffset * WalkForwardPeriodOut * unitInterval;
         segmentEnd = segmentStart + WalkForwardPeriodIn * unitInterval;
         break;

      case Period_Month:
         MqlDateTime startStruct;
         TimeToStruct(WalkForwardStart, startStruct);
         int year = startStruct.year;
         int month = startStruct.mon;
         int day = startStruct.day;

         month += WalkForwardPeriodOffset * WalkForwardPeriodOut;
         year += (month - 1) / 12;
         month %= 12;
         segmentStart = StringToTime(StringFormat("%04d.%02d.%02d", year, month, day));

         month += WalkForwardPeriodIn;
         year += (month - 1) / 12;
         month %= 12;
         segmentEnd = StringToTime(StringFormat("%04d.%02d.%02d", year, month, day));
         break;
   }
}

bool DoSystemEntry()
{
   datetime now = TimeCurrent();
   if (now >= segmentStart && now < segmentEnd)
   {
      return SystemEntry();
   }
}

bool DoSystemExit()
{
   return SystemExit();
}

void DoSystemSetExterns()
{
   // Leave parameters alone for walk-forward testing.
}

#endif
