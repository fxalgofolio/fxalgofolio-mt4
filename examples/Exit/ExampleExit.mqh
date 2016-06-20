
extern int ExampleExitTrail = 10;

bool ExampleExit()
{
   int direction = OrderIsLong() ? 1 : -1;
   double stopLoss = Bid - (direction * ExampleExitTrail * SystemPipValue);
   return OrderMarketModify(stopLoss, 0);
}
