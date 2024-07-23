//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

#property copyright "Copyright 20233, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <trade/trade.mqh>

input ENUM_TIMEFRAMES Timeframe = PERIOD_H1;
input int AtrPeriod = 14;
input double TrigerFactor = 2.5;
input double Lots = 0.1;
input double TPPoints = 200;
input double SLPoints = 200;


int handleATR;
CTrade trade;
int barsTotal;


// this is for debugging purpose.
int buycount;
int sellcount;
int Startbuycount;
int Startsellcount;
int noTradecount;
int StartTradecount;


// test


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

// Debugging
   Print("This is just a test");


   handleATR = iATR(NULL,Timeframe,AtrPeriod);
   barsTotal = iBars(NULL, Timeframe);

   buycount = 0;
   sellcount = 0;
   noTradecount =0;

   Startbuycount = buycount;
   Startsellcount = sellcount;
   StartTradecount = noTradecount;

   Print("Start buy count is - ",Startbuycount);
   Print("Start sell count is - ",Startsellcount);
   Print("Start noTradecount count is - ",StartTradecount);


   return(INIT_SUCCEEDED);



  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print("Start buy count is - ", Startbuycount);
   Print("Start sell count is - ", Startsellcount);
   Print("Start noTradecount count is - ", StartTradecount);

   Print("Final buy count is - ", buycount);
   Print("Final sell count is - ", sellcount);
   Print("Final noTradecount count is - ", noTradecount);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {


// This is for checking if there is new bar to take
   int bars = iBars(NULL, Timeframe);

   if(bars != barsTotal)
     {
      barsTotal = bars;

      // declare array to be filled with bars data
      double atr[];

      CopyBuffer(handleATR,0,1,1,atr);

      double open = iOpen(NULL,Timeframe,1);
      double close = iClose(NULL,Timeframe,1);



      if(open < close && close - open > atr[0]*TrigerFactor)
        {
         buycount++;

         double entry = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
         entry = NormalizeDouble(entry,_Digits);

         double tp = entry + TPPoints * _Point;
         tp = NormalizeDouble(tp,_Digits);

         double sl = entry - SLPoints * _Point;
         sl = NormalizeDouble(sl,_Digits);

         trade.Buy(Lots,NULL,entry,sl,tp);

         Print("buy signal - ",buycount);
        }
      if(open > close && open - close > atr[0]*TrigerFactor)
        {
         sellcount++;

         double entry = SymbolInfoDouble(_Symbol,SYMBOL_BID);
         entry = NormalizeDouble(entry,_Digits);

         double tp = entry - TPPoints * _Point;
         tp = NormalizeDouble(tp,_Digits);

         double sl = entry + SLPoints * _Point;
         sl = NormalizeDouble(sl,_Digits);

         trade.Sell(Lots,NULL,entry,sl,tp);

         Print("sell signal - ",sellcount);
        }
      else
        {
         noTradecount++;
         Print("noTrade signal - ",noTradecount);
        }
     }
  }


//+------------------------------------------------------------------+
