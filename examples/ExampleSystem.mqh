
#include <FXAlgoFolio/TestMode.mqh>
#include "ExampleEntry.mqh"
#include "ExampleExit.mqh"

void SystemSetExterns()
{
   // No walk-forward parameters.
}

bool SystemEntry()
{
   return ExampleEntry();
}

bool SystemExit()
{
   return ExampleExit();
}
