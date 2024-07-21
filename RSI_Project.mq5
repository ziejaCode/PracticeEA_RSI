//+------------------------------------------------------------------+
//|                                                  RSI_Project.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 20233, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"


int handleATR;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   Print("This is just a test");
   handleATR = iATR(Symbol(),PERIOD_CURRENT,14);
   Print("This is symbol ",Symbol());
   Print("This is period_current ", PERIOD_CURRENT);

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Print("This is just a test for a ", reason, " ... ");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   Print("This is just ");

  }
//+------------------------------------------------------------------+
