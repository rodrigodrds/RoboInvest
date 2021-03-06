//+------------------------------------------------------------------+
//|                                     Suporte e Resistencia EA.mq5 |
//|                                                     Rodrigo Dias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Rodrigo Dias"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Indicators\Custom.mqh>
#include <Indicators\TimeSeries.mqh>
#include <Trade\Trade.mqh>

CiCustom supres;
CHighBuffer high;
CLowBuffer low;
CCloseBuffer close;
CTimeBuffer time;
CTrade trade;

datetime op_time;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   MqlParam params[1];
   params[0].type=TYPE_STRING;
   params[0].string_value="MaratonaTNT\\Suporte e Resistencia";
   supres.Create(_Symbol, _Period, IND_CUSTOM, 1, params);
   supres.AddToChart(0,0);

   high.SetSymbolPeriod(_Symbol,_Period);
   close.SetSymbolPeriod(_Symbol,_Period);
   low.SetSymbolPeriod(_Symbol,_Period);
   time.SetSymbolPeriod(_Symbol,_Period);

   if(AccountInfoInteger(ACCOUNT_TRADE_MODE)==ACCOUNT_TRADE_MODE_REAL && !MQLInfoInteger(MQL_TESTER))
     {
      Alert("Não usar em conta real");
      return INIT_FAILED;
     }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   supres.Refresh();
   high.Refresh();
   low.Refresh();
   close.Refresh();
   time.Refresh();

   double sup = supres.GetData(1,0);   //Suporte
   double res = supres.GetData(0,0);   //Resistencia
   double c = close.At(0);           //Fechamento da Barra Atual
   double h = high.At(-1);            //Maxima da Barra Anterior
   double l = low.At(-1);             //Minima da Barra Anterior

   if(!PositionSelect(_Symbol))
     {
     //Print(c + "" + h );
      if(c>sup && c<res && op_time!=time.At(0)) //Preço está entre o suporte e resistencia e não foi feita uma entrada nesta barra
        {
         if(c>h && l<=sup) //Preço atual rompeu a maxima anteriror e a minima anterior tocou o suporte
           {
            trade.Buy(1,_Symbol);        //Compra
            op_time=time.At(0);            //Registra o horario da operação
           }
         else if(c<l && h>=res) //Preço atual rompeu a minima anterior e a maxima anterior tocou a resistencia
           {
            trade.Sell(1,_Symbol);       //Vende
            op_time=time.At(0);           //Registra o horario da operação
           }
        }
     }
   else
     {
      if(c>=res || c<=sup) //Fechamento da Barra Atual(ultimo negocio) tocou a resistencia ou o suporte
        {
         trade.PositionClose(_Symbol);    //Fecha a posição
        }
     }
  }
//+------------------------------------------------------------------+
