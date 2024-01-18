with System;
with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;



package ReactorP is
   protected type ReactorTipo is

      --procedures
      procedure incrementar;
      procedure decrementar;
      procedure abrir;
      procedure cerrar;
      procedure leer(dato:out Integer);
      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event);

      private
      --valor inicial 1450º
      temperatura:Integer:=1450;
      nextTime:Ada.Real_Time.Time;
      tiempoActualizacion:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1000);
      control:Ada.Real_Time.Timing_Events.Timing_Event;
   end ReactorTipo;
end ReactorP;
