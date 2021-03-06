//+------------------------------------------------------------------+
//|                                             Medias Moveis EA.mq5 |
//|                                                     Rodrigo Dias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Rodrigo Dias"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Indicators\Custom.mqh>
#include <Indicators\TimeSeries.mqh>
#include <Trade\Trade.mqh>

//--- input parameters
input int      StopLoss=30;      // Stop Loss
input int      TakeProfit=100;   // Take Profit
input int      MA_Fast=17;     // ADX Period
input int      MA_Slow=72;      // Moving Average Period
input double   Lot=0.1;          // Lots to Trade

//--- Other parameters
int zigzag;
int maFastHandle;
int maSlowHandleM1;
int maSlowHandleM5;
int maSlowHandleM15;

//double zz[];

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   //maFastHandle=iMA(NULL,0,MA_Fast,0,MODE_EMA,PRICE_CLOSE);
   maSlowHandleM1=iMA(NULL,0,MA_Slow,PERIOD_M1,MODE_EMA,PRICE_CLOSE);
   maSlowHandleM5=iMA(NULL,0,MA_Slow,0,MODE_EMA,PRICE_CLOSE);
   maSlowHandleM15=iMA(NULL,0,MA_Slow,PERIOD_M15,MODE_EMA,PRICE_CLOSE);
   
   //zigzag = iCustom(NULL,0,"Examples\\Custom Moving Average", 17,0, MODE_SMA, PRICE_CLOSE);
   //SetIndexBuffer(0,zz,INDICATOR_DATA); 
   zigzag = iCustom(NULL, 0, "zigzag");
   
   //MqlParam params[1];
   //params[0].type=TYPE_STRING;
   //params[0].string_value="zigzag";
   //zigzag.Create(_Symbol, _Period, IND_CUSTOM, 1, params);
   //zigzag.AddToChart(0,0);    
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   IndicatorRelease(zigzag);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   //maSlowHandleM1.Refresh();
   //maSlowHandleM5.Refresh();
   //maSlowHandleM15.Refresh();
   //zigzag.Refresh();
   
   //double maM1 = maSlowHandleM1.At(0);
   //double maM5 = maSlowHandleM5.At(0);
   //double maM15 = maSlowHandleM15.At(0);
   double zz[];
   CopyBuffer(zigzag,0,0,1,zz);
   //zz = zigzag.At(0);
   
   //double Ask,Bid;
   //int Spread;
   //Ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   //Bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   //Spread=SymbolInfoInteger(Symbol(),SYMBOL_SPREAD);
   //string comment=StringFormat("Imprimindo preços:\nAsk = %G\nBid = %G\nSpread = %d",Ask,Bid,Spread);
   //string comment = StringFormat("%G %G %G",maM1,maM5,maM15,zz);
   Print(zz[0]);
   //Alert(zz[0]);
   string comment = StringFormat("%G ",1020);//zz[0]);
   ChartSetString(0,CHART_COMMENT,comment);
  }
//+------------------------------------------------------------------+
