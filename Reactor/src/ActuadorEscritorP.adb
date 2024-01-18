package body ActuadorEscritorP is
     protected body ActuadorEscritor is

      procedure abrirCompuerta(numeroReactor:in Integer) is
      begin
           if compuerta = False then
		tiempo:=Clock+retardo;
		Text_IO.Put_Line("Abrimos Compuerta del reactor " & Integer'Image(numeroReactor));
		delay until tiempo;
		reactor.abrir;
                Text_IO.Put_Line("Compuerta Abierta");
                compuerta:=True;
           end if;
      end abrirCompuerta;

      procedure cerrarCompuerta(numeroReactor:in Integer) is
      begin
         if compuerta = True then
         	tiempo:=Clock+retardo;
		Text_IO.Put_Line("Cerramos Compuerta del reactor " & Integer'Image(numeroReactor));
                delay until tiempo; --delay de cierre
                reactor.cerrar;
                Text_IO.Put_Line("Compuerta Cerrada");
                compuerta:=False;
         end if;
      end cerrarCompuerta;

   end ActuadorEscritor;

end ActuadorEscritorP;
