with System;
with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;
with ReactorP;
use ReactorP;

package ActuadorEscritorP is
   protected type ActuadorEscritor(reactor:Access ReactorTipo) is

      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure abrirCompuerta(numeroReactor:in Integer);
      procedure cerrarCompuerta(numeroReactor:in Integer);
   private
      --simulacion retardo de apertura de una decima
      retardo: Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(100);
      tiempo: Ada.Real_Time.Time;
      --true abierta false cerrada
      compuerta:Boolean:=False;

   end ActuadorEscritor;
end ActuadorEscritorP;
