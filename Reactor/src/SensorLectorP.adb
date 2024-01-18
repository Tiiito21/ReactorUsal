package body SensorLectorP is

      protected body SensorLector is
      procedure iniciar is
      begin
         datoDisponible:=False;
         nextTime:=Clock+entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end iniciar;

      entry leer(temperatura:out Integer; reactor: access ReactorTipo)
        when datoDisponible is
      begin
         reactor.leer(temperatura);
         datoDisponible:=False;
      end leer;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         datoDisponible:=True;
         nextTime:=nextTime+entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end Timer;

   end SensorLector;
end SensorLectorP;
