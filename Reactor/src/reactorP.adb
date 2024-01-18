package body ReactorP is
   protected body ReactorTipo is

   procedure incrementar is
      begin
         temperatura:=temperatura+150;
      end incrementar;

      procedure decrementar is
      begin
         temperatura:=temperatura-50;
      end decrementar;

      procedure leer(dato: out Integer) is
      begin
         dato:=temperatura;
      end leer;

      procedure abrir is
      begin
         --activamos el timer
         nextTime := tiempoActualizacion + Clock;
         Ada.Real_Time.Timing_Events.Set_Handler(control, nextTime, Timer'Access);
      end abrir;

      procedure cerrar is
      begin
         --desactivamos timer
         Ada.Real_Time.Timing_Events.Set_Handler(control, nextTime, NULL);
      end cerrar;


      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --si el timer esta activado va bajando la temperatura
         temperatura:= temperatura-50;
         nextTime:=nextTime + tiempoActualizacion;
         Ada.Real_Time.Timing_Events.Set_Handler(control, nextTime, Timer'Access);
      end Timer;
   end ReactorTipo;
end ReactorP;
