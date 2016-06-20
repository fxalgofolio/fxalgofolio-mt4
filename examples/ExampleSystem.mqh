
#include <FXAlgoFolio/TestMode.mqh>
#include "Entry/ExampleEntry.mqh"
#include "Exit/ExampleExit.mqh"

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
