with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
with System;
use Ada.Real_Time;
use Ada.Real_Time.Timing_Events;
with Ada.Numerics.Discrete_Random;

with ReactorP;
use ReactorP;
with ActuadorEscritorP;
use ActuadorEscritorP;
with SensorLectorP;
use SensorLectorP;


procedure Main is

   --el rango es de 1 a 3
   subtype AleatorioReactor is Integer range 1..3;
   package Aleatorio is new Ada.Numerics.Discrete_Random(AleatorioReactor);
   Seed : Aleatorio.Generator;
   type arrayReactores is array (1..3) of aliased ReactorTipo;
   reactores: aliased arrayReactores;



 --comprueba funcionamiento correcto de los tres reactores
   task type Coordinador is
      entry vivo;
   end Coordinador;
   task body Coordinador is
   begin
      --delay inicial
      delay 5.0;
      loop
         select
            accept vivo do
               null;
            end vivo;
         or
            delay 3.0;  -- TIMEOUT tras 3 secs
            Text_IO.Put_Line("Alerta. No se recibio ningun mensaje en 3 segundos");
         end select;
      end loop;
   end Coordinador;


 --incrementa la temperatura de un reactor aleatorio cada 2 segunds (muestreo)
   task type ControlTemperatura(reactors: Access arrayReactores);
   task body ControlTemperatura is
      nextIncremento:Ada.Real_Time.Time_Span:=Ada.Real_Time.Seconds(2);
      nextTime:Ada.Real_Time.Time;
      nReactor:Integer;
   begin
      Aleatorio.reset(seed);
      nextTime:=Clock+nextIncremento;
      loop
         --elige el reactor aleatoriamente
         nReactor:=Aleatorio.Random(seed);
         --Incrementa el reactor elegido
         reactors(nReactor).incrementar;
         Text_IO.Put_Line("Se incrementa la temperatura del Reactor: " & Integer'Image(nReactor));
         delay until nextTime;
         nextTime:=nextTime+nextIncremento;
      end loop;
   end ControlTemperatura;


   --tarea para cada reactor
   task type ControlReactor(reactor: Access ReactorTipo;numeroReactor:Integer);
   task body ControlReactor is
      --creamos instancias de cada elemento
      sensorReactor:  SensorLector;
      actuadorReactor: ActuadorEscritor(reactor);
      temperaturaReactor:Integer;
      muestreo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(2000);
      nextTime:Ada.Real_Time.Time;
      coord:Coordinador;
   begin
      nextTime:=Clock+muestreo;
      sensorReactor.iniciar;
      loop
	sensorReactor.leer(temperaturaReactor, reactor);
            Text_IO.Put_Line("La temperatura del reactor " & Integer'Image(numeroReactor)  & " es de: " &  Integer'Image(temperaturaReactor));
         if temperaturaReactor>=1750 then
            	Text_IO.Put_Line("      La temperatura del reactor " & Integer'Image(numeroReactor) & " ha superado los 1750º!!");
         elsif temperaturaReactor>=1500 then
                actuadorReactor.abrirCompuerta(numeroReactor);
         elsif temperaturaReactor<1500 then
                actuadorReactor.cerrarCompuerta(numeroReactor);
         end if;
	--mensaje algun reactor vivo
        coord.vivo;
	 nextTime:=nextTime+muestreo;
	 delay until nextTime;
      end loop;

   end ControlReactor;


   temperatura:ControlTemperatura(reactores'Access);

  --creamos los 3 reactores
   reactor1:ControlReactor(reactores(1)'Access,1);
   reactor2:ControlReactor(reactores(2)'Access,2);
   reactor3:ControlReactor(reactores(3)'Access,3);
begin
   null;
end Main;





