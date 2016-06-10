#ifndef FXALGOFOLIO_UTIL_ORDER
#define FXALGOFOLIO_UTIL_ORDER

#define SLIPPAGE_POINTS 5*SystemPipSize

sinput int OrderMagic = 1010101;

bool SelectOpenOrder()
{
   for (int i = OrdersTotal() - 1; i >= 0; i--)
   {
      if (OrderSelect(i, SELECT_BY_POS))
      {
         if (OrderMagicNumber() == OrderMagic && OrderOpenTime() != 0 && OrderCloseTime() == 0)
         {
            return true;
         }
      }
   }

   return false;
}

bool OrderMarketOpen(double lots, bool isLong, double stopLoss, double takeProfit, string comment)
{
   int cmd = isLong ? OP_BUY : OP_SELL;
   double openPrice = isLong ? Ask : Bid;

   int ticket = OrderSend(SystemSymbol, cmd, lots, openPrice, SLIPPAGE_POINTS, stopLoss, takeProfit, comment, OrderMagic, 0, CLR_NONE);
   // TODO Print debug message.
   return ticket != -1;
}

bool OrderMarketModify(double stopLoss, double takeProfit)
{
   return OrderModify(OrderTicket(), OrderOpenPrice(), stopLoss, takeProfit, 0, CLR_NONE);
}

bool OrderMarketClose()
{
   double closePrice = OrderIsLong() ? Bid : Ask;
   return OrderClose(OrderTicket(), OrderLots(), closePrice, SLIPPAGE_POINTS, CLR_NONE);
}

bool OrderIsLong()
{
   int type = OrderType();
   return (type == OP_BUY) || (type == OP_BUYLIMIT) || (type == OP_BUYSTOP);
}

int OrderBarsSinceOpen()
{
   return iBarShift(SystemSymbol, SystemPeriod, OrderOpenTime());
}

#endif
