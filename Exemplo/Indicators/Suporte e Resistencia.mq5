//+------------------------------------------------------------------+
//|                                        Suporte e Resistencia.mq5 |
//|                                                     Rodrigo Dias |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Rodrigo Dias"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2
//--- plot Resistencia
#property indicator_label1  "Resistencia"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_DASH
#property indicator_width1  2
//--- plot Suporte
#property indicator_label2  "Suporte"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrBlue
#property indicator_style2  STYLE_DASH
#property indicator_width2  2
//--- indicator buffers
double         ResistenciaBuffer[];
double         SuporteBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,ResistenciaBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,SuporteBuffer,INDICATOR_DATA);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   int i;
   for(i=2; i<rates_total - 2; i++){
      if(high[i]>high[i+1] && high[i]>high[i+2] && high[i]>high[i-1] && high[i]>high[i-2]){
         ResistenciaBuffer[i]=high[i];
      }else{
         ResistenciaBuffer[i]=ResistenciaBuffer[i-1];
      }
      if (low[i]<low[i+1] && low[i]<low[i+2] && low[i]<low[i-1] && low[i]<low[i-2] ){
         SuporteBuffer[i]=low[i];
      }else{
         SuporteBuffer[i]=SuporteBuffer[i-1];   
      }
   }
   for( ; i<rates_total; i++){
      ResistenciaBuffer[i]=ResistenciaBuffer[i-1];
      SuporteBuffer[i]=SuporteBuffer[i-1];
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
