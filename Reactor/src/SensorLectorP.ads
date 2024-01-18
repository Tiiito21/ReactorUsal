with System;
with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;

with ReactorP;
use ReactorP;

package SensorLectorP is

   protected type SensorLector is
      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      entry leer(temperatura:out Integer; reactor: access ReactorTipo);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);

   private

      nextTime:Ada.Real_Time.Time;
      leyendo:Integer;
      datoDisponible:Boolean:=True;

     entradaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;
     entradaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(380);

   end SensorLector;

end SensorLectorP;
